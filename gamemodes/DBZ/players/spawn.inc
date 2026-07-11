/*  DBZ / players / spawn.inc  —  per-character spawn setup + wish rewards  */
#if defined _dbz_spawn_included
    #endinput
#endif
#define _dbz_spawn_included

ApplyCharacterSpawn(playerid)
{
    new ch = gPlayer[playerid][pCharacter];
    if (ch < 0 || ch >= MAX_CHARACTERS) ch = 0;

    gPlayer[playerid][pTransform] = 0;
    gPlayer[playerid][pFused]     = false;

    SetPlayerSkinMapped(playerid, gChar[ch][cSkin]);
    SetPlayerFightingStyle(playerid, FIGHT_STYLE:gChar[ch][cStyle]);
    SetPlayerColor(playerid, gChar[ch][cColor]);

    if (gChar[ch][cAndroid])
    {
        gPlayer[playerid][pHealthMax] = 50.0;
        SetPlayerHealth(playerid, 50.0);
        SetPlayerArmour(playerid, 0.0);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Androids have less health, but they never tire (no Ki needed).");
    }
    else if (gChar[ch][cWeak])
    {
        gPlayer[playerid][pHealthMax] = 150.0;
        SetPlayerHealth(playerid, 150.0);
        SetPlayerArmour(playerid, 0.0);
        SendClientMessage(playerid, COLOR_PINK, "Weak characters start with 150 HP and no armour.");
    }
    else
    {
        gPlayer[playerid][pHealthMax] = 150.0;
        SetPlayerHealth(playerid, 150.0);
        SetPlayerArmour(playerid, 150.0);
    }

    gPlayer[playerid][pKiMax] = (gChar[ch][cKiCap] <= 0) ? 100.0 : float(gChar[ch][cKiCap]);
    SetKi(playerid, gPlayer[playerid][pKiMax]);

    UpdateNameLabel(playerid, gChar[ch][cLabel], gChar[ch][cColor]);

    if (gChar[ch][cAbsorb])
        SendClientMessage(playerid, COLOR_GREEN, "This character can absorb energy - use /absorb near an enemy.");

    // wish rewards (granted next spawn to the correct character)
    if (ch == 2  && gPlayer[playerid][pSword])   GivePlayerWeapon(playerid, WEAPON_KATANA, 1);
    if (ch == 5  && gPlayer[playerid][pKnife])   GivePlayerWeapon(playerid, WEAPON_KNIFE, 1);
    if (ch == 10 && gPlayer[playerid][pBazooka]) GivePlayerWeapon(playerid, WEAPON_HEATSEEKER, 20);
    return 1;
}
