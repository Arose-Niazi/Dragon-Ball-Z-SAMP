/*  DBZ / players / training.inc  —  training challenges (real obstacles, not a button)
 *
 *  /train opens the menu. Challenges run in the Training Zone and award XP:
 *    1. FLIGHT COURSE  — race through 8 sky rings; faster = more XP
 *    2. METEOR DODGE   — survive 40s of raining blasts; XP scales with HP kept
 *    3. KI CONTROL     — hold your Ki inside a target band for 12s total
 */
#if defined _dbz_training_included
    #endinput
#endif
#define _dbz_training_included

#define TRAIN_NONE      0
#define TRAIN_FLIGHT    1
#define TRAIN_METEOR    2
#define TRAIN_KI        3

#define TRAIN_COOLDOWN  30      // seconds between challenges

static tMode[MAX_PLAYERS];
static tTick[MAX_PLAYERS];          // seconds elapsed in challenge
static tCP[MAX_PLAYERS];            // flight: current checkpoint index
static tStart[MAX_PLAYERS];         // flight: start time
static Float:tStartHP[MAX_PLAYERS]; // meteor: HP at start
static tTarget[MAX_PLAYERS];        // ki: target percentage
static tHold[MAX_PLAYERS];          // ki: cumulative seconds in band
static Float:tRet[MAX_PLAYERS][3];  // return position
static tRetInt[MAX_PLAYERS];

// flight rings above the Training Zone
static const Float:gFlightCP[8][3] =
{
    {-60.0,  -5.0, 20.0},
    {-20.0,  20.0, 30.0},
    { 20.0,   0.0, 40.0},
    { 40.0, -40.0, 35.0},
    {  0.0, -70.0, 30.0},
    {-40.0, -60.0, 25.0},
    {-70.0, -30.0, 20.0},
    {-60.0,  -5.0, 12.0}
};

Training_Reset(playerid)
{
    tMode[playerid] = TRAIN_NONE;
    tTick[playerid] = 0;
    tCP[playerid]   = 0;
    tHold[playerid] = 0;
    return 1;
}

bool:Training_Active(playerid)
{
    return (tMode[playerid] != TRAIN_NONE);
}

ShowTrainingDialog(playerid)
{
    if (Training_Active(playerid))
        return SendClientMessage(playerid, COLOR_GREY, "You are already training! (/stoptrain to give up)");
    if (gPlayer[playerid][pTrainCd] > 0)
    {
        new m[80]; format(m, sizeof(m), "Catch your breath first - training again in %d sec.", gPlayer[playerid][pTrainCd]);
        return SendClientMessage(playerid, COLOR_GREY, m);
    }
    ShowPlayerDialog(playerid, DIALOG_TRAIN, DIALOG_STYLE_LIST, "{FFFF00}Training Grounds",
        "Flight Course (8 sky rings, timed)\nMeteor Dodge (survive 40s of blasts)\nKi Control (hold your Ki in the band)",
        "Train", "Cancel");
    return 1;
}

Training_Start(playerid, mode)
{
    if (mode == TRAIN_KI && IsAndroid(playerid))
        return SendClientMessage(playerid, COLOR_GREY, "Androids have no Ki to control - pick another exercise.");
    if (mode == TRAIN_FLIGHT && !gPlayer[playerid][pFlying])
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tip: press Y to fly!");

    // remember where they came from
    GetPlayerPos(playerid, tRet[playerid][0], tRet[playerid][1], tRet[playerid][2]);
    tRetInt[playerid] = GetPlayerInterior(playerid);

    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, -60.0, -5.0, 3.5);

    tMode[playerid] = mode;
    tTick[playerid] = 0;

    switch (mode)
    {
        case TRAIN_FLIGHT:
        {
            tCP[playerid]    = 0;
            tStart[playerid] = gettime();
            SetPlayerRaceCheckpoint(playerid, CP_TYPE_AIR_NORMAL,
                gFlightCP[0][0], gFlightCP[0][1], gFlightCP[0][2],
                gFlightCP[1][0], gFlightCP[1][1], gFlightCP[1][2], 6.0);
            GameTextForPlayer(playerid, "~b~FLIGHT COURSE~n~~w~Fly through the rings!", 4000, 3);
        }
        case TRAIN_METEOR:
        {
            GetPlayerHealth(playerid, tStartHP[playerid]);
            GameTextForPlayer(playerid, "~r~METEOR DODGE~n~~w~Survive 40 seconds - keep moving!", 4000, 3);
        }
        case TRAIN_KI:
        {
            tTarget[playerid] = 55 + random(30);
            tHold[playerid]   = 0;
            new m[128];
            format(m, sizeof(m), "~y~KI CONTROL~n~~w~Hold your Ki near %d%% for 12s~n~(charge with MMB, spend with ALT)", tTarget[playerid]);
            GameTextForPlayer(playerid, m, 5000, 3);
        }
    }
    return 1;
}

Training_Finish(playerid, xp, const result[])
{
    new m[128];
    format(m, sizeof(m), "~g~%s~n~~w~+%d XP", result, xp);
    GameTextForPlayer(playerid, m, 4000, 3);
    if (xp > 0) GiveCharXP(playerid, xp);

    DisablePlayerRaceCheckpoint(playerid);
    gPlayer[playerid][pTrainCd] = TRAIN_COOLDOWN;
    Training_Reset(playerid);

    SetPlayerInterior(playerid, tRetInt[playerid]);
    SetPlayerPos(playerid, tRet[playerid][0], tRet[playerid][1], tRet[playerid][2]);
    return 1;
}

Training_Abort(playerid)
{
    if (!Training_Active(playerid)) return 0;
    DisablePlayerRaceCheckpoint(playerid);
    Training_Reset(playerid);
    SendClientMessage(playerid, COLOR_GREY, "Training cancelled.");
    return 1;
}

// flight checkpoint progression (hooked from OnPlayerEnterRaceCheckpoint)
Training_OnRaceCP(playerid)
{
    if (tMode[playerid] != TRAIN_FLIGHT) return 0;

    tCP[playerid]++;
    new cp = tCP[playerid];
    if (cp >= sizeof(gFlightCP))
    {
        new elapsed = gettime() - tStart[playerid];
        new xp = 120 - 2 * elapsed;
        if (xp < 40) xp = 40;
        Training_Finish(playerid, xp, "COURSE COMPLETE!");
        return 1;
    }

    new nxt = (cp + 1 < sizeof(gFlightCP)) ? (cp + 1) : cp;
    if (cp == sizeof(gFlightCP) - 1)
        SetPlayerRaceCheckpoint(playerid, CP_TYPE_AIR_FINISH,
            gFlightCP[cp][0], gFlightCP[cp][1], gFlightCP[cp][2],
            gFlightCP[nxt][0], gFlightCP[nxt][1], gFlightCP[nxt][2], 6.0);
    else
        SetPlayerRaceCheckpoint(playerid, CP_TYPE_AIR_NORMAL,
            gFlightCP[cp][0], gFlightCP[cp][1], gFlightCP[cp][2],
            gFlightCP[nxt][0], gFlightCP[nxt][1], gFlightCP[nxt][2], 6.0);
    return 1;
}

// one tick per second (called from SecondTimer)
Training_Tick(playerid)
{
    switch (tMode[playerid])
    {
        case TRAIN_METEOR:
        {
            tTick[playerid]++;
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateExplosion(x + float(random(15)) - 7.0, y + float(random(15)) - 7.0, z, EXP_BIG, 5.0);
            if (tTick[playerid] % 2 == 0)
                CreateExplosion(x + float(random(11)) - 5.0, y + float(random(11)) - 5.0, z + 2.0, EXP_SMALL, 4.0);

            if (tTick[playerid] >= 40)
            {
                new Float:hp;
                GetPlayerHealth(playerid, hp);
                new Float:ratio = (tStartHP[playerid] > 0.0) ? (hp / tStartHP[playerid]) : 0.0;
                if (ratio < 0.0) ratio = 0.0; if (ratio > 1.0) ratio = 1.0;
                Training_Finish(playerid, 30 + floatround(70.0 * ratio), "SURVIVED THE METEOR STORM!");
            }
        }
        case TRAIN_KI:
        {
            tTick[playerid]++;
            new pct = (gPlayer[playerid][pKiMax] > 0.0) ? floatround(gPlayer[playerid][pKi] / gPlayer[playerid][pKiMax] * 100.0) : 0;
            if (pct >= tTarget[playerid] - 10 && pct <= tTarget[playerid] + 10)
            {
                tHold[playerid]++;
                new m[64]; format(m, sizeof(m), "~g~In the band! %d / 12s", tHold[playerid]);
                GameTextForPlayer(playerid, m, 900, 3);
                if (tHold[playerid] >= 12)
                    Training_Finish(playerid, 80, "PERFECT KI CONTROL!");
            }
            else if (tTick[playerid] % 5 == 0)
            {
                new m[80]; format(m, sizeof(m), "~y~Ki %d%% - target %d%% (+/-10)", pct, tTarget[playerid]);
                GameTextForPlayer(playerid, m, 900, 3);
            }
            if (tTick[playerid] >= 60 && tMode[playerid] == TRAIN_KI)
                Training_Finish(playerid, 15, "Time's up - keep practising!");
        }
    }
    return 1;
}
