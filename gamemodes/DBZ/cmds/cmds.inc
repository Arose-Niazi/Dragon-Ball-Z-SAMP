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

// Pawn.CMD: tell the player when a command doesn't exist (result -1 = no handler matched).
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    #pragma unused params
    #pragma unused flags
    if (result == -1)
    {
        new m[96];
        format(m, sizeof(m), "Unknown command: /%s  -  type /cmds for the command list.", cmd);
        SendClientMessage(playerid, COLOR_GREY, m);
    }
    return 1;
}

CMD:cmds(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "==== Dragon Ball Z Commands ====");
    SendClientMessage(playerid, COLOR_WHITE,  "Combat:   /att /trans /fus /fly /rig /kill /absorb /kaioken /power");
    SendClientMessage(playerid, COLOR_WHITE,  "Progress: /train /stats /moves /skins /craft /wish");
    SendClientMessage(playerid, COLOR_WHITE,  "Info:     /keys /cmds /help /admins /vips");
    if (HasAdmin(playerid, 1))
        SendClientMessage(playerid, COLOR_ADMIN, "Staff:  /acmds");
    return 1;
}

CMD:help(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "==== How to play Dragon Ball Z ====");
    SendClientMessage(playerid, COLOR_WHITE,  "1. Pick a character - each one levels up SEPARATELY as you fight and /train.");
    SendClientMessage(playerid, COLOR_WHITE,  "2. Hold MMB to charge Ki; FIRE launches your move (choose it with /moves).");
    SendClientMessage(playerid, COLOR_WHITE,  "3. Level up to unlock transformations (/trans), moves, and appearances (/skins).");
    SendClientMessage(playerid, COLOR_WHITE,  "4. Find 5 radar parts, /craft the Dragon Radar at Bulma's, hunt the 7 Dragon Balls, /wish!");
    SendClientMessage(playerid, COLOR_GREY,   "Even Hercule can beat a Saiyan with enough training. /keys for controls.");
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
