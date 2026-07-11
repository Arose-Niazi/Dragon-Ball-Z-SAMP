/*  DBZ / cmds / admin.inc  —  staff administration commands (Pawn.CMD)  */
#if defined _dbz_cmds_admin_included
    #endinput
#endif
#define _dbz_cmds_admin_included

// --------------------------- commands --------------------------------------
CMD:setlevel(playerid, params[])
{
    if (!gPlayer[playerid][pIsOwner])
        return SendClientMessage(playerid, COLOR_RED, "Only server owners can use this.");

    new targetid, level;
    if (sscanf(params, "ud", targetid, level))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /setlevel [playerid] [0-10]");
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    if (level < 0 || level > TOP_ADMIN_LEVEL)
        return SendClientMessage(playerid, COLOR_RED, "Admin level must be 0-10.");

    gPlayer[targetid][pAdminLevel] = level;

    new msg[128];
    format(msg, sizeof(msg), "%s set %s's admin level to %d (%s).", GetName(playerid), GetName(targetid), level, GetAdminTitle(level));
    SendAdminMessage(COLOR_ADMIN, msg);
    format(msg, sizeof(msg), "Your admin level is now %d (%s).", level, GetAdminTitle(level));
    SendClientMessage(targetid, COLOR_YELLOW, msg);
    return 1;
}

CMD:setvip(playerid, params[])
{
    if (!gPlayer[playerid][pIsOwner] && gPlayer[playerid][pAdminLevel] < 8)
        return SendClientMessage(playerid, COLOR_RED, "Only high-level staff can use this.");

    new targetid, level;
    if (sscanf(params, "ud", targetid, level))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /setvip [playerid] [0-3]  (0=None,1=Bronze,2=Silver,3=Gold)");
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    if (level < 0 || level > MAX_VIP_LEVEL)
        return SendClientMessage(playerid, COLOR_RED, "VIP level must be 0-3.");

    gPlayer[targetid][pVipLevel] = level;

    new msg[128];
    format(msg, sizeof(msg), "You set %s's VIP tier to %s.", GetName(targetid), GetVipTitle(level));
    SendClientMessage(playerid, COLOR_YELLOW, msg);
    format(msg, sizeof(msg), "You are now a %s VIP!", GetVipTitle(level));
    SendClientMessage(targetid, COLOR_PINK, msg);
    return 1;
}

CMD:admins(playerid, params[])
{
    #pragma unused params
    SendClientMessage(playerid, COLOR_YELLOW, "==== Online Staff ====");
    new count = 0, msg[96];
    foreach (new i : Player)
    {
        if (gPlayer[i][pAdminLevel] > 0 || gPlayer[i][pIsOwner])
        {
            format(msg, sizeof(msg), "%s (ID %d) - %s", GetName(i), i, GetAdminTitle(gPlayer[i][pAdminLevel]));
            SendClientMessage(playerid, COLOR_WHITE, msg);
            count++;
        }
    }
    if (!count) SendClientMessage(playerid, COLOR_GREY, "No staff online.");
    return 1;
}

CMD:vips(playerid, params[])
{
    #pragma unused params
    SendClientMessage(playerid, COLOR_PINK, "==== Online VIPs ====");
    new count = 0, msg[96];
    foreach (new i : Player)
    {
        if (gPlayer[i][pVipLevel] > 0)
        {
            format(msg, sizeof(msg), "%s (ID %d) - %s VIP", GetName(i), i, GetVipTitle(gPlayer[i][pVipLevel]));
            SendClientMessage(playerid, COLOR_WHITE, msg);
            count++;
        }
    }
    if (!count) SendClientMessage(playerid, COLOR_GREY, "No VIPs online.");
    return 1;
}

CMD:goto(playerid, params[])
{
    if (!HasAdmin(playerid, 2))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized.");
    new targetid;
    if (sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /goto [playerid]");
    if (!IsPlayerConnected(targetid) || targetid == playerid)
        return SendClientMessage(playerid, COLOR_RED, "Invalid target.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
    SetPlayerPos(playerid, x + 1.5, y, z);
    SendClientMessage(playerid, COLOR_YELLOW, "Teleported.");
    return 1;
}

CMD:get(playerid, params[])
{
    if (!HasAdmin(playerid, 2))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized.");
    new targetid;
    if (sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /get [playerid]");
    if (!IsPlayerConnected(targetid) || targetid == playerid)
        return SendClientMessage(playerid, COLOR_RED, "Invalid target.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    SetPlayerInterior(targetid, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
    SetPlayerPos(targetid, x + 1.5, y, z);
    SendClientMessage(targetid, COLOR_YELLOW, "You were teleported by an admin.");
    return 1;
}

ShowAdminCmds(playerid)
{
    if (!HasAdmin(playerid, 1))
        return SendClientMessage(playerid, COLOR_RED, "You are not staff.");
    SendClientMessage(playerid, COLOR_YELLOW, "==== Admin Commands ====");
    SendClientMessage(playerid, COLOR_WHITE, "/kick /warn /jail /unjail /freeze /unfreeze /goto /get /admins");
    SendClientMessage(playerid, COLOR_WHITE, "/ban /unban  (lvl 5+)   /setvip (lvl 8+)   /setlevel (owner)");
    return 1;
}

CMD:acmds(playerid, params[])
{
    #pragma unused params
    return ShowAdminCmds(playerid);
}

CMD:ah(playerid, params[])
{
    #pragma unused params
    return ShowAdminCmds(playerid);
}
