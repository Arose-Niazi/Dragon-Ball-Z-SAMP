/*  DBZ / players / data.inc  —  per-player data + class roster  */
#if defined _dbz_data_included
    #endinput
#endif
#define _dbz_data_included

enum E_PLAYER_DATA
{
    // --- persistent (mirrors the `accounts` table) ---
    pDBID,                      // accounts.id (0 = not registered/loaded)
    pName[MAX_PLAYER_NAME],
    pAdminLevel,
    pVipLevel,
    bool:pIsOwner,
    pScore,                     // Dragon Points (DP)
    pKills,
    pDeaths,
    pCharacter,                 // selected DBZ character index (into gCharacters)
    pTransform,                 // current transform tier
    Float:pKi,                  // real Ki (replaces the legacy money hack)
    Float:pKiMax,
    Float:pHealthMax,
    pBallsMask,                 // 7-bit mask of collected Dragon Balls
    bool:pDragonRadar,
    bool:pBanned,
    bool:pJailed,
    pJailTime,
    pWarns,
    // --- runtime only ---
    bool:pLoggedIn,
    pLoginTries,
    pIP[46],
    pSalt[33]
}
new gPlayer[MAX_PLAYERS][E_PLAYER_DATA];

// ---------------------------------------------------------------------------
//  Class-selection roster (custom 0.3DL slots where art exists, else closest
//  stock GTA skin). Full DBZ character data lives in DBZ/players/characters.inc.
// ---------------------------------------------------------------------------
new const gClassSkins[] =
{
    SKIN_CUSTOM_GOKU,       // 0  Goku       (custom model)
    96,                     // 1  Vegeta     (stock fallback)
    217,                    // 2  Trunks     (stock fallback)
    176,                    // 3  Gohan      (stock fallback)
    SKIN_CUSTOM_ANDROID16,  // 4  Android 16 (custom model)
    121,                    // 5  Krillin    (stock fallback)
    204,                    // 6  Yamcha     (stock fallback)
    81                      // 7  Tien       (stock fallback)
};

ResetPlayerData(playerid)
{
    gPlayer[playerid][pDBID]        = 0;
    gPlayer[playerid][pName][0]     = EOS;
    gPlayer[playerid][pAdminLevel]  = 0;
    gPlayer[playerid][pVipLevel]    = 0;
    gPlayer[playerid][pIsOwner]     = false;
    gPlayer[playerid][pScore]       = 0;
    gPlayer[playerid][pKills]       = 0;
    gPlayer[playerid][pDeaths]      = 0;
    gPlayer[playerid][pCharacter]   = 0;
    gPlayer[playerid][pTransform]   = 0;
    gPlayer[playerid][pKi]          = 100.0;
    gPlayer[playerid][pKiMax]       = 100.0;
    gPlayer[playerid][pHealthMax]   = 100.0;
    gPlayer[playerid][pBallsMask]   = 0;
    gPlayer[playerid][pDragonRadar] = false;
    gPlayer[playerid][pBanned]      = false;
    gPlayer[playerid][pJailed]      = false;
    gPlayer[playerid][pJailTime]    = 0;
    gPlayer[playerid][pWarns]       = 0;
    gPlayer[playerid][pLoggedIn]    = false;
    gPlayer[playerid][pLoginTries]  = 0;
    gPlayer[playerid][pIP][0]       = EOS;
    gPlayer[playerid][pSalt][0]     = EOS;
    return 1;
}
