/*  DBZ / players / combat.inc  —  attacks, transform, fusion, regen, self-destruct, absorb
 *  Damage is engine-driven: attacks render CreateExplosion chains; SA-MP damages
 *  anyone caught in the blasts (faithful to legacy).
 */
#if defined _dbz_combat_included
    #endinput
#endif
#define _dbz_combat_included

#define SND_ATTACK  1057   // SOUND_RACE_GO

// Fire a beam: explosions from `start` to `end` metres ahead, stepping `step`.
FireBeam(playerid, Float:start, Float:end, Float:step, model, Float:radius)
{
    for (new Float:d = start; d <= end; d += step)
        CreateExplosionEx(playerid, d, model, radius);
    return 1;
}

GetAttackKi(skin)
{
    switch (skin)
    {
        case GOKU1, VEGETA1, VEGETA2, VEGETAS, TRUNKSS: return 30;
        case GOKU2, GOHAN1:  return 35;
        case GOKU3, GOHAN2:  return 40;
        case SATAN:          return 15;
        case VIDEL:          return 20;
        case GELO, ANDROID16, ANDROID17, ANDROID18, ANDROID19: return 0;
        case VEGEKU0:        return 40;
        case VEGEKU1, GOGETA: return 90;
    }
    return 25; // GOKU0/VEGETA0/TRUNKS0/TRUNKS1/GOHAN0/CRILIN/YAMCHA/TENSHINSHAN default
}

GetAttackName(skin, dest[])
{
    switch (skin)
    {
        case GOKU0, CRILIN:  format(dest, 32, "Kamehameha");
        case GOKU1:          format(dest, 32, "Furious Kamehameha");
        case GOKU2, GOHAN1:  format(dest, 32, "Super Kamehameha");
        case GOKU3, GOHAN2:  format(dest, 32, "Maximum Kamehameha");
        case VEGETA0:        format(dest, 32, "Explosive Cannon");
        case VEGETA1:        format(dest, 32, "Big Bang Attack");
        case VEGETA2, VEGETAS: format(dest, 32, "Final Flash");
        case TRUNKS0:        format(dest, 32, "Masenko");
        case TRUNKS1:        format(dest, 32, "Burning Attack");
        case TRUNKSS:        format(dest, 32, "Finish Buster");
        case GOHAN0:         format(dest, 32, "Super Masenko");
        case TENSHINSHAN:    format(dest, 32, "Triple Ray");
        case YAMCHA:         format(dest, 32, "Wolf Fang Fist");
        case SATAN:          format(dest, 32, "The Champion");
        case VIDEL:          format(dest, 32, "Great Ki Bomb");
        case ANDROID16:      format(dest, 32, "Rocket Launcher");
        case ANDROID17:      format(dest, 32, "Energy Sphere");
        case VEGEKU0:        format(dest, 32, "Final Flash");
        case VEGEKU1:        format(dest, 32, "Final Kamehameha");
        case GOGETA:         format(dest, 32, "Big Bang Kamehameha");
        default:             format(dest, 32, "Energy Beam");
    }
    return 1;
}

FireAttackPattern(playerid, skin)
{
    switch (skin)
    {
        case GOKU1:           { FireBeam(playerid, 5.0, 10.0, 5.0, 11, 5.0);  FireBeam(playerid, 15.0, 55.0, 5.0, 11, 15.0); }
        case GOKU2, GOHAN1:   { FireBeam(playerid, 5.0, 10.0, 5.0, 11, 5.0);  FireBeam(playerid, 15.0, 30.0, 5.0, 11, 15.0); FireBeam(playerid, 35.0, 60.0, 5.0, 7, 15.0); }
        case GOKU3, GOHAN2:   { FireBeam(playerid, 5.0, 20.0, 5.0, 11, 5.0);  FireBeam(playerid, 25.0, 80.0, 5.0, 7, 5.0); }
        case VEGETA0:         { FireBeam(playerid, 5.0, 10.0, 5.0, 11, 5.0);  FireBeam(playerid, 15.0, 50.0, 5.0, 11, 10.0); }
        case VEGETA1:         { CreateExplosionEx(playerid, 35.0, 7, 30.0); CreateExplosionEx(playerid, 40.0, 7, 30.0); }
        case VEGETA2, VEGETAS:{ FireBeam(playerid, 5.0, 10.0, 5.0, 11, 5.0);  FireBeam(playerid, 15.0, 60.0, 5.0, 11, 20.0); }
        case TRUNKS0:         { FireBeam(playerid, 5.0, 10.0, 5.0, 11, 5.0);  FireBeam(playerid, 15.0, 50.0, 5.0, 11, 10.0); }
        case TRUNKS1:         { CreateExplosionEx(playerid, 30.0, 1, 40.0); CreateExplosionEx(playerid, 35.0, 1, 40.0); }
        case TRUNKSS:         { CreateExplosionEx(playerid, 15.0, 7, 10.0); }
        case GOHAN0:          { FireBeam(playerid, 5.0, 10.0, 5.0, 11, 5.0);  FireBeam(playerid, 15.0, 25.0, 5.0, 11, 10.0); FireBeam(playerid, 30.0, 35.0, 5.0, 7, 10.0); FireBeam(playerid, 40.0, 60.0, 5.0, 7, 15.0); }
        case TENSHINSHAN:     { CreateExplosionEx(playerid, 20.0, 6, 5.0); CreateExplosionEx(playerid, 25.0, 6, 5.0); }
        case YAMCHA:          { CreateExplosionEx(playerid, 15.0, 7, 20.0); }
        case SATAN:           { CreateExplosionEx(playerid, 10.0, 11, 2.0); }
        case VIDEL:           { CreateExplosionEx(playerid, 20.0, 11, 10.0); }
        case ANDROID16:       { FireBeam(playerid, 15.0, 20.0, 5.0, 11, 5.0); FireBeam(playerid, 25.0, 70.0, 5.0, 7, 15.0); }
        case ANDROID17:       { CreateExplosionEx(playerid, 30.0, 7, 20.0); CreateExplosionEx(playerid, 40.0, 7, 20.0); }
        case VEGEKU0:         { FireBeam(playerid, 5.0, 20.0, 5.0, 11, 5.0);  FireBeam(playerid, 25.0, 90.0, 5.0, 7, 5.0); }
        case VEGEKU1:         { FireBeam(playerid, 5.0, 15.0, 5.0, 11, 5.0);  FireBeam(playerid, 20.0, 60.0, 5.0, 7, 25.0); FireBeam(playerid, 65.0, 100.0, 5.0, 7, 75.0); }
        case GOGETA:          { FireBeam(playerid, 5.0, 37.0, 2.0, 12, 1.0);  FireBeam(playerid, 40.0, 47.0, 2.0, 12, 2.0);  FireBeam(playerid, 50.0, 70.0, 2.0, 7, 100.0); }
        default:              { FireBeam(playerid, 5.0, 50.0, 5.0, 11, 5.0); } // Kamehameha / Energy Beam
    }
    return 1;
}

DoAttack(playerid)
{
    if (GetTickCount() - gPlayer[playerid][pLastAttack] < ATTACK_COOLDOWN && gPlayer[playerid][pLastAttack] != 0)
    {
        new secs = (ATTACK_COOLDOWN - (GetTickCount() - gPlayer[playerid][pLastAttack])) / 1000 + 1;
        new m[32]; format(m, sizeof(m), "~r~Wait %d sec", secs);
        GameTextForPlayer(playerid, m, 1200, 3);
        return 0;
    }

    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);

    new Float:cost = float(GetAttackKi(skin));
    if (!HasKi(playerid, cost))
    {
        GameTextForPlayer(playerid, "~r~Not enough Ki!", 1200, 3);
        return 0;
    }
    SpendKi(playerid, cost);
    gPlayer[playerid][pLastAttack] = GetTickCount();

    PlayerPlaySound(playerid, SND_ATTACK, 0.0, 0.0, 0.0);
    FireAttackPattern(playerid, skin);

    new aname[32];
    GetAttackName(skin, aname);
    ShowAttackName(playerid, aname);
    return 1;
}

DoKiBlast(playerid)
{
    if (!HasKi(playerid, KI_BLAST_COST))
    {
        GameTextForPlayer(playerid, "~r~Not enough Ki!", 1000, 3);
        return 0;
    }
    SpendKi(playerid, KI_BLAST_COST);
    CreateExplosionEx(playerid, 10.0, 12, 0.1);
    return 1;
}

GetRegenAmount(skin)
{
    switch (skin)
    {
        case GOKU1, VEGETA1, TRUNKS1, GOHAN1, VEGETAS, TRUNKSS: return 4;
        case GOKU2, VEGETA2, GOHAN2: return 6;
        case GOKU3, VEGEKU0: return 8;
        case VEGEKU1, GOGETA: return 10;
        case SATAN, VIDEL: return 1;
    }
    return 2;
}

DoRig(playerid)
{
    new Float:hp;
    GetPlayerHealth(playerid, hp);
    if (hp >= gPlayer[playerid][pHealthMax])
        return SendClientMessage(playerid, COLOR_GREY, "Your health is already full!");
    if (!HasKi(playerid, KI_RIG_COST))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to regenerate!");
    SpendKi(playerid, KI_RIG_COST);

    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    SetPlayerHealth(playerid, hp + float(GetRegenAmount(skin)));
    GameTextForPlayer(playerid, "~g~Regenerating", 700, 3);
    return 1;
}

GetSelfDestructKi(playerid)
{
    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    switch (skin)
    {
        case GOKU1, VEGETA1, TRUNKS1, GOHAN1, VEGETAS, TRUNKSS: return 60;
        case GOKU2, GOHAN2, VEGETA2: return 80;
        case GOKU3, VEGEKU0: return 90;
        case SATAN: return 20;
        case VIDEL: return 40;
        case VEGEKU1, GOGETA: return 100;
    }
    return 50;
}

DoKill(playerid)
{
    new Float:cost = float(GetSelfDestructKi(playerid));
    if (!HasKi(playerid, cost))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to self-destruct!");
    SpendKi(playerid, cost);

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z, 7, 60.0);
    CreateExplosion(x, y, z + 10.0, 7, 50.0);
    CreateExplosion(x, y, z + 20.0, 7, 50.0);
    PlayerPlaySound(playerid, SND_ATTACK, 0.0, 0.0, 0.0);
    GameTextForPlayer(playerid, "~r~Self-Destruct!", 1500, 3);
    SetPlayerHealth(playerid, 1.0);
    return 1;
}

DoAbsorb(playerid)
{
    if (!gChar[gPlayer[playerid][pCharacter]][cAbsorb])
        return SendClientMessage(playerid, COLOR_GREY, "Only Dr.Gero and Android 19 can absorb Ki!");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    foreach (new i : Player)
    {
        if (i != playerid && IsPlayerInRangeOfPoint(i, 2.0, x, y, z))
        {
            new Float:th, Float:sh;
            GetPlayerHealth(i, th);       SetPlayerHealth(i, th - ABSORB_AMOUNT);
            GetPlayerHealth(playerid, sh); SetPlayerHealth(playerid, sh + ABSORB_AMOUNT);
            PlayerPlaySound(playerid, SND_ATTACK, 0.0, 0.0, 0.0);
            SendClientMessage(playerid, COLOR_GREEN, "Thank you for your energy!");
            SendClientMessage(i, COLOR_RED, "Your energy was absorbed!");
            return 1;
        }
    }
    SendClientMessage(playerid, COLOR_GREY, "Nobody is near you to absorb!");
    return 1;
}

DoTransform(playerid)
{
    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    if (count <= 1)
        return SendClientMessage(playerid, COLOR_GREY, "This character can't transform.");

    new next = gPlayer[playerid][pTransform] + 1;
    if (next >= count) next = 0;

    new nskin, ncolor, nlbl[24], nki, ncount;
    GetFormInfo(playerid, next, nskin, ncolor, nlbl, nki, ncount);

    new bool:free = (GetPlayerInterior(playerid) == 3);
    if (!free && next != 0 && !HasKi(playerid, float(nki)))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to transform!");

    gPlayer[playerid][pTransform] = next;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, 11, 3.0);
    SetPlayerSkinMapped(playerid, nskin);
    SetPlayerColor(playerid, ncolor);

    if (next == 0)
    {
        if (!free) SetKi(playerid, 0.0);   // reverting drains Ki (legacy behaviour)
    }
    else if (!free)
    {
        SpendKi(playerid, float(nki));
    }
    UpdateNameLabel(playerid, nlbl, ncolor);
    ShowAttackName(playerid, nlbl);
    return 1;
}

DoFusion(playerid)
{
    new ch = gPlayer[playerid][pCharacter];
    if (ch != 0 && ch != 1)
        return SendClientMessage(playerid, COLOR_GREY, "Only Goku and Vegeta can fuse.");
    if (gPlayer[playerid][pFused])
        return SendClientMessage(playerid, COLOR_GREY, "You are already fused.");

    new skin, color, ki, lbl[24];
    if (ch == 0) { skin = GOGETA;  color = COLOR_BLUE;  ki = 80; lbl = "SUPER GOGETA"; }
    else         { skin = VEGEKU0; color = COLOR_GREEN; ki = 40; lbl = "VEGEKU"; }

    if (!HasKi(playerid, float(ki)))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to fuse!");
    SpendKi(playerid, float(ki));

    gPlayer[playerid][pFused]     = true;
    gPlayer[playerid][pTransform] = 0;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, 11, 3.0);
    SetPlayerSkinMapped(playerid, skin);
    SetPlayerColor(playerid, color);
    UpdateNameLabel(playerid, lbl, color);
    ShowAttackName(playerid, lbl);
    SendClientMessage(playerid, COLOR_YELLOW, "You fused! The fusion expires on your death.");
    return 1;
}
