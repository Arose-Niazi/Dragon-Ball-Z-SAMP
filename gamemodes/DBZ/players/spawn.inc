/*  DBZ / players / spawn.inc  —  per-character spawn setup (level-scaled)  */
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

    new lvl = GetCharLevel(playerid, ch);

    SetPlayerSkinMapped(playerid, gChar[ch][cSkin]);
    SetPlayerFightingStyle(playerid, FIGHT_STYLE:gChar[ch][cStyle]);
    SetPlayerColor(playerid, gChar[ch][cColor]);

    // stats grow with training: +1 max HP and +1 max Ki per level
    gPlayer[playerid][pHealthMax] = float(gChar[ch][cBaseHp] + lvl);
    SetPlayerHealth(playerid, gPlayer[playerid][pHealthMax]);
    SetPlayerArmour(playerid, (gChar[ch][cWeak] || gChar[ch][cAndroid]) ? 0.0 : 100.0);

    if (gChar[ch][cAndroid])
    {
        gPlayer[playerid][pKiMax] = 0.0;
        SetKi(playerid, 0.0);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Android: no Ki needed - your systems power everything.");
    }
    else
    {
        gPlayer[playerid][pKiMax] = float(gChar[ch][cKiCap] + lvl);
        SetKi(playerid, gPlayer[playerid][pKiMax]);
    }

    UpdateNameLabel(playerid, gChar[ch][cLabel], gChar[ch][cColor]);

    // spawn info: level + power + active move
    new mi = ch * 4 + GetActiveMoveSlot(playerid);
    new m[144];
    format(m, sizeof(m), "%s - Level %d | Power %d | Move: %s {AFAFAF}(/stats /moves /skins /train)",
        gChar[ch][cLabel], lvl, GetEffPower(playerid, ch), gMoves[mi][mvName]);
    SendClientMessage(playerid, COLOR_YELLOW, m);

    // uniques
    if (gChar[ch][cAbsorb])
        SendClientMessage(playerid, COLOR_VIOLET, "Cell: absorb a nearby fighter's energy with /absorb.");
    if (ch == CHAR_TRUNKS && lvl >= 10)
        GivePlayerWeapon(playerid, WEAPON_KATANA, 1);

    // wish rewards (granted to the right character)
    if (ch == CHAR_TRUNKS && gPlayer[playerid][pSword])   GivePlayerWeapon(playerid, WEAPON_KATANA, 1);
    if (ch == CHAR_VIDEL  && gPlayer[playerid][pKnife])   GivePlayerWeapon(playerid, WEAPON_KNIFE, 1);
    if (ch == CHAR_A16    && gPlayer[playerid][pBazooka]) GivePlayerWeapon(playerid, WEAPON_HEATSEEKER, 20);
    return 1;
}
