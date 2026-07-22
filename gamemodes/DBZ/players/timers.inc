/*  DBZ / players / timers.inc  —  jail control + global timers  */
#if defined _dbz_timers_included
    #endinput
#endif
#define _dbz_timers_included

JailPlayer(playerid, seconds)
{
    gPlayer[playerid][pJailed]   = true;
    gPlayer[playerid][pJailTime] = seconds;
    SetPlayerInterior(playerid, JAIL_INTERIOR);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, JAIL_X, JAIL_Y, JAIL_Z);
    TogglePlayerControllable(playerid, false);
    return 1;
}

UnjailPlayer(playerid)
{
    gPlayer[playerid][pJailed]   = false;
    gPlayer[playerid][pJailTime] = 0;
    SetPlayerInterior(playerid, 0);
    TogglePlayerControllable(playerid, true);
    SpawnPlayer(playerid);
    SendClientMessage(playerid, COLOR_GREEN, "You have been released from jail.");
    return 1;
}

// Re-apply jail on (re)spawn without resetting the remaining time.
ReapplyJail(playerid)
{
    if (!gPlayer[playerid][pJailed])
        return 0;
    SetPlayerInterior(playerid, JAIL_INTERIOR);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, JAIL_X, JAIL_Y, JAIL_Z);
    TogglePlayerControllable(playerid, false);
    return 1;
}

forward SecondTimer();
public SecondTimer()
{
    foreach (new i : Player)
    {
        if (gPlayer[i][pJailed] && gPlayer[i][pJailTime] > 0)
        {
            gPlayer[i][pJailTime]--;
            if (gPlayer[i][pJailTime] <= 0)
                UnjailPlayer(i);
        }

        // ability cooldowns
        if (gPlayer[i][pAbsorbCd] > 0) gPlayer[i][pAbsorbCd]--;
        if (gPlayer[i][pTrainCd] > 0)  gPlayer[i][pTrainCd]--;

        // Goku: Kaioken wears off
        if (gPlayer[i][pKaiokenUntil] != 0 && gPlayer[i][pKaiokenUntil] <= gettime())
        {
            gPlayer[i][pKaiokenUntil] = 0;
            new skin, color, lbl[24], ki, count;
            GetFormInfo(i, gPlayer[i][pTransform], skin, color, lbl, ki, count);
            SetPlayerColor(i, color);
            GameTextForPlayer(i, "~w~Kaioken faded...", 1500, 3);
        }

        // Piccolo: Namekian regeneration — heal when out of combat for 8s
        if (gPlayer[i][pLoggedIn] && gPlayer[i][pCharacter] == CHAR_PICCOLO
            && GetTickCount() - gPlayer[i][pLastDamagedTick] > 8000)
        {
            new Float:hp;
            GetPlayerHealth(i, hp);
            if (hp > 0.0 && hp < gPlayer[i][pHealthMax])
            {
                hp += 2.0;
                if (hp > gPlayer[i][pHealthMax]) hp = gPlayer[i][pHealthMax];
                SetPlayerHealth(i, hp);
            }
        }

        // training challenge ticks
        if (Training_Active(i)) Training_Tick(i);

        // Saiyan transformations drain Ki over time (higher form = faster); Mystic/Cell don't
        if (gPlayer[i][pLoggedIn] && gPlayer[i][pTransform] > 0
            && FormDrains(gPlayer[i][pCharacter], gPlayer[i][pTransform]) && !IsAndroid(i))
        {
            new Float:drain = 2.0 + 2.0 * float(gPlayer[i][pTransform]);   // SSJ 4/s, SSJ2 6/s, SSJ3 8/s
            new Float:ki = GetKi(i);
            if (ki <= drain)
            {
                SendClientMessage(i, COLOR_RED, "Your Ki ran dry - you power down!");
                DoDetransform(i);
            }
            else SetKi(i, ki - drain);
        }
    }
    return 1;
}

forward AutoSaveTimer();
public AutoSaveTimer()
{
    foreach (new i : Player)
        SavePlayerData(i);
    return 1;
}
