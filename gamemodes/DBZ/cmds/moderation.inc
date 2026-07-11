/*  DBZ / cmds / moderation.inc  —  kick / ban / warn / jail / freeze (Pawn.CMD)  */
#if defined _dbz_cmds_moderation_included
    #endinput
#endif
#define _dbz_cmds_moderation_included

CMD:kick(playerid, params[])
{
    if (!HasAdmin(playerid, 2))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized.");

    new targetid, reason[80];
    if (sscanf(params, "us[80]", targetid, reason))
    {
        if (!sscanf(params, "u", targetid)) reason = "No reason given";
        else return SendClientMessage(playerid, COLOR_GREY, "Usage: /kick [playerid] [reason]");
    }
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    if (HasAdmin(targetid, 1) && !gPlayer[playerid][pIsOwner])
        return SendClientMessage(playerid, COLOR_RED, "You can't kick another staff member.");

    new msg[160];
    format(msg, sizeof(msg), "%s was kicked by %s. Reason: %s", GetName(targetid), GetName(playerid), reason);
    SendClientMessageToAll(COLOR_ORANGE, msg);
    DelayedKick(targetid);
    return 1;
}

CMD:ban(playerid, params[])
{
    if (!HasAdmin(playerid, 5))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized (level 5+).");

    new targetid, reason[80];
    if (sscanf(params, "us[80]", targetid, reason))
    {
        if (!sscanf(params, "u", targetid)) reason = "No reason given";
        else return SendClientMessage(playerid, COLOR_GREY, "Usage: /ban [playerid] [reason]");
    }
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    if (HasAdmin(targetid, 1) && !gPlayer[playerid][pIsOwner])
        return SendClientMessage(playerid, COLOR_RED, "You can't ban another staff member.");

    gPlayer[targetid][pBanned] = true;
    if (gDBConnected && gPlayer[targetid][pDBID] != 0)
    {
        new q[256];
        mysql_format(g_SQL, q, sizeof(q), "UPDATE `accounts` SET `banned`=1 WHERE `id`=%d", gPlayer[targetid][pDBID]);
        mysql_pquery(g_SQL, q);
        mysql_format(g_SQL, q, sizeof(q),
            "INSERT INTO `bans` (`name`,`reason`,`admin`,`expire`,`date`) VALUES ('%e','%e','%e',0,NOW())",
            gPlayer[targetid][pName], reason, GetName(playerid));
        mysql_pquery(g_SQL, q);
    }

    new msg[160];
    format(msg, sizeof(msg), "%s was BANNED by %s. Reason: %s", GetName(targetid), GetName(playerid), reason);
    SendClientMessageToAll(COLOR_RED, msg);
    DelayedKick(targetid);
    return 1;
}

CMD:unban(playerid, params[])
{
    if (!HasAdmin(playerid, 5))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized (level 5+).");
    if (!gDBConnected)
        return SendClientMessage(playerid, COLOR_RED, "Database offline.");

    new name[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", name))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /unban [name]");

    new q[192];
    mysql_format(g_SQL, q, sizeof(q), "UPDATE `accounts` SET `banned`=0 WHERE `name`='%e'", name);
    mysql_pquery(g_SQL, q);
    mysql_format(g_SQL, q, sizeof(q), "DELETE FROM `bans` WHERE `name`='%e'", name);
    mysql_pquery(g_SQL, q);

    new msg[128];
    format(msg, sizeof(msg), "%s unbanned the account '%s'.", GetName(playerid), name);
    SendAdminMessage(COLOR_ADMIN, msg);
    return 1;
}

CMD:warn(playerid, params[])
{
    if (!HasAdmin(playerid, 1))
        return SendClientMessage(playerid, COLOR_RED, "You are not staff.");

    new targetid, reason[80];
    if (sscanf(params, "us[80]", targetid, reason))
    {
        if (!sscanf(params, "u", targetid)) reason = "No reason given";
        else return SendClientMessage(playerid, COLOR_GREY, "Usage: /warn [playerid] [reason]");
    }
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");

    gPlayer[targetid][pWarns]++;

    new msg[160];
    format(msg, sizeof(msg), "%s was warned by %s (%d/3). Reason: %s", GetName(targetid), GetName(playerid), gPlayer[targetid][pWarns], reason);
    SendClientMessageToAll(COLOR_ORANGE, msg);

    if (gPlayer[targetid][pWarns] >= 3)
    {
        gPlayer[targetid][pWarns] = 0;
        SendClientMessageToAll(COLOR_RED, "Player kicked for reaching 3 warnings.");
        DelayedKick(targetid);
    }
    return 1;
}

CMD:jail(playerid, params[])
{
    if (!HasAdmin(playerid, 4))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized (level 4+).");

    new targetid, minutes, reason[64];
    if (sscanf(params, "uds[64]", targetid, minutes, reason))
    {
        if (sscanf(params, "ud", targetid, minutes))
            return SendClientMessage(playerid, COLOR_GREY, "Usage: /jail [playerid] [minutes] [reason]");
        reason = "No reason given";
    }
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    if (minutes < 1) minutes = 1;

    JailPlayer(targetid, minutes * 60);

    new msg[160];
    format(msg, sizeof(msg), "%s jailed %s for %d minute(s). Reason: %s", GetName(playerid), GetName(targetid), minutes, reason);
    SendClientMessageToAll(COLOR_ORANGE, msg);
    return 1;
}

CMD:unjail(playerid, params[])
{
    if (!HasAdmin(playerid, 4))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized (level 4+).");

    new targetid;
    if (sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /unjail [playerid]");
    if (!IsPlayerConnected(targetid) || !gPlayer[targetid][pJailed])
        return SendClientMessage(playerid, COLOR_RED, "That player is not jailed.");

    UnjailPlayer(targetid);
    new msg[96];
    format(msg, sizeof(msg), "%s released %s from jail.", GetName(playerid), GetName(targetid));
    SendAdminMessage(COLOR_ADMIN, msg);
    return 1;
}

CMD:jailed(playerid, params[])
{
    #pragma unused params
    if (!HasAdmin(playerid, 1))
        return SendClientMessage(playerid, COLOR_RED, "You are not staff.");
    SendClientMessage(playerid, COLOR_YELLOW, "==== Jailed Players ====");
    new count = 0, msg[96];
    foreach (new i : Player)
    {
        if (gPlayer[i][pJailed])
        {
            format(msg, sizeof(msg), "%s (ID %d) - %d sec left", GetName(i), i, gPlayer[i][pJailTime]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
            count++;
        }
    }
    if (!count) SendClientMessage(playerid, COLOR_GREY, "Nobody is jailed.");
    return 1;
}

CMD:freeze(playerid, params[])
{
    if (!HasAdmin(playerid, 2))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized.");
    new targetid;
    if (sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /freeze [playerid]");
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    TogglePlayerControllable(targetid, false);
    SendClientMessage(targetid, COLOR_LIGHTBLUE, "You have been frozen by an admin.");
    return 1;
}

CMD:unfreeze(playerid, params[])
{
    if (!HasAdmin(playerid, 2))
        return SendClientMessage(playerid, COLOR_RED, "You are not authorized.");
    new targetid;
    if (sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /unfreeze [playerid]");
    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_RED, "That player is not connected.");
    TogglePlayerControllable(targetid, true);
    SendClientMessage(targetid, COLOR_LIGHTBLUE, "You have been unfrozen by an admin.");
    return 1;
}
