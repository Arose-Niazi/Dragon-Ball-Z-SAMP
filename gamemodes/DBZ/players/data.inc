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
    bool:pSword,                // wish rewards (persist)
    bool:pKnife,
    bool:pBazooka,
    // --- runtime only ---
    bool:pLoggedIn,
    pLoginTries,
    pIP[46],
    pSalt[33],
    // --- combat / movement runtime ---
    bool:pFused,
    bool:pFlying,
    bool:pCharging,
    pFlyTimer,
    pChargeTimer,
    pLastAttack,
    Text3D:pLabel,
    PlayerBar:pKiBar
}
new gPlayer[MAX_PLAYERS][E_PLAYER_DATA];

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
    gPlayer[playerid][pSword]       = false;
    gPlayer[playerid][pKnife]       = false;
    gPlayer[playerid][pBazooka]     = false;
    gPlayer[playerid][pLoggedIn]    = false;
    gPlayer[playerid][pLoginTries]  = 0;
    gPlayer[playerid][pIP][0]       = EOS;
    gPlayer[playerid][pSalt][0]     = EOS;
    gPlayer[playerid][pFused]       = false;
    gPlayer[playerid][pFlying]      = false;
    gPlayer[playerid][pCharging]    = false;
    gPlayer[playerid][pFlyTimer]    = 0;
    gPlayer[playerid][pChargeTimer] = 0;
    gPlayer[playerid][pLastAttack]  = 0;
    gPlayer[playerid][pLabel]       = Text3D:INVALID_3DTEXT_ID;
    gPlayer[playerid][pKiBar]       = INVALID_PLAYER_BAR_ID;
    return 1;
}
