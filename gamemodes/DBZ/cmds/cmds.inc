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
    SendClientMessage(playerid, COLOR_YELLOW, "==== DBZ ACTION SHORTCUTS ====");
    SendClientMessage(playerid, COLOR_WHITE,  "These key combos go live in Milestone 4 (no more typing to fight!):");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " FIRE - energy attack   |   MMB (hold) - charge Ki   |   SUB - transform");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, " Y - toggle fly   |   CROUCH - regen   |   NO (hold) - self-destruct");
    SendClientMessage(playerid, COLOR_GREY,   "Commands (/att, /fly, /transform ...) will still work as a fallback.");
    return 1;
}
