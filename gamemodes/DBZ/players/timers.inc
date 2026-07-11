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
