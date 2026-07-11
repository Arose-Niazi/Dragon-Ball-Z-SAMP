/*  DBZ / players / perms.inc  —  shared permission & staff helpers
 *  (Included before accounts/admin so both can use these.)
 */
#if defined _dbz_perms_included
    #endinput
#endif
#define _dbz_perms_included

stock bool:HasAdmin(playerid, minlevel)
{
    return (gPlayer[playerid][pIsOwner] || gPlayer[playerid][pAdminLevel] >= minlevel);
}

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock SendAdminMessage(color, const msg[])
{
    foreach (new i : Player)
        if (gPlayer[i][pAdminLevel] > 0 || gPlayer[i][pIsOwner])
            SendClientMessage(i, color, msg);
    return 1;
}

// Grant Owner + max level to config-listed owner names (replaces the legacy
// hardcoded-name backdoor). Called after account load/register.
ApplyOwnerSeed(playerid)
{
    if (IsOwnerName(gPlayer[playerid][pName]))
    {
        gPlayer[playerid][pIsOwner]    = true;
        gPlayer[playerid][pAdminLevel] = TOP_ADMIN_LEVEL;
    }
    return 1;
}
