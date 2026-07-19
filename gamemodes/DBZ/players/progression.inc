/*  DBZ / players / progression.inc  —  per-character levels, XP, power, unlocks
 *
 *  Every account levels each of the 12 characters INDEPENDENTLY. A character's
 *  effective power = lore base power + 2 per level, so a well-trained Hercule
 *  really can out-punch a lazy Saiyan.
 *
 *  Unlocks are level-derived (earnable, no purchase):
 *    - Moves:      slot 0 at lvl 1, slot 1 at 8, slot 2 at 18, slot 3 at 30
 *    - Transforms: form 1 at lvl 10, form 2 at 20, form 3 at 35 (Cell: 25); fusion at 30
 *    - Alt skins:  variant 2 at lvl 5, 3 at 15, 4 at 25, 5 at 35
 */
#if defined _dbz_progression_included
    #endinput
#endif
#define _dbz_progression_included

#define MAX_CHAR_LEVEL      100
#define XP_PER_HIT          3
#define XP_KILL_BASE        40

enum E_PROG
{
    prLevel,
    prXP,
    prActiveMove,       // chosen move slot 0-3
    prActiveSkin,       // chosen skin variant 0-4
    prKills,
    prDeaths,
    bool:prDirty        // needs DB save
}
new gProg[MAX_PLAYERS][MAX_CHARACTERS][E_PROG];

// ---------------------------------------------------------------------------
//  Move table: 4 moves per character (index = character*4 + slot)
// ---------------------------------------------------------------------------
enum E_PATTERN
{
    PAT_BEAM_S,     // short beam
    PAT_BEAM_M,     // medium beam
    PAT_BEAM_L,     // long heavy beam
    PAT_BLAST,      // single big blast ahead
    PAT_RAPID,      // rapid small bursts
    PAT_DISC,       // narrow long cutter
    PAT_NOVA,       // radial explosion around self
    PAT_PUNCH       // close-range strike
}

enum E_MOVE { mvName[28], mvKi, mvDmg, E_PATTERN:mvPat }

new const gMoves[MAX_CHARACTERS * 4][E_MOVE] =
{
    // Goku
    {"Kamehameha",              25, 22, PAT_BEAM_M},
    {"Kaioken Kamehameha",      30, 28, PAT_BEAM_M},
    {"Super Kamehameha",        40, 36, PAT_BEAM_L},
    {"Spirit Bomb",             70, 50, PAT_BLAST},
    // Vegeta
    {"Galick Gun",              25, 22, PAT_BEAM_M},
    {"Big Bang Attack",         30, 28, PAT_BLAST},
    {"Final Flash",             40, 36, PAT_BEAM_L},
    {"Final Explosion",         70, 50, PAT_NOVA},
    // Trunks
    {"Buster Cannon",           25, 22, PAT_BEAM_M},
    {"Burning Attack",          30, 28, PAT_BLAST},
    {"Finish Buster",           40, 36, PAT_BLAST},
    {"Heat Dome Attack",        70, 50, PAT_NOVA},
    // Gohan
    {"Masenko",                 25, 22, PAT_BEAM_M},
    {"Super Masenko",           30, 28, PAT_BEAM_M},
    {"Father-Son Kamehameha",   40, 36, PAT_BEAM_L},
    {"Ultimate Kamehameha",     70, 50, PAT_BEAM_L},
    // Mr. Satan
    {"Dynamite Kick",           10, 18, PAT_PUNCH},
    {"Champion Punch",          15, 24, PAT_PUNCH},
    {"Megaton Punch",           20, 32, PAT_PUNCH},
    {"Present For You",         30, 45, PAT_BLAST},
    // Videl
    {"Straight Right",          15, 20, PAT_PUNCH},
    {"Eagle Kick",              20, 26, PAT_PUNCH},
    {"Flying Knee",             30, 34, PAT_PUNCH},
    {"Justice Combination",     45, 48, PAT_PUNCH},
    // Krillin
    {"Kamehameha",              25, 22, PAT_BEAM_M},
    {"Scatter Shot",            30, 26, PAT_RAPID},
    {"Destructo Disc",          40, 40, PAT_DISC},
    {"Double Destructo Disc",   65, 52, PAT_DISC},
    // Yamcha
    {"Wolf Fang Fist",          25, 22, PAT_PUNCH},
    {"Kamehameha",              30, 26, PAT_BEAM_M},
    {"Spirit Ball",             40, 34, PAT_BLAST},
    {"Neo Wolf Fang Fist",      60, 48, PAT_RAPID},
    // Tien
    {"Dodon Ray",               25, 22, PAT_BEAM_S},
    {"Solar Flare Strike",      30, 26, PAT_PUNCH},
    {"Tri-Beam",                45, 38, PAT_BEAM_L},
    {"Neo Tri-Beam",            70, 52, PAT_BEAM_L},
    // Android 16
    {"Rocket Punch",            0,  22, PAT_BLAST},
    {"Eye Beam",                0,  26, PAT_BEAM_S},
    {"Hell Flash",              0,  38, PAT_BEAM_L},
    {"Inferno Flash",           0,  50, PAT_BEAM_L},
    // Piccolo
    {"Demon Wave",              25, 22, PAT_BEAM_M},
    {"Destructive Wave",        30, 26, PAT_BEAM_M},
    {"Special Beam Cannon",     45, 42, PAT_DISC},
    {"Hellzone Grenade",        65, 48, PAT_NOVA},
    // Cell
    {"Ki Barrage",              25, 24, PAT_RAPID},
    {"Galick Gun",              30, 28, PAT_BEAM_M},
    {"Perfect Kamehameha",      45, 38, PAT_BEAM_L},
    {"Solar Kamehameha",        75, 54, PAT_BEAM_L}
};

new const gMoveSlotLevel[4]    = {1, 8, 18, 30};
new const gSkinSlotLevel[5]    = {1, 5, 15, 25, 35};

// Alt skin variants per character (custom model ids for the BASE form; 0 = none)
// Appearances are NON-transformation outfits only; form models (Vegeta SSJ/
// SSJ2/God/Blue, Gohan SSJ/SSJ2, Trunks SSJ/Super) belong to the /trans ladder.
new const gSkinVariants[MAX_CHARACTERS][5] =
{
    {SKIN_CUSTOM_GOKU,   0, 0, 0, 0},                                                                         // Goku (V2-V5 reserved for SSJ/SSJ2/SSJ3 transform skins)
    {SKIN_CUSTOM_VEGETA, 0, 0, 0, 0},                                                                         // Vegeta (forms via /trans)
    {SKIN_CUSTOM_TRUNKS, 0, 0, 0, 0},                                                                         // Trunks (forms via /trans)
    {SKIN_CUSTOM_GOHAN,  0, 0, 0, 0},                                                                         // Gohan  (forms via /trans)
    {SKIN_CUSTOM_SATAN,  0, 0, 0, 0},                                                                         // Mr. Satan
    {SKIN_CUSTOM_VIDEL,  SKIN_CUSTOM_VIDEL2, SKIN_CUSTOM_VIDEL3, SKIN_CUSTOM_VIDEL4, SKIN_CUSTOM_VIDEL5},     // Videl
    {0, 0, 0, 0, 0},                                                                                          // Krillin (LOCKED)
    {SKIN_CUSTOM_YAMCHA, SKIN_CUSTOM_YAMCHA2, SKIN_CUSTOM_YAMCHA3, 0, 0},                                     // Yamcha
    {0, 0, 0, 0, 0},                                                                                          // Tien (LOCKED)
    {SKIN_CUSTOM_ANDROID16, 0, 0, 0, 0},                                                                      // Android 16 (LOCKED)
    {SKIN_CUSTOM_PICCOLO, SKIN_CUSTOM_PICCOLO2, 0, 0, 0},                                                     // Piccolo
    {SKIN_CUSTOM_CELL,   0, 0, 0, 0}                                                                          // Cell
};

// ---------------------------------------------------------------------------
//  Core accessors
// ---------------------------------------------------------------------------
Prog_Reset(playerid)
{
    for (new c = 0; c < MAX_CHARACTERS; c++)
    {
        gProg[playerid][c][prLevel]      = 1;
        gProg[playerid][c][prXP]         = 0;
        gProg[playerid][c][prActiveMove] = 0;
        gProg[playerid][c][prActiveSkin] = 0;
        gProg[playerid][c][prKills]      = 0;
        gProg[playerid][c][prDeaths]     = 0;
        gProg[playerid][c][prDirty]      = false;
    }
    return 1;
}

stock GetCharLevel(playerid, ch = -1)
{
    if (ch < 0) ch = gPlayer[playerid][pCharacter];
    return gProg[playerid][ch][prLevel];
}

#define FORM_POWER_BONUS 15   // flat base-stat boost per transformation tier

// Effective power: lore base + 2 per trained level (+15 per active form tier).
stock GetEffPower(playerid, ch = -1)
{
    if (ch < 0) ch = gPlayer[playerid][pCharacter];
    new eff = gChar[ch][cBasePower] + 2 * (gProg[playerid][ch][prLevel] - 1);
    if (ch == gPlayer[playerid][pCharacter])
    {
        eff += FORM_POWER_BONUS * gPlayer[playerid][pTransform];
        if (gPlayer[playerid][pFused]) eff += FORM_POWER_BONUS * 2;
    }
    return eff;
}

// Number of transform tiers per character (ladder length incl. base).
stock GetFormCount(ch)
{
    switch (ch)
    {
        case CHAR_GOKU:   return 4;
        case CHAR_VEGETA: return 5;
        case CHAR_TRUNKS: return 3;
        case CHAR_GOHAN:  return 3;
        case CHAR_CELL:   return 2;
    }
    return 1;
}

stock XPNeeded(level)
{
    return 75 + 25 * level;
}

// Per-character unlock level for form index 1..4 (0 = no such form).
// Vegeta Blue is ENDGAME @ 80.
new const gFormUnlockLvl[MAX_CHARACTERS][4] =
{
    {10, 20, 35, 0},    // Goku   (SSJ/SSJ2/SSJ3)
    {10, 20, 80, 0},    // Vegeta (SSJ/Super Vegeta/Blue)
    {10, 0, 0, 0},      // Trunks (SSJ only)
    {10, 20, 0, 0},     // Gohan
    {0, 0, 0, 0},       // Mr. Satan
    {0, 0, 0, 0},       // Videl
    {0, 0, 0, 0},       // Krillin
    {0, 0, 0, 0},       // Yamcha
    {0, 0, 0, 0},       // Tien
    {0, 0, 0, 0},       // Android 16
    {0, 0, 0, 0},       // Piccolo
    {25, 0, 0, 0}       // Cell (Super Perfect)
};

// Highest transform index unlocked (0 = base only).
stock MaxFormUnlocked(playerid, ch = -1)
{
    if (ch < 0) ch = gPlayer[playerid][pCharacter];
    new lvl = gProg[playerid][ch][prLevel], unlocked = 0;
    for (new i = 0; i < 4; i++)
    {
        if (gFormUnlockLvl[ch][i] == 0 || lvl < gFormUnlockLvl[ch][i]) break;
        unlocked = i + 1;
    }
    new maxIdx = GetFormCount(ch) - 1;
    return (unlocked > maxIdx) ? maxIdx : unlocked;
}

stock bool:FusionUnlocked(playerid)
{
    return (GetCharLevel(playerid) >= 30);
}

stock bool:MoveUnlocked(playerid, slot)
{
    if (slot < 0 || slot > 3) return false;
    return (GetCharLevel(playerid) >= gMoveSlotLevel[slot]);
}

// Active move slot, clamped to what's actually unlocked.
stock GetActiveMoveSlot(playerid)
{
    new ch = gPlayer[playerid][pCharacter];
    new slot = gProg[playerid][ch][prActiveMove];
    if (!MoveUnlocked(playerid, slot)) slot = 0;
    return slot;
}

// ---------------------------------------------------------------------------
//  Skin mapping (custom 0.3DL models over stock identity skins)
// ---------------------------------------------------------------------------
SetPlayerSkinMapped(playerid, skin)
{
    new ch = gPlayer[playerid][pCharacter];

    // Base-form skin: honour the player's chosen (and unlocked) variant.
    if (ch >= 0 && ch < MAX_CHARACTERS && skin == gChar[ch][cSkin])
    {
        new v = gProg[playerid][ch][prActiveSkin];
        if (v < 0 || v > 4 || GetCharLevel(playerid, ch) < gSkinSlotLevel[v] || gSkinVariants[ch][v] == 0)
            v = 0;
        if (gSkinVariants[ch][v] != 0)
            return SetPlayerSkin(playerid, gSkinVariants[ch][v]);
        return SetPlayerSkin(playerid, skin);
    }

    // Transform-form skins with dedicated custom models.
    switch (skin)
    {
        case VEGETA1:     return SetPlayerSkin(playerid, SKIN_CUSTOM_VEGETA_V2);   // SSJ
        case VEGETA2:     return SetPlayerSkin(playerid, SKIN_CUSTOM_VEGETA_V3);   // SSJ2
        case VEGETA_GOD:  return SetPlayerSkin(playerid, SKIN_CUSTOM_VEGETA_V4);   // God
        case VEGETA_BLUE: return SetPlayerSkin(playerid, SKIN_CUSTOM_VEGETA_V5);   // Blue
        case GOHAN1:      return SetPlayerSkin(playerid, SKIN_CUSTOM_GOHAN_V2);    // SSJ
        case GOHAN2:      return SetPlayerSkin(playerid, SKIN_CUSTOM_GOHAN_V3);    // SSJ2
        case TRUNKS1:     return SetPlayerSkin(playerid, SKIN_CUSTOM_TRUNKS_V2);   // SSJ
        case TRUNKSS:     return SetPlayerSkin(playerid, SKIN_CUSTOM_TRUNKS_V3);   // Super
        case CELL_SUPER:  return SetPlayerSkin(playerid, SKIN_CUSTOM_CELL);        // same model
        case GOKU1:       return SetPlayerSkin(playerid, SKIN_CUSTOM_GOKU_V2);     // SSJ
        case GOKU2:       return SetPlayerSkin(playerid, SKIN_CUSTOM_GOKU_V3);     // SSJ2
        case GOKU3:       return SetPlayerSkin(playerid, SKIN_CUSTOM_GOKU_V4);     // SSJ3
    }
    return SetPlayerSkin(playerid, skin);
}

// ---------------------------------------------------------------------------
//  XP + level-ups
// ---------------------------------------------------------------------------
GiveCharXP(playerid, amount)
{
    if (!gPlayer[playerid][pLoggedIn]) return 0;
    new ch = gPlayer[playerid][pCharacter];
    if (ch < 0 || ch >= MAX_CHARACTERS) return 0;

    // Gohan: hidden potential — +25% XP
    if (ch == CHAR_GOHAN) amount = (amount * 5) / 4;

    gProg[playerid][ch][prXP] += amount;
    gProg[playerid][ch][prDirty] = true;

    new bool:leveled = false;
    while (gProg[playerid][ch][prLevel] < MAX_CHAR_LEVEL
        && gProg[playerid][ch][prXP] >= XPNeeded(gProg[playerid][ch][prLevel]))
    {
        gProg[playerid][ch][prXP] -= XPNeeded(gProg[playerid][ch][prLevel]);
        gProg[playerid][ch][prLevel]++;
        leveled = true;
        AnnounceLevelUnlocks(playerid, ch, gProg[playerid][ch][prLevel]);
    }

    if (leveled)
    {
        new lvl = gProg[playerid][ch][prLevel], m[144];
        format(m, sizeof(m), "~g~LEVEL UP!~n~~w~%s Lv.%d~n~~y~Power %d", gChar[ch][cLabel], lvl, GetEffPower(playerid, ch));
        GameTextForPlayer(playerid, m, 3500, 3);
        PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

        // stats grow with training
        gPlayer[playerid][pHealthMax] = float(gChar[ch][cBaseHp] + gProg[playerid][ch][prLevel]);
        if (!gChar[ch][cAndroid])
            gPlayer[playerid][pKiMax] = float(gChar[ch][cKiCap] + gProg[playerid][ch][prLevel]);
        UpdateKiBar(playerid);
    }
    return 1;
}

AnnounceLevelUnlocks(playerid, ch, lvl)
{
    new m[128];
    for (new s = 0; s < 4; s++)
        if (gMoveSlotLevel[s] == lvl)
        {
            format(m, sizeof(m), "UNLOCKED: new move '%s' - pick it with /moves!", gMoves[ch * 4 + s][mvName]);
            SendClientMessage(playerid, COLOR_GREEN, m);
        }
    for (new v = 1; v < 5; v++)
        if (gSkinSlotLevel[v] == lvl && gSkinVariants[ch][v] != 0)
            SendClientMessage(playerid, COLOR_GREEN, "UNLOCKED: new appearance - pick it with /skins!");

    if (!gTransformsLocked)
    {
        for (new i = 0; i < 4; i++)
            if (gFormUnlockLvl[ch][i] == lvl && i <= GetFormCount(ch) - 2)
            {
                SendClientMessage(playerid, COLOR_GREEN, "UNLOCKED: a new TRANSFORMATION - use /trans!");
                break;
            }
    }
    if (lvl == 10 && ch == CHAR_TRUNKS)
        SendClientMessage(playerid, COLOR_GREEN, "UNLOCKED: Trunks' sword - equipped on spawn!");
    if (lvl == 15 && ch == CHAR_GOKU)
        SendClientMessage(playerid, COLOR_GREEN, "UNLOCKED: KAIOKEN - use /kaioken for a 10s power burst!");
    return 1;
}

// ---------------------------------------------------------------------------
//  MySQL sync (player_characters)
// ---------------------------------------------------------------------------
Prog_LoadAll(playerid)
{
    if (!gDBConnected || gPlayer[playerid][pDBID] == 0) return 0;
    new q[160];
    mysql_format(g_SQL, q, sizeof(q),
        "SELECT * FROM `player_characters` WHERE `account_id` = %d", gPlayer[playerid][pDBID]);
    mysql_pquery(g_SQL, q, "OnCharProgLoad", "i", playerid);
    return 1;
}

forward OnCharProgLoad(playerid);
public OnCharProgLoad(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    new rows = cache_num_rows();
    for (new i = 0; i < rows; i++)
    {
        new ch;
        cache_get_value_name_int(i, "character_id", ch);
        if (ch < 0 || ch >= MAX_CHARACTERS) continue;
        cache_get_value_name_int(i, "level",       gProg[playerid][ch][prLevel]);
        cache_get_value_name_int(i, "xp",          gProg[playerid][ch][prXP]);
        cache_get_value_name_int(i, "active_move", gProg[playerid][ch][prActiveMove]);
        cache_get_value_name_int(i, "active_skin", gProg[playerid][ch][prActiveSkin]);
        cache_get_value_name_int(i, "kills",       gProg[playerid][ch][prKills]);
        cache_get_value_name_int(i, "deaths",      gProg[playerid][ch][prDeaths]);
        if (gProg[playerid][ch][prLevel] < 1) gProg[playerid][ch][prLevel] = 1;
    }
    return 1;
}

Prog_SaveAll(playerid)
{
    if (!gDBConnected || !gPlayer[playerid][pLoggedIn] || gPlayer[playerid][pDBID] == 0) return 0;
    new q[512];
    for (new c = 0; c < MAX_CHARACTERS; c++)
    {
        if (!gProg[playerid][c][prDirty]) continue;
        mysql_format(g_SQL, q, sizeof(q),
            "INSERT INTO `player_characters` (`account_id`,`character_id`,`level`,`xp`,`active_move`,`active_skin`,`kills`,`deaths`) VALUES (%d,%d,%d,%d,%d,%d,%d,%d) ON DUPLICATE KEY UPDATE `level`=%d,`xp`=%d,`active_move`=%d,`active_skin`=%d,`kills`=%d,`deaths`=%d",
            gPlayer[playerid][pDBID], c,
            gProg[playerid][c][prLevel], gProg[playerid][c][prXP], gProg[playerid][c][prActiveMove],
            gProg[playerid][c][prActiveSkin], gProg[playerid][c][prKills], gProg[playerid][c][prDeaths],
            gProg[playerid][c][prLevel], gProg[playerid][c][prXP], gProg[playerid][c][prActiveMove],
            gProg[playerid][c][prActiveSkin], gProg[playerid][c][prKills], gProg[playerid][c][prDeaths]);
        mysql_pquery(g_SQL, q);
        gProg[playerid][c][prDirty] = false;
    }
    return 1;
}
