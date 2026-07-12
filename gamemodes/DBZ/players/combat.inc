/*  DBZ / players / combat.inc  —  moves, transforms, fusion, regen, self-destruct, absorb
 *
 *  Attacks use the player's ACTIVE MOVE (unlocked by level, chosen via /moves)
 *  and deal real scripted damage through DBZ/players/damage.inc.
 */
#if defined _dbz_combat_included
    #endinput
#endif
#define _dbz_combat_included

#define SND_ATTACK  1057   // SOUND_RACE_GO

// ---------------------------------------------------------------------------
//  Attack patterns — each fires visuals AND applies damage per blast point
// ---------------------------------------------------------------------------
static FireStep(playerid, Float:dist, model, Float:visRadius, Float:dmg)
{
    new Float:bx, Float:by, Float:bz;
    CreateExplosionEx(playerid, dist, model, visRadius, bx, by, bz);
    DealDamageAt(playerid, bx, by, bz, dmg);
    Training_OnBlast(playerid, bx, by, bz);     // power-strike targets
    return 1;
}

FirePattern(playerid, E_PATTERN:pat, Float:dmg)
{
    switch (pat)
    {
        case PAT_BEAM_S:
        {
            for (new Float:d = 5.0; d <= 30.0; d += 5.0) FireStep(playerid, d, EXP_SMALL, 5.0, dmg);
        }
        case PAT_BEAM_M:
        {
            for (new Float:d = 5.0; d <= 50.0; d += 5.0) FireStep(playerid, d, EXP_SMALL, 8.0, dmg);
        }
        case PAT_BEAM_L:
        {
            for (new Float:d = 5.0;  d <= 40.0; d += 5.0) FireStep(playerid, d, EXP_SMALL, 8.0, dmg);
            for (new Float:d = 45.0; d <= 80.0; d += 5.0) FireStep(playerid, d, EXP_BIG, 15.0, dmg);
        }
        case PAT_BLAST:
        {
            FireStep(playerid, 25.0, EXP_BIG, 20.0, dmg);
            FireStep(playerid, 32.0, EXP_BIG, 20.0, dmg);
        }
        case PAT_RAPID:
        {
            for (new Float:d = 4.0; d <= 44.0; d += 4.0) FireStep(playerid, d, EXP_TINY, 2.0, dmg);
        }
        case PAT_DISC:
        {
            for (new Float:d = 5.0; d <= 70.0; d += 5.0) FireStep(playerid, d, EXP_MEDIUM, 3.0, dmg);
        }
        case PAT_NOVA:
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            for (new i = 0; i < 8; i++)
            {
                new Float:a = float(i) * 45.0;
                new Float:bx = x + 9.0 * floatsin(-a, degrees);
                new Float:by = y + 9.0 * floatcos(-a, degrees);
                CreateExplosion(bx, by, z, EXP_BIG, 15.0);
                DealDamageAt(playerid, bx, by, z, dmg);
            }
        }
        case PAT_PUNCH:
        {
            FireStep(playerid, 3.0, EXP_TINY, 2.0, dmg);
            ApplyAnimation(playerid, "FIGHT_C", "FightC_2", 4.0, false, true, true, false, 0, SYNC_ALL);
        }
    }
    return 1;
}

// ---------------------------------------------------------------------------
DoAttack(playerid)
{
    if (GetTickCount() - gPlayer[playerid][pLastAttack] < ATTACK_COOLDOWN && gPlayer[playerid][pLastAttack] != 0)
    {
        new secs = (ATTACK_COOLDOWN - (GetTickCount() - gPlayer[playerid][pLastAttack])) / 1000 + 1;
        new m[32]; format(m, sizeof(m), "~r~Wait %d sec", secs);
        GameTextForPlayer(playerid, m, 1200, 3);
        return 0;
    }

    new ch   = gPlayer[playerid][pCharacter];
    new slot = GetActiveMoveSlot(playerid);
    new mi   = ch * 4 + slot;

    new Float:cost = float(gMoves[mi][mvKi]);
    if (!HasKi(playerid, cost))
    {
        GameTextForPlayer(playerid, "~r~Not enough Ki!", 1200, 3);
        return 0;
    }
    SpendKi(playerid, cost);
    gPlayer[playerid][pLastAttack] = GetTickCount();

    PlayerPlaySound(playerid, SND_ATTACK, 0.0, 0.0, 0.0);
    BeginAttack(playerid);
    FirePattern(playerid, gMoves[mi][mvPat], float(gMoves[mi][mvDmg]));

    new aname[32];
    format(aname, sizeof(aname), "%s", gMoves[mi][mvName]);
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
    BeginAttack(playerid);
    FireStep(playerid, 10.0, EXP_TINY, 0.1, 8.0);
    return 1;
}

// ---------------------------------------------------------------------------
GetRegenAmount(playerid)
{
    // regenerate more per press at higher forms/levels
    new base = 2 + gPlayer[playerid][pTransform] * 2 + GetCharLevel(playerid) / 20;
    if (IsAndroid(playerid)) base = 2;
    return base;
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

    new Float:newhp = hp + float(GetRegenAmount(playerid));
    if (newhp > gPlayer[playerid][pHealthMax]) newhp = gPlayer[playerid][pHealthMax];
    SetPlayerHealth(playerid, newhp);
    GameTextForPlayer(playerid, "~g~Regenerating", 700, 3);
    return 1;
}

GetSelfDestructKi(playerid)
{
    return 50 + gPlayer[playerid][pTransform] * 15;
}

DoKill(playerid)
{
    new Float:cost = float(GetSelfDestructKi(playerid));
    if (!HasKi(playerid, cost))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to self-destruct!");
    SpendKi(playerid, cost);

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    BeginAttack(playerid);
    CreateExplosion(x, y, z, EXP_BIG, 60.0);
    DealDamageAt(playerid, x, y, z, 60.0);
    CreateExplosion(x, y, z + 10.0, EXP_BIG, 50.0);
    CreateExplosion(x, y, z + 20.0, EXP_BIG, 50.0);
    PlayerPlaySound(playerid, SND_ATTACK, 0.0, 0.0, 0.0);
    GameTextForPlayer(playerid, "~r~Self-Destruct!", 1500, 3);
    SetPlayerHealth(playerid, 1.0);
    return 1;
}

// Cell: absorb — steal health AND Ki from a nearby fighter.
DoAbsorb(playerid)
{
    if (!gChar[gPlayer[playerid][pCharacter]][cAbsorb])
        return SendClientMessage(playerid, COLOR_GREY, "Only Cell can absorb energy!");
    if (gPlayer[playerid][pAbsorbCd] > 0)
    {
        new m[64]; format(m, sizeof(m), "Absorb recharging - %d sec left.", gPlayer[playerid][pAbsorbCd]);
        return SendClientMessage(playerid, COLOR_GREY, m);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    foreach (new i : Player)
    {
        if (i != playerid && gPlayer[i][pLoggedIn] && IsPlayerInRangeOfPoint(i, 3.0, x, y, z))
        {
            new Float:th, Float:sh;
            GetPlayerHealth(i, th);        SetPlayerHealth(i, th - ABSORB_AMOUNT);
            GetPlayerHealth(playerid, sh);
            new Float:newhp = sh + ABSORB_AMOUNT;
            if (newhp > gPlayer[playerid][pHealthMax]) newhp = gPlayer[playerid][pHealthMax];
            SetPlayerHealth(playerid, newhp);
            GiveKi(playerid, ABSORB_AMOUNT);

            gPlayer[i][pLastHitBy]   = playerid;
            gPlayer[i][pLastHitTick] = GetTickCount();
            gPlayer[playerid][pAbsorbCd] = ABSORB_COOLDOWN;

            PlayerPlaySound(playerid, SND_ATTACK, 0.0, 0.0, 0.0);
            SendClientMessage(playerid, COLOR_GREEN, "Perfect... your energy is mine!");
            SendClientMessage(i, COLOR_RED, "Cell absorbed your energy!");
            GiveCharXP(playerid, XP_PER_HIT);
            return 1;
        }
    }
    SendClientMessage(playerid, COLOR_GREY, "Nobody is near you to absorb!");
    return 1;
}

// Goku: Kaioken — 10 second x1.5 damage burst (level 15+).
DoKaioken(playerid)
{
    if (gPlayer[playerid][pCharacter] != CHAR_GOKU)
        return SendClientMessage(playerid, COLOR_GREY, "Only Goku knows the Kaioken!");
    if (GetCharLevel(playerid) < 15)
        return SendClientMessage(playerid, COLOR_GREY, "Kaioken unlocks at level 15 - keep training!");
    if (gPlayer[playerid][pKaiokenUntil] + 60 > gettime())
    {
        new m[64]; format(m, sizeof(m), "Kaioken recharging - %d sec left.", gPlayer[playerid][pKaiokenUntil] + 60 - gettime());
        return SendClientMessage(playerid, COLOR_GREY, m);
    }
    if (!HasKi(playerid, 30.0))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki for Kaioken (30)!");
    SpendKi(playerid, 30.0);

    gPlayer[playerid][pKaiokenUntil] = gettime() + 10;
    SetPlayerColor(playerid, COLOR_RED);
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, EXP_SMALL, 3.0);
    ShowAttackName(playerid, "KAIOKEN!");
    return 1;
}

// ---------------------------------------------------------------------------
DoTransform(playerid)
{
    if (gTransformsLocked)
        return SendClientMessage(playerid, COLOR_GREY, "Transformations are being remastered with proper form models - locked for now. Your training still counts!");

    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    if (count <= 1)
        return SendClientMessage(playerid, COLOR_GREY, "This character can't transform.");

    new next = gPlayer[playerid][pTransform] + 1;
    if (next >= count) next = 0;

    // training gate: forms must be earned
    if (next != 0 && !gPlayer[playerid][pFused] && next > MaxFormUnlocked(playerid))
    {
        new needed = (gPlayer[playerid][pCharacter] == CHAR_CELL) ? 25 : ((next == 1) ? 10 : ((next == 2) ? 20 : 35));
        new m[96]; format(m, sizeof(m), "That form unlocks at level %d - you are level %d. Keep training!", needed, GetCharLevel(playerid));
        return SendClientMessage(playerid, COLOR_RED, m);
    }

    new nskin, ncolor, nlbl[24], nki, ncount;
    GetFormInfo(playerid, next, nskin, ncolor, nlbl, nki, ncount);

    new bool:free = (GetPlayerInterior(playerid) == 3);
    if (!free && next != 0 && !HasKi(playerid, float(nki)))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to transform!");

    gPlayer[playerid][pTransform] = next;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, EXP_SMALL, 3.0);
    SetPlayerSkinMapped(playerid, nskin);
    SetPlayerColor(playerid, ncolor);

    if (next == 0)
    {
        if (!free) SetKi(playerid, 0.0);
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
    if (gTransformsLocked)
        return SendClientMessage(playerid, COLOR_GREY, "Fusion is being remastered with proper models - locked for now.");

    new ch = gPlayer[playerid][pCharacter];
    if (ch != CHAR_GOKU && ch != CHAR_VEGETA)
        return SendClientMessage(playerid, COLOR_GREY, "Only Goku and Vegeta can fuse.");
    if (gPlayer[playerid][pFused])
        return SendClientMessage(playerid, COLOR_GREY, "You are already fused.");
    if (!FusionUnlocked(playerid))
    {
        new m[96]; format(m, sizeof(m), "Fusion unlocks at level 30 - you are level %d. Keep training!", GetCharLevel(playerid));
        return SendClientMessage(playerid, COLOR_RED, m);
    }

    new skin, color, ki, lbl[24];
    if (ch == CHAR_GOKU) { skin = GOGETA;  color = COLOR_BLUE;  ki = 80; lbl = "SUPER GOGETA"; }
    else                 { skin = VEGEKU0; color = COLOR_GREEN; ki = 40; lbl = "VEGEKU"; }

    if (!HasKi(playerid, float(ki)))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to fuse!");
    SpendKi(playerid, float(ki));

    gPlayer[playerid][pFused]     = true;
    gPlayer[playerid][pTransform] = 0;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, EXP_SMALL, 3.0);
    SetPlayerSkinMapped(playerid, skin);
    SetPlayerColor(playerid, color);
    UpdateNameLabel(playerid, lbl, color);
    ShowAttackName(playerid, lbl);
    SendClientMessage(playerid, COLOR_YELLOW, "You fused! The fusion expires on your death.");
    return 1;
}
