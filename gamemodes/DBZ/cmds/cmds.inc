/*  DBZ / cmds / cmds.inc  —  Pawn.CMD command handlers
 *  Milestone 1 ships two diagnostic commands. The full ~44-command set is
 *  migrated from legacy zcmd to Pawn.CMD across later milestones.
 */
#if defined _dbz_cmds_included
    #endinput
#endif
#define _dbz_cmds_included

CMD:ping(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "pong! Dragon Ball Z (open.mp) server is alive and well.");
    return 1;
}

CMD:cmds(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "==== Dragon Ball Z Commands ====");
    SendClientMessage(playerid, COLOR_WHITE,  "Combat: /att /trans /fus /fly /rig /kill /absorb /wish /power");
    SendClientMessage(playerid, COLOR_WHITE,  "Info:   /keys /cmds /help /admins /vips");
    if (HasAdmin(playerid, 1))
        SendClientMessage(playerid, COLOR_ADMIN, "Staff:  /acmds");
    return 1;
}

CMD:help(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "==== How to play Dragon Ball Z ====");
    SendClientMessage(playerid, COLOR_WHITE,  "1. Pick a character at class selection, then choose a battleground.");
    SendClientMessage(playerid, COLOR_WHITE,  "2. Hold MMB to charge Ki; press FIRE to launch your energy attack.");
    SendClientMessage(playerid, COLOR_WHITE,  "3. Press the ACTION key to transform, Y to fly, N to self-destruct.");
    SendClientMessage(playerid, COLOR_WHITE,  "4. Collect all 7 Dragon Balls, then /wish to summon Shenron!");
    SendClientMessage(playerid, COLOR_GREY,   "See /keys for the full shortcut list and /cmds for all commands.");
    return 1;
}

CMD:keys(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW,    "==== DBZ ACTION SHORTCUTS (no typing needed!) ====");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " FIRE - energy attack    |   MMB (hold) - charge Ki    |   ALT - small ki blast");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " ACTION key - transform  |   Y - toggle flight         |   CROUCH - regenerate");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " N - self-destruct       |   Fly: FIRE=up, AIM=down, SPRINT=fast, WALK=slow");
    SendClientMessage(playerid, COLOR_GREY,      "Commands still work too: /att /trans /fus /fly /rig /kill /absorb /wish /power");
    return 1;
}
