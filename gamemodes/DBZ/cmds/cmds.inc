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

CMD:keys(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW,    "==== DBZ ACTION SHORTCUTS (no typing needed!) ====");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " FIRE - energy attack    |   MMB (hold) - charge Ki    |   ALT - small ki blast");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " ACTION key - transform  |   Y - toggle flight         |   CROUCH - regenerate");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " N - self-destruct       |   Fly: FIRE=up, AIM=down, SPRINT=fast, WALK=slow");
    SendClientMessage(playerid, COLOR_GREY,      "Commands still work too: /att /trans /fus /fly /rig /kill /absorb /wish /power");
    return 1;
}
