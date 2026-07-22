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
//  Traveling attacks — blast points advance along the AIM LINE over time.
//  Direction comes from the camera, so you shoot where you LOOK (up/down too,
//  which makes aerial beam duels work). One live beam per player.
// ---------------------------------------------------------------------------
static bool:bActive[MAX_PLAYERS];
static bTimer[MAX_PLAYERS];
static bStep[MAX_PLAYERS];
static bSteps[MAX_PLAYERS];
static E_PATTERN:bPat[MAX_PLAYERS];
static Float:bDmg[MAX_PLAYERS];
static Float:bStart[MAX_PLAYERS];
static Float:bGap[MAX_PLAYERS];
static Float:bOX[MAX_PLAYERS], Float:bOY[MAX_PLAYERS], Float:bOZ[MAX_PLAYERS];
static Float:bDX[MAX_PLAYERS], Float:bDY[MAX_PLAYERS], Float:bDZ[MAX_PLAYERS];

StopBeam(playerid)
{
    if (!bActive[playerid]) return 0;
    bActive[playerid] = false;
    if (bTimer[playerid] != 0) { KillTimer(bTimer[playerid]); bTimer[playerid] = 0; }
    return 1;
}

// beams thicken / detonate along their flight
static StepVisual(E_PATTERN:pat, step, steps, &model, &Float:vr)
{
    switch (pat)
    {
        case PAT_BEAM_S:  { model = EXP_SMALL;  vr = 5.0; }
        case PAT_BEAM_M:  { model = EXP_SMALL;  vr = 8.0; }
        case PAT_BEAM_L:  { if (step < steps / 2) { model = EXP_SMALL; vr = 8.0; } else { model = EXP_BIG; vr = 15.0; } }
        case PAT_RAPID:   { model = EXP_TINY;   vr = 2.0; }
        case PAT_DISC:    { model = EXP_MEDIUM; vr = 3.0; }
        case PAT_BLAST:   { if (step < steps - 1) { model = EXP_TINY; vr = 2.0; } else { model = EXP_BIG; vr = 20.0; } }
        default:          { model = EXP_SMALL;  vr = 5.0; }
    }
}

forward BeamTick(playerid);
public BeamTick(playerid)
{
    if (!IsPlayerConnected(playerid) || !bActive[playerid])
        return StopBeam(playerid);

    new Float:d = bStart[playerid] + float(bStep[playerid]) * bGap[playerid];
    new Float:x = bOX[playerid] + bDX[playerid] * d;
    new Float:y = bOY[playerid] + bDY[playerid] * d;
    new Float:z = bOZ[playerid] + bDZ[playerid] * d;

    new model, Float:vr;
    StepVisual(bPat[playerid], bStep[playerid], bSteps[playerid], model, vr);
    CreateExplosion(x, y, z, model, vr);
    DealDamageAt(playerid, x, y, z, bDmg[playerid]);
    Training_OnBlast(playerid, x, y, z);

    bStep[playerid]++;
    if (bStep[playerid] >= bSteps[playerid]) StopBeam(playerid);
    return 1;
}

static StartBeam(playerid, E_PATTERN:pat, Float:dmg, steps, Float:startDist, Float:gap)
{
    StopBeam(playerid);
    GetPlayerPos(playerid, bOX[playerid], bOY[playerid], bOZ[playerid]);
    bOZ[playerid] += 0.35;
    GetPlayerCameraFrontVector(playerid, bDX[playerid], bDY[playerid], bDZ[playerid]);
    bPat[playerid]   = pat;
    bDmg[playerid]   = dmg;
    bStep[playerid]  = 0;
    bSteps[playerid] = steps;
    bStart[playerid] = startDist;
    bGap[playerid]   = gap;
    bActive[playerid] = true;
    BeamTick(playerid);                                          // muzzle blast now
    bTimer[playerid] = SetTimerEx("BeamTick", 90, true, "i", playerid);
    return 1;
}

FirePattern(playerid, E_PATTERN:pat, Float:dmg)
{
    switch (pat)
    {
        case PAT_BEAM_S: StartBeam(playerid, pat, dmg, 6,  5.0, 5.0);   // 30m
        case PAT_BEAM_M: StartBeam(playerid, pat, dmg, 10, 5.0, 5.0);   // 50m
        case PAT_BEAM_L: StartBeam(playerid, pat, dmg, 16, 5.0, 5.0);   // 80m, detonates heavy
        case PAT_RAPID:  StartBeam(playerid, pat, dmg, 11, 4.0, 4.0);   // 44m burst
        case PAT_DISC:   StartBeam(playerid, pat, dmg, 14, 5.0, 5.0);   // 70m cutter
        case PAT_BLAST:  StartBeam(playerid, pat, dmg, 4,  8.0, 8.0);   // projectile -> 32m boom
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
            new Float:x, Float:y, Float:z, Float:a;
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, a);
            x += 3.0 * floatsin(-a, degrees);
            y += 3.0 * floatcos(-a, degrees);
            CreateExplosion(x, y, z, EXP_TINY, 2.0);
            DealDamageAt(playerid, x, y, z, dmg);
            Training_OnBlast(playerid, x, y, z);
            ApplyAnimation(playerid, "FIGHT_C", "FightC_2", 4.0, false, true, true, false, 0, SYNC_ALL);
        }
    }
    return 1;
}

// ---------------------------------------------------------------------------
DoAttack(playerid)
{
    new cd = ATTACK_COOLDOWN * (100 - TrSpeed(playerid)) / 100;   // Speed Run training cuts the cooldown
    if (cd < ATTACK_COOLDOWN * 6 / 10) cd = ATTACK_COOLDOWN * 6 / 10;
    if (GetTickCount() - gPlayer[playerid][pLastAttack] < cd && gPlayer[playerid][pLastAttack] != 0)
    {
        new secs = (cd - (GetTickCount() - gPlayer[playerid][pLastAttack])) / 1000 + 1;
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

// A short physical strike for Ki-less humans (Hercule / Videl) - no energy.
DoHumanStrike(playerid)
{
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    x += 2.6 * floatsin(-a, degrees);
    y += 2.6 * floatcos(-a, degrees);
    CreateExplosion(x, y, z, EXP_TINY, 2.0);
    DealDamageAt(playerid, x, y, z, 12.0);
    Training_OnBlast(playerid, x, y, z);
    if (gPlayer[playerid][pCharacter] == CHAR_SATAN)
        ApplyAnimation(playerid, "FIGHT_B", "FightB_1", 4.0, false, true, true, false, 0, SYNC_ALL);
    else
        ApplyAnimation(playerid, "FIGHT_C", "FightC_2", 4.0, false, true, true, false, 0, SYNC_ALL);
    return 1;
}

DoKiBlast(playerid)
{
    // Hercule and Videl have no real Ki - they throw hands instead of energy.
    if (gPlayer[playerid][pCharacter] == CHAR_SATAN || gPlayer[playerid][pCharacter] == CHAR_VIDEL)
        return DoHumanStrike(playerid);

    if (!HasKi(playerid, KI_BLAST_COST))
    {
        GameTextForPlayer(playerid, "~r~Not enough Ki!", 1000, 3);
        return 0;
    }
    SpendKi(playerid, KI_BLAST_COST);
    BeginAttack(playerid);

    // quick camera-aimed pot shot
    new Float:x, Float:y, Float:z, Float:dx, Float:dy, Float:dz;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerCameraFrontVector(playerid, dx, dy, dz);
    x += dx * 10.0; y += dy * 10.0; z += dz * 10.0 + 0.35;
    CreateExplosion(x, y, z, EXP_TINY, 0.5);
    DealDamageAt(playerid, x, y, z, 8.0);
    Training_OnBlast(playerid, x, y, z);
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

    new ch = gPlayer[playerid][pCharacter];
    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    if (count <= 1)
        return SendClientMessage(playerid, COLOR_GREY, "This character can't transform.");

    new cur = gPlayer[playerid][pTransform];
    new next = cur + 1;

    // /trans only climbs the ladder - at the top it stays (power down with /base)
    if (next >= count)
        return SendClientMessage(playerid, COLOR_GREY, "This is your final form! Use /base to power down.");

    new bool:free = (GetPlayerInterior(playerid) == 3);

    // training gate: forms must be earned
    if (!gPlayer[playerid][pFused] && next > MaxFormUnlocked(playerid))
    {
        new needed = gFormUnlockLvl[ch][next - 1];
        new m[96]; format(m, sizeof(m), "That form unlocks at level %d - you are level %d. Keep training!", needed, GetCharLevel(playerid));
        return SendClientMessage(playerid, COLOR_RED, m);
    }

    // power-up cooldown: powering up FROM BASE again after a power-down is gated
    if (cur == 0 && !free && gPlayer[playerid][pTransformCd] > gettime())
    {
        new secs = gPlayer[playerid][pTransformCd] - gettime();
        new m[112]; format(m, sizeof(m), "You're still drained - %d min %d sec until you can power up (or die to reset).", secs / 60, secs % 60);
        return SendClientMessage(playerid, COLOR_RED, m);
    }

    new nskin, ncolor, nlbl[24], nki, ncount;
    GetFormInfo(playerid, next, nskin, ncolor, nlbl, nki, ncount);

    if (!free && !HasKi(playerid, float(nki)))
        return SendClientMessage(playerid, COLOR_RED, "Not enough Ki to transform!");

    new Float:oldMax = gPlayer[playerid][pHealthMax];
    gPlayer[playerid][pTransform] = next;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, EXP_SMALL, 3.0);
    SetPlayerSkinMapped(playerid, nskin);
    SetPlayerColor(playerid, ncolor);
    if (!free) SpendKi(playerid, float(nki));

    // powering up ADDS the bonus HP to your current health (no full heal)
    RecalcMaxStats(playerid);
    new Float:hp; GetPlayerHealth(playerid, hp);
    new Float:gain = gPlayer[playerid][pHealthMax] - oldMax;
    if (gain > 0.0) SetPlayerHealth(playerid, hp + gain);

    UpdateNameLabel(playerid, nlbl, ncolor);
    ShowAttackName(playerid, nlbl);
    return 1;
}

// Power down to base form at will (/base) or when Ki runs dry. Starts the cooldown.
DoDetransform(playerid)
{
    if (gPlayer[playerid][pTransform] == 0 && !gPlayer[playerid][pFused])
        return SendClientMessage(playerid, COLOR_GREY, "You are already in your base form.");

    new bool:free = (GetPlayerInterior(playerid) == 3);
    gPlayer[playerid][pFused]     = false;
    gPlayer[playerid][pTransform] = 0;

    new bskin, bcolor, blbl[24], bki, bcount;
    GetFormInfo(playerid, 0, bskin, bcolor, blbl, bki, bcount);
    SetPlayerSkinMapped(playerid, bskin);
    SetPlayerColor(playerid, bcolor);

    RecalcMaxStats(playerid);
    new Float:hp; GetPlayerHealth(playerid, hp);
    if (hp > gPlayer[playerid][pHealthMax]) SetPlayerHealth(playerid, gPlayer[playerid][pHealthMax]);
    UpdateNameLabel(playerid, blbl, bcolor);

    if (!free)
    {
        gPlayer[playerid][pTransformCd] = gettime() + TRANSFORM_COOLDOWN;
        SendClientMessage(playerid, COLOR_YELLOW, "You powered down to base. Wait 10 min (or die) before powering up again.");
    }
    else SendClientMessage(playerid, COLOR_YELLOW, "You powered down to base.");
    return 1;
}

DoFusion(playerid)
{
    if (gFusionLocked)
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
