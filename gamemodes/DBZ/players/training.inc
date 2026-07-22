/*  DBZ / players / training.inc  —  training challenges (5 types x 3 difficulty tiers)
 *
 *  /train picks a challenge, then a tier. Higher tiers are harder, pay more XP,
 *  and unlock with character level (Novice lvl 1, Advanced 15, Master 30).
 *    1. FLIGHT COURSE  — race through sky rings; faster = more XP
 *    2. METEOR DODGE   — survive raining blasts; XP scales with HP kept
 *    3. KI CONTROL     — hold your Ki inside a target band
 *    4. SPEED RUN      — sprint/dash between ground markers against the clock
 *    5. POWER STRIKES  — blast the marked targets with your attacks
 */
#if defined _dbz_training_included
    #endinput
#endif
#define _dbz_training_included

#define TRAIN_NONE      0
#define TRAIN_FLIGHT    1
#define TRAIN_METEOR    2
#define TRAIN_KI        3
#define TRAIN_SPEED     4
#define TRAIN_STRIKE    5

#define TRAIN_COOLDOWN  30      // seconds between challenges

static tMode[MAX_PLAYERS];
static tTier[MAX_PLAYERS];          // 0 novice / 1 advanced / 2 master
static tPending[MAX_PLAYERS];       // challenge picked, waiting for tier choice
static tTick[MAX_PLAYERS];
static tCP[MAX_PLAYERS];            // flight/speed/strike: current step
static tStart[MAX_PLAYERS];
static Float:tStartHP[MAX_PLAYERS];
static tTarget[MAX_PLAYERS];        // ki: target percentage
static tHold[MAX_PLAYERS];
static Float:tRet[MAX_PLAYERS][3];
static tRetInt[MAX_PLAYERS];

new const gTierLevel[3]        = {1, 15, 30};
new const Float:gTierMult[3]   = {1.0, 1.75, 2.5};

// flight rings above the Training Zone (spread scales with tier)
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

// ground markers for the speed run
static const Float:gSpeedCP[6][3] =
{
    {-30.0,  15.0, 3.2},
    { 15.0, -10.0, 3.2},
    {-10.0, -45.0, 3.2},
    {-75.0, -40.0, 3.2},
    {-85.0,   5.0, 3.2},
    {-55.0,  -5.0, 3.2}
};

// blast targets for power strikes
static const Float:gStrikeCP[9][3] =
{
    {-40.0,  10.0, 5.0},
    {  5.0,  -5.0, 7.0},
    {-15.0, -35.0, 5.0},
    {-60.0, -45.0, 6.0},
    {-80.0, -10.0, 5.0},
    {-30.0, -20.0, 9.0},
    { 10.0,  15.0, 6.0},
    {-70.0,  10.0, 7.0},
    {-45.0, -60.0, 5.0}
};

Training_Reset(playerid)
{
    tMode[playerid]    = TRAIN_NONE;
    tTier[playerid]    = 0;
    tPending[playerid] = TRAIN_NONE;
    tTick[playerid]    = 0;
    tCP[playerid]      = 0;
    tHold[playerid]    = 0;
    return 1;
}

bool:Training_Active(playerid)
{
    return (tMode[playerid] != TRAIN_NONE);
}

// tier-scaled step counts
static FlightSteps(tier)  { return (tier == 0) ? 6 : ((tier == 1) ? 7 : 8); }
static SpeedSteps(tier)   { return (tier == 0) ? 4 : ((tier == 1) ? 5 : 6); }
static StrikeSteps(tier)  { return (tier == 0) ? 5 : ((tier == 1) ? 7 : 9); }
static MeteorSecs(tier)   { return 40 + tier * 10; }

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
        "Flight Course (race the sky rings)\nMeteor Dodge (survive the storm)\nKi Control (hold the band)\nSpeed Run (ground dash circuit)\nPower Strikes (blast the targets)",
        "Pick", "Cancel");
    return 1;
}

Training_PickType(playerid, listitem)
{
    if (listitem < 0 || listitem > 4) return 0;
    tPending[playerid] = listitem + 1;

    new lvl = GetCharLevel(playerid), body[256], line[80];
    for (new t = 0; t < 3; t++)
    {
        static const names[3][12] = {"Novice", "Advanced", "Master"};
        if (lvl >= gTierLevel[t])
            format(line, sizeof(line), "{FFFFFF}%s (x%.2f XP)\n", names[t], gTierMult[t]);
        else
            format(line, sizeof(line), "{AFAFAF}%s [locked - level %d]\n", names[t], gTierLevel[t]);
        strcat(body, line);
    }
    ShowPlayerDialog(playerid, DIALOG_TRAIN_TIER, DIALOG_STYLE_LIST, "{FFFF00}Difficulty", body, "Train", "Back");
    return 1;
}

Training_PickTier(playerid, listitem)
{
    if (listitem < 0 || listitem > 2) return 0;
    if (GetCharLevel(playerid) < gTierLevel[listitem])
    {
        new m[96]; format(m, sizeof(m), "That difficulty unlocks at level %d - keep training!", gTierLevel[listitem]);
        return SendClientMessage(playerid, COLOR_RED, m);
    }
    return Training_Start(playerid, tPending[playerid], listitem);
}

Training_Start(playerid, mode, tier)
{
    if (mode == TRAIN_KI && IsAndroid(playerid))
        return SendClientMessage(playerid, COLOR_GREY, "Androids have no Ki to control - pick another exercise.");

    GetPlayerPos(playerid, tRet[playerid][0], tRet[playerid][1], tRet[playerid][2]);
    tRetInt[playerid] = GetPlayerInterior(playerid);

    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, -60.0, -5.0, 3.5);

    tMode[playerid] = mode;
    tTier[playerid] = tier;
    tTick[playerid] = 0;
    tCP[playerid]   = 0;

    SendClientMessage(playerid, COLOR_GREY, "Training: /stoptrain to give up at any time. Higher tiers pay more XP.");

    switch (mode)
    {
        case TRAIN_FLIGHT:
        {
            tStart[playerid] = gettime();
            new Float:radius = 7.0 - float(tier);   // tighter rings on higher tiers
            SetPlayerRaceCheckpoint(playerid, CP_TYPE_AIR_NORMAL,
                gFlightCP[0][0], gFlightCP[0][1], gFlightCP[0][2],
                gFlightCP[1][0], gFlightCP[1][1], gFlightCP[1][2], radius);
            GameTextForPlayer(playerid, "~b~FLIGHT COURSE~n~~w~Fly through the rings! (Y to fly)", 4000, 3);
            SendClientMessage(playerid, COLOR_YELLOW, "FLIGHT COURSE: Press Y to fly, then race through the red air rings in order.");
            SendClientMessage(playerid, COLOR_WHITE,  "Controls in flight: FIRE = up, AIM = down, SPRINT = boost. Faster time = more XP!");
        }
        case TRAIN_METEOR:
        {
            GetPlayerHealth(playerid, tStartHP[playerid]);
            new m[96]; format(m, sizeof(m), "~r~METEOR DODGE~n~~w~Survive %d seconds - keep moving!", MeteorSecs(tier));
            GameTextForPlayer(playerid, m, 4000, 3);
            SendClientMessage(playerid, COLOR_YELLOW, "METEOR DODGE: Explosions rain around you - SPRINT and keep moving, never stand still!");
            new m2[128]; format(m2, sizeof(m2), "Survive %d seconds. The more health you keep, the more XP you earn.", MeteorSecs(tier));
            SendClientMessage(playerid, COLOR_WHITE, m2);
        }
        case TRAIN_KI:
        {
            tTarget[playerid] = 55 + random(30);
            tHold[playerid]   = 0;
            new band = 10 - tier * 2, hold = 12 + tier * 4, m[144];
            format(m, sizeof(m), "~y~KI CONTROL~n~~w~Hold Ki near %d%% (+/-%d) for %ds~n~(charge MMB, spend ALT)", tTarget[playerid], band, hold);
            GameTextForPlayer(playerid, m, 5000, 3);
            new m2[144];
            format(m2, sizeof(m2), "KI CONTROL: Get your Ki bar to %d%% (+/-%d) and HOLD it there for %d seconds total.", tTarget[playerid], band, hold);
            SendClientMessage(playerid, COLOR_YELLOW, m2);
            SendClientMessage(playerid, COLOR_WHITE,  "Hold MMB to charge Ki up - tap ALT (ki blast) to burn Ki down. Watch the on-screen hints.");
        }
        case TRAIN_SPEED:
        {
            tStart[playerid] = gettime();
            SetPlayerCheckpoint(playerid, gSpeedCP[0][0], gSpeedCP[0][1], gSpeedCP[0][2], 3.0);
            GameTextForPlayer(playerid, "~g~SPEED RUN~n~~w~Race between the markers!", 4000, 3);
            SendClientMessage(playerid, COLOR_YELLOW, "SPEED RUN: Sprint to the red checkpoint marker; each one you reach reveals the next.");
            SendClientMessage(playerid, COLOR_WHITE,  "Stay on foot and be quick - faster circuit = more XP!");
        }
        case TRAIN_STRIKE:
        {
            tStart[playerid] = gettime();
            SetPlayerCheckpoint(playerid, gStrikeCP[0][0], gStrikeCP[0][1], gStrikeCP[0][2], 4.0);
            new m[112]; format(m, sizeof(m), "~r~POWER STRIKES~n~~w~Blast %d marked targets with your attacks!", StrikeSteps(tier));
            GameTextForPlayer(playerid, m, 4000, 3);
            new m2[144];
            format(m2, sizeof(m2), "POWER STRIKES: Fire your attack (FIRE key or /att) so the blast lands INSIDE the marker - %d targets.", StrikeSteps(tier));
            SendClientMessage(playerid, COLOR_YELLOW, m2);
            SendClientMessage(playerid, COLOR_WHITE,  "Aim your character at the marker before firing. Attack cooldown is 10s - line your shots up!");
        }
    }
    return 1;
}

Training_Finish(playerid, baseXp, const result[])
{
    new xp = floatround(float(baseXp) * gTierMult[tTier[playerid]]);
    new m[128];
    format(m, sizeof(m), "~g~%s~n~~w~+%d XP", result, xp);
    GameTextForPlayer(playerid, m, 4000, 3);
    if (xp > 0) GiveCharXP(playerid, xp);

    // each discipline permanently trains a specific stat for this character
    new tch = gPlayer[playerid][pCharacter];
    if (tch >= 0 && tch < MAX_CHARACTERS && tMode[playerid] != TRAIN_NONE)
    {
        new pts = tTier[playerid] + 1, sname[16], bool:has = true;
        new E_PROG:field;
        switch (tMode[playerid])
        {
            case TRAIN_STRIKE: { field = prTrStrike; sname = "Attack"; }
            case TRAIN_METEOR: { field = prTrGuard;  sname = "Defense"; }
            case TRAIN_FLIGHT: { field = prTrFlight; sname = "Flight Speed"; }
            case TRAIN_SPEED:  { field = prTrSpeed;  sname = "Attack Speed"; }
            case TRAIN_KI:     { field = prTrKi;     sname = "Ki Power"; }
            default:           { has = false; }
        }
        if (has)
        {
            new nv = AddTrainStat(playerid, tch, field, pts), sm[96];
            format(sm, sizeof(sm), "Trained %s: +%d (now %d/%d)", sname, pts, nv, TRAIN_STAT_CAP);
            SendClientMessage(playerid, COLOR_GREEN, sm);
        }
    }

    DisablePlayerRaceCheckpoint(playerid);
    DisablePlayerCheckpoint(playerid);
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
    DisablePlayerCheckpoint(playerid);
    Training_Reset(playerid);
    SendClientMessage(playerid, COLOR_GREY, "Training cancelled.");
    return 1;
}

// flight ring progression (OnPlayerEnterRaceCheckpoint)
Training_OnRaceCP(playerid)
{
    if (tMode[playerid] != TRAIN_FLIGHT) return 0;

    tCP[playerid]++;
    new cp = tCP[playerid], steps = FlightSteps(tTier[playerid]);
    if (cp >= steps)
    {
        new elapsed = gettime() - tStart[playerid];
        new xp = 120 - 2 * elapsed;
        if (xp < 40) xp = 40;
        Training_Finish(playerid, xp, "COURSE COMPLETE!");
        return 1;
    }

    new Float:radius = 7.0 - float(tTier[playerid]);
    new nxt = (cp + 1 < steps) ? (cp + 1) : cp;
    if (cp == steps - 1)
        SetPlayerRaceCheckpoint(playerid, CP_TYPE_AIR_FINISH,
            gFlightCP[cp][0], gFlightCP[cp][1], gFlightCP[cp][2],
            gFlightCP[nxt][0], gFlightCP[nxt][1], gFlightCP[nxt][2], radius);
    else
        SetPlayerRaceCheckpoint(playerid, CP_TYPE_AIR_NORMAL,
            gFlightCP[cp][0], gFlightCP[cp][1], gFlightCP[cp][2],
            gFlightCP[nxt][0], gFlightCP[nxt][1], gFlightCP[nxt][2], radius);
    return 1;
}

// ground marker progression (OnPlayerEnterCheckpoint) — speed run only
Training_OnGroundCP(playerid)
{
    if (tMode[playerid] != TRAIN_SPEED) return 0;

    tCP[playerid]++;
    new cp = tCP[playerid], steps = SpeedSteps(tTier[playerid]);
    if (cp >= steps)
    {
        new elapsed = gettime() - tStart[playerid];
        new xp = 110 - 3 * elapsed;
        if (xp < 35) xp = 35;
        Training_Finish(playerid, xp, "CIRCUIT COMPLETE!");
        return 1;
    }
    SetPlayerCheckpoint(playerid, gSpeedCP[cp][0], gSpeedCP[cp][1], gSpeedCP[cp][2], 3.0);
    return 1;
}

// blast landed (called from combat FireStep) — power strikes
Training_OnBlast(playerid, Float:x, Float:y, Float:z)
{
    if (tMode[playerid] != TRAIN_STRIKE) return 0;

    new cp = tCP[playerid];
    new Float:dx = x - gStrikeCP[cp][0], Float:dy = y - gStrikeCP[cp][1], Float:dz = z - gStrikeCP[cp][2];
    if ((dx * dx + dy * dy + dz * dz) > 100.0) return 0;   // must land within 10m

    tCP[playerid]++;
    new steps = StrikeSteps(tTier[playerid]);
    if (tCP[playerid] >= steps)
    {
        new elapsed = gettime() - tStart[playerid];
        new xp = 130 - elapsed;
        if (xp < 45) xp = 45;
        Training_Finish(playerid, xp, "ALL TARGETS DESTROYED!");
        return 1;
    }
    new m[64]; format(m, sizeof(m), "~g~TARGET DOWN! ~w~%d / %d", tCP[playerid], steps);
    GameTextForPlayer(playerid, m, 1500, 3);
    SetPlayerCheckpoint(playerid, gStrikeCP[tCP[playerid]][0], gStrikeCP[tCP[playerid]][1], gStrikeCP[tCP[playerid]][2], 4.0);
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

            // 3-second head start to read the instructions and get moving
            if (tTick[playerid] <= 3)
            {
                new cd[48]; format(cd, sizeof(cd), "~y~Meteors in %d...", 4 - tTick[playerid]);
                GameTextForPlayer(playerid, cd, 900, 3);
                return 1;
            }

            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            // density scales with tier; wide scatter keeps it dodgeable if you move
            for (new n = 0; n <= tTier[playerid]; n++)
                CreateExplosion(x + float(random(23)) - 11.0, y + float(random(23)) - 11.0, z, EXP_BIG, 4.0);
            if (tTier[playerid] == 2 && tTick[playerid] % 3 == 0)
                CreateExplosion(x + float(random(13)) - 6.0, y + float(random(13)) - 6.0, z + 2.0, EXP_SMALL, 4.0);

            if (tTick[playerid] >= MeteorSecs(tTier[playerid]))
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
            new band = 10 - tTier[playerid] * 2, holdNeed = 12 + tTier[playerid] * 4;
            new pct = (gPlayer[playerid][pKiMax] > 0.0) ? floatround(gPlayer[playerid][pKi] / gPlayer[playerid][pKiMax] * 100.0) : 0;
            if (pct >= tTarget[playerid] - band && pct <= tTarget[playerid] + band)
            {
                tHold[playerid]++;
                new m[64]; format(m, sizeof(m), "~g~In the band! %d / %ds", tHold[playerid], holdNeed);
                GameTextForPlayer(playerid, m, 900, 3);
                if (tHold[playerid] >= holdNeed)
                    Training_Finish(playerid, 80, "PERFECT KI CONTROL!");
            }
            else if (tTick[playerid] % 5 == 0)
            {
                new m[96]; format(m, sizeof(m), "~y~Ki %d%% - target %d%% (+/-%d)", pct, tTarget[playerid], band);
                GameTextForPlayer(playerid, m, 900, 3);
            }
            if (tTick[playerid] >= 60 && tMode[playerid] == TRAIN_KI)
                Training_Finish(playerid, 15, "Time's up - keep practising!");
        }
    }
    return 1;
}
