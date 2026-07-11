/*  DBZ / players / data.inc  —  per-player data + class roster
 *  Expanded in Milestone 2 (accounts/persistence) and Milestone 3 (real Ki).
 */
#if defined _dbz_data_included
    #endinput
#endif
#define _dbz_data_included

enum E_PLAYER_DATA
{
    bool:pLoggedIn,
    pAdminLevel,
    pVipLevel,
    Float:pKi,          // real Ki resource (replaces the legacy Ki-as-money hack)
    Float:pKiMax,
    pCharacter          // which DBZ character/class the player selected
}
new gPlayer[MAX_PLAYERS][E_PLAYER_DATA];

// ---------------------------------------------------------------------------
//  Class-selection roster.  Custom 0.3DL slots where art exists, else the
//  closest stock GTA skin as a fallback (swappable later with one line).
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
    gPlayer[playerid][pLoggedIn]   = false;
    gPlayer[playerid][pAdminLevel] = 0;
    gPlayer[playerid][pVipLevel]   = 0;
    gPlayer[playerid][pKi]         = 100.0;
    gPlayer[playerid][pKiMax]      = 100.0;
    gPlayer[playerid][pCharacter]  = 0;
    return 1;
}
