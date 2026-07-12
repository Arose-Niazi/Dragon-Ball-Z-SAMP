/*  DBZ / players / accounts.inc  —  register / login / load / save (MySQL)
 *
 *  Auth: SHA256_PassHash (open.mp built-in) with a random per-account salt.
 *  If the DB is offline the player is allowed in as an unsaved guest so the
 *  server remains testable.
 */
#if defined _dbz_accounts_included
    #endinput
#endif
#define _dbz_accounts_included

// ---------------------------------------------------------------------------
//  Helpers
// ---------------------------------------------------------------------------
forward KickTimer(playerid);
public KickTimer(playerid) { Kick(playerid); return 1; }
DelayedKick(playerid) { SetTimerEx("KickTimer", 400, false, "i", playerid); return 1; }

GenerateSalt(dest[], len = sizeof(dest))
{
    static const chars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    new n;
    for (n = 0; n < len - 1 && n < 16; n++)
        dest[n] = chars[random(sizeof(chars) - 1)];
    dest[n] = EOS;
    return 1;
}

ShowRegisterDialog(playerid)
{
    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,
        "{FFFF00}Dragon Ball Z - Register",
        "Welcome, new fighter!\nThis account name is not registered yet.\nEnter a password to create your account:",
        "Register", "Quit");
    return 1;
}

ShowLoginDialog(playerid)
{
    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,
        "{FFFF00}Dragon Ball Z - Login",
        "Welcome back!\nEnter your password to log in:",
        "Login", "Quit");
    return 1;
}

// ---------------------------------------------------------------------------
//  Connection entry point (called from OnPlayerConnect)
// ---------------------------------------------------------------------------
Account_Check(playerid)
{
    GetPlayerName(playerid, gPlayer[playerid][pName], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, gPlayer[playerid][pIP], 46);

    if (!gDBConnected)
    {
        SendClientMessage(playerid, COLOR_RED, "[!] Database offline - you are playing as an unsaved guest.");
        gPlayer[playerid][pLoggedIn] = true;
        return 1;
    }

    new query[160];
    mysql_format(g_SQL, query, sizeof(query),
        "SELECT `id`,`salt`,`banned` FROM `accounts` WHERE `name` = '%e' LIMIT 1",
        gPlayer[playerid][pName]);
    mysql_pquery(g_SQL, query, "OnAccountCheck", "i", playerid);
    return 1;
}

forward OnAccountCheck(playerid);
public OnAccountCheck(playerid)
{
    if (!IsPlayerConnected(playerid))
        return 0;

    if (cache_num_rows() > 0)
    {
        cache_get_value_name_int(0, "id", gPlayer[playerid][pDBID]);
        cache_get_value_name(0, "salt", gPlayer[playerid][pSalt], 33);

        new banned;
        cache_get_value_name_int(0, "banned", banned);
        if (banned)
        {
            SendClientMessage(playerid, COLOR_RED, "You are banned from this server.");
            DelayedKick(playerid);
            return 1;
        }
        ShowLoginDialog(playerid);
    }
    else
    {
        ShowRegisterDialog(playerid);
    }
    return 1;
}

// ---------------------------------------------------------------------------
//  Register
// ---------------------------------------------------------------------------
Account_Register(playerid, const password[])
{
    if (strlen(password) < 3 || strlen(password) > 32)
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,
            "{FFFF00}Dragon Ball Z - Register",
            "{FF0000}Password must be 3-32 characters.\n{FFFFFF}Enter a password to create your account:",
            "Register", "Quit");
        return 1;
    }

    GenerateSalt(gPlayer[playerid][pSalt]);

    new hash[129];
    SHA256_Hash(password, gPlayer[playerid][pSalt], hash, sizeof(hash));

    new query[320];
    mysql_format(g_SQL, query, sizeof(query),
        "INSERT INTO `accounts` (`name`,`password`,`salt`,`reg_date`,`last_login`,`last_ip`) VALUES ('%e','%e','%e',NOW(),NOW(),'%e')",
        gPlayer[playerid][pName], hash, gPlayer[playerid][pSalt], gPlayer[playerid][pIP]);
    mysql_pquery(g_SQL, query, "OnAccountRegister", "i", playerid);
    return 1;
}

forward OnAccountRegister(playerid);
public OnAccountRegister(playerid)
{
    if (!IsPlayerConnected(playerid))
        return 0;

    gPlayer[playerid][pDBID]     = cache_insert_id();
    gPlayer[playerid][pLoggedIn] = true;
    gPlayer[playerid][pKi]       = 100.0;
    gPlayer[playerid][pKiMax]    = 100.0;
    gPlayer[playerid][pHealthMax]= 100.0;
    ApplyOwnerSeed(playerid);

    SendClientMessage(playerid, COLOR_GREEN, "Account created and logged in! Pick a character to spawn.");
    return 1;
}

// ---------------------------------------------------------------------------
//  Login
// ---------------------------------------------------------------------------
Account_Login(playerid, const password[])
{
    new hash[129];
    SHA256_Hash(password, gPlayer[playerid][pSalt], hash, sizeof(hash));

    new query[192];
    mysql_format(g_SQL, query, sizeof(query),
        "SELECT `id` FROM `accounts` WHERE `id` = %d AND `password` = '%e' LIMIT 1",
        gPlayer[playerid][pDBID], hash);
    mysql_pquery(g_SQL, query, "OnAccountLogin", "i", playerid);
    return 1;
}

forward OnAccountLogin(playerid);
public OnAccountLogin(playerid)
{
    if (!IsPlayerConnected(playerid))
        return 0;

    if (cache_num_rows() > 0)
    {
        LoadAccount(playerid);
    }
    else
    {
        gPlayer[playerid][pLoginTries]++;
        if (gPlayer[playerid][pLoginTries] >= 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Too many failed login attempts.");
            DelayedKick(playerid);
            return 1;
        }
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,
            "{FFFF00}Dragon Ball Z - Login",
            "{FF0000}Wrong password.\n{FFFFFF}Enter your password to log in:",
            "Login", "Quit");
    }
    return 1;
}

LoadAccount(playerid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof(query),
        "SELECT * FROM `accounts` WHERE `id` = %d LIMIT 1", gPlayer[playerid][pDBID]);
    mysql_pquery(g_SQL, query, "OnAccountLoad", "i", playerid);
    return 1;
}

forward OnAccountLoad(playerid);
public OnAccountLoad(playerid)
{
    if (!IsPlayerConnected(playerid) || cache_num_rows() == 0)
        return 0;

    new tmp;
    cache_get_value_name_int(0, "admin_level",  gPlayer[playerid][pAdminLevel]);
    cache_get_value_name_int(0, "vip_level",    gPlayer[playerid][pVipLevel]);
    cache_get_value_name_int(0, "is_owner", tmp); gPlayer[playerid][pIsOwner] = bool:(tmp != 0);
    cache_get_value_name_int(0, "score",        gPlayer[playerid][pScore]);
    cache_get_value_name_int(0, "kills",        gPlayer[playerid][pKills]);
    cache_get_value_name_int(0, "deaths",       gPlayer[playerid][pDeaths]);
    cache_get_value_name_int(0, "character_id", gPlayer[playerid][pCharacter]);
    cache_get_value_name_int(0, "transform",    gPlayer[playerid][pTransform]);
    cache_get_value_name_float(0, "ki",         gPlayer[playerid][pKi]);
    cache_get_value_name_float(0, "ki_max",     gPlayer[playerid][pKiMax]);
    cache_get_value_name_float(0, "health_max", gPlayer[playerid][pHealthMax]);
    cache_get_value_name_int(0, "balls_mask",   gPlayer[playerid][pBallsMask]);
    cache_get_value_name_int(0, "dragon_radar", tmp); gPlayer[playerid][pDragonRadar] = bool:(tmp != 0);
    cache_get_value_name_int(0, "banned", tmp);       gPlayer[playerid][pBanned] = bool:(tmp != 0);
    cache_get_value_name_int(0, "jailed", tmp);       gPlayer[playerid][pJailed] = bool:(tmp != 0);
    cache_get_value_name_int(0, "jail_time",    gPlayer[playerid][pJailTime]);
    cache_get_value_name_int(0, "warns",        gPlayer[playerid][pWarns]);
    cache_get_value_name_int(0, "dsword", tmp);   gPlayer[playerid][pSword]   = bool:(tmp != 0);
    cache_get_value_name_int(0, "dknife", tmp);   gPlayer[playerid][pKnife]   = bool:(tmp != 0);
    cache_get_value_name_int(0, "dbazooka", tmp); gPlayer[playerid][pBazooka] = bool:(tmp != 0);
    cache_get_value_name_int(0, "radar_parts", gPlayer[playerid][pRadarParts]);

    gPlayer[playerid][pLoggedIn] = true;
    ApplyOwnerSeed(playerid);
    SetPlayerScore(playerid, gPlayer[playerid][pScore]);
    Prog_LoadAll(playerid);
    SendClientMessage(playerid, COLOR_GREEN, "Login successful. Welcome back! Pick a character to spawn.");
    return 1;
}

// ---------------------------------------------------------------------------
//  Save
// ---------------------------------------------------------------------------
SavePlayerData(playerid)
{
    if (!gDBConnected || !gPlayer[playerid][pLoggedIn] || gPlayer[playerid][pDBID] == 0)
        return 0;

    new query[512];
    mysql_format(g_SQL, query, sizeof(query),
        "UPDATE `accounts` SET `admin_level`=%d,`vip_level`=%d,`is_owner`=%d,`score`=%d,`kills`=%d,`deaths`=%d,`character_id`=%d,`transform`=%d,`ki`=%f,`ki_max`=%f,`health_max`=%f,`balls_mask`=%d,`dragon_radar`=%d,`banned`=%d,`jailed`=%d,`jail_time`=%d,`warns`=%d,`dsword`=%d,`dknife`=%d,`dbazooka`=%d,`radar_parts`=%d,`last_login`=NOW(),`last_ip`='%e' WHERE `id`=%d",
        gPlayer[playerid][pAdminLevel], gPlayer[playerid][pVipLevel], _:gPlayer[playerid][pIsOwner],
        gPlayer[playerid][pScore], gPlayer[playerid][pKills], gPlayer[playerid][pDeaths],
        gPlayer[playerid][pCharacter], gPlayer[playerid][pTransform],
        gPlayer[playerid][pKi], gPlayer[playerid][pKiMax], gPlayer[playerid][pHealthMax],
        gPlayer[playerid][pBallsMask], _:gPlayer[playerid][pDragonRadar], _:gPlayer[playerid][pBanned],
        _:gPlayer[playerid][pJailed], gPlayer[playerid][pJailTime], gPlayer[playerid][pWarns],
        _:gPlayer[playerid][pSword], _:gPlayer[playerid][pKnife], _:gPlayer[playerid][pBazooka],
        gPlayer[playerid][pRadarParts],
        gPlayer[playerid][pIP], gPlayer[playerid][pDBID]);
    mysql_pquery(g_SQL, query);
    Prog_SaveAll(playerid);
    return 1;
}

