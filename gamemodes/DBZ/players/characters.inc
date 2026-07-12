/*  DBZ / players / characters.inc  —  12-character roster, form ladders, fx helpers
 *
 *  Roster: Goku, Vegeta, Trunks, Gohan, Mr.Satan, Videl, Krillin, Yamcha, Tien,
 *          Android 16, Piccolo, Cell.
 *  cBasePower is the lore-based starting power; training levels add on top, so a
 *  dedicated Hercule can eventually out-punch a lazy Saiyan (see progression.inc).
 */
#if defined _dbz_characters_included
    #endinput
#endif
#define _dbz_characters_included

enum E_CHAR
{
    cSkin,              // stock identity skin (custom model mapped on top)
    cStyle,
    cLabel[16],
    cColor,
    cGt[4],
    bool:cAndroid,      // no Ki mechanics
    bool:cAbsorb,       // can /absorb (Cell)
    bool:cWeak,         // "weak human": no armour on spawn
    cCharge,            // Ki per 250ms charge tick
    cKiCap,             // base Ki cap (level adds on top)
    cBasePower,         // lore base power (1-100)
    cBaseHp             // base max health
}

new const gChar[MAX_CHARACTERS][E_CHAR] =
{
    //  skin        style                  label         colour           gt     androd absorb weak  chg cap  pow  hp
    {GOKU0,       FIGHT_STYLE_KUNGFU,   "GOKU",       COLOR_WHITE,     "~r~", false, false, false, 5, 100, 90, 150},
    {VEGETA0,     FIGHT_STYLE_KUNGFU,   "VEGETA",     COLOR_WHITE,     "~b~", false, false, false, 5, 100, 88, 150},
    {TRUNKS0,     FIGHT_STYLE_KUNGFU,   "TRUNKS",     COLOR_WHITE,     "~y~", false, false, false, 5, 100, 78, 150},
    {GOHAN0,      FIGHT_STYLE_KUNGFU,   "GOHAN",      COLOR_WHITE,     "~g~", false, false, false, 5, 100, 85, 150},
    {SATAN,       FIGHT_STYLE_BOXING,   "HERCULE",    COLOR_PINK,      "~p~", false, false, true,  3, 75,  10, 150},
    {VIDEL,       FIGHT_STYLE_BOXING,   "VIDEL",      COLOR_PINK,      "~p~", false, false, true,  4, 90,  25, 150},
    {CRILIN,      FIGHT_STYLE_KUNGFU,   "KRILLIN",    COLOR_WHITE,     "~r~", false, false, false, 5, 100, 50, 150},
    {YAMCHA,      FIGHT_STYLE_KUNGFU,   "YAMCHA",     COLOR_WHITE,     "~b~", false, false, false, 5, 100, 45, 150},
    {TENSHINSHAN, FIGHT_STYLE_KUNGFU,   "TIEN",       COLOR_WHITE,     "~y~", false, false, false, 5, 100, 55, 150},
    {ANDROID16,   FIGHT_STYLE_KNEEHEAD, "ANDROID 16", COLOR_LIGHTBLUE, "~p~", true,  false, false, 0, 0,   75, 180},
    {PICCOLO,     FIGHT_STYLE_KUNGFU,   "PICCOLO",    COLOR_GREEN,     "~g~", false, false, false, 5, 105, 80, 150},
    {CELL,        FIGHT_STYLE_GRABKICK, "CELL",       COLOR_VIOLET,    "~p~", false, true,  false, 6, 110, 92, 160}
};

// character indices (readability)
#define CHAR_GOKU       0
#define CHAR_VEGETA     1
#define CHAR_TRUNKS     2
#define CHAR_GOHAN      3
#define CHAR_SATAN      4
#define CHAR_VIDEL      5
#define CHAR_KRILLIN    6
#define CHAR_YAMCHA     7
#define CHAR_TIEN       8
#define CHAR_A16        9
#define CHAR_PICCOLO    10
#define CHAR_CELL       11

// --- transformation ladders (index 0 = base) ---
enum E_FORM { fSkin, fColor, fLabel[20], fKi }

new const gGokuForms[][E_FORM] =
{
    {GOKU0, COLOR_WHITE,  "GOKU",       0},
    {GOKU1, COLOR_YELLOW, "GOKU SSJ",   30},
    {GOKU2, COLOR_ORANGE, "GOKU SSJ2",  40},
    {GOKU3, COLOR_RED,    "GOKU SSJ3",  50}
};
new const gVegetaForms[][E_FORM] =
{
    {VEGETA0, COLOR_WHITE,  "VEGETA",       0},
    {VEGETA1, COLOR_YELLOW, "VEGETA SSJ",   30},
    {VEGETAS, COLOR_ORANGE, "SUPER VEGETA", 35},
    {VEGETA2, COLOR_RED,    "VEGETA SSJ2",  40}
};
new const gTrunksForms[][E_FORM] =
{
    {TRUNKS0, COLOR_WHITE,  "TRUNKS",       0},
    {TRUNKS1, COLOR_YELLOW, "TRUNKS SSJ",   30},
    {TRUNKSS, COLOR_ORANGE, "SUPER TRUNKS", 20}
};
new const gGohanForms[][E_FORM] =
{
    {GOHAN0, COLOR_WHITE,  "GOHAN",      0},
    {GOHAN1, COLOR_YELLOW, "GOHAN SSJ",  30},
    {GOHAN2, COLOR_ORANGE, "GOHAN SSJ2", 20}
};
new const gCellForms[][E_FORM] =
{
    {CELL,       COLOR_VIOLET, "PERFECT CELL",       0},
    {CELL_SUPER, COLOR_YELLOW, "SUPER PERFECT CELL", 60}
};
new const gVegekuForms[][E_FORM] =
{
    {VEGEKU0, COLOR_GREEN, "VEGEKU",       0},
    {VEGEKU1, COLOR_BLUE,  "SUPER VEGEKU", 60}
};

// ---------------------------------------------------------------------------
stock bool:IsAndroid(playerid)
{
    new ch = gPlayer[playerid][pCharacter];
    if (ch < 0 || ch >= MAX_CHARACTERS) return false;
    return bool:gChar[ch][cAndroid];
}

UpdateNameLabel(playerid, const label[], color)
{
    if (gPlayer[playerid][pLabel] == Text3D:INVALID_3DTEXT_ID)
    {
        gPlayer[playerid][pLabel] = Create3DTextLabel(label, color, 0.0, 0.0, 0.0, 20.0, 0, true);
        Attach3DTextLabelToPlayer(gPlayer[playerid][pLabel], playerid, 0.0, 0.0, 0.4);
    }
    else
    {
        Update3DTextLabelText(gPlayer[playerid][pLabel], color, label);
    }
    return 1;
}

ShowAttackName(playerid, const name[])
{
    new Float:x, Float:y, Float:z, txt[64];
    GetPlayerPos(playerid, x, y, z);
    format(txt, sizeof(txt), "~y~%s", name);
    foreach (new i : Player)
        if (IsPlayerInRangeOfPoint(i, 75.0, x, y, z))
            GameTextForPlayer(i, txt, 2000, 1);
    return 1;
}

// Resolve form data for the player's current ladder + index.
GetFormInfo(playerid, idx, &skin, &color, label[], &ki, &count)
{
    new ch = gPlayer[playerid][pCharacter];
    if (gPlayer[playerid][pFused])
    {
        if (ch == CHAR_GOKU)
        {
            count = 1; skin = GOGETA; color = COLOR_BLUE; ki = 0; format(label, 24, "SUPER GOGETA");
            return 1;
        }
        count = sizeof(gVegekuForms);
        if (idx < 0) idx = 0; if (idx >= count) idx = count - 1;
        skin = gVegekuForms[idx][fSkin]; color = gVegekuForms[idx][fColor]; ki = gVegekuForms[idx][fKi];
        format(label, 24, "%s", gVegekuForms[idx][fLabel]);
        return 1;
    }
    switch (ch)
    {
        case CHAR_GOKU:   { count = sizeof(gGokuForms);   if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gGokuForms[idx][fSkin];   color=gGokuForms[idx][fColor];   ki=gGokuForms[idx][fKi];   format(label,24,"%s",gGokuForms[idx][fLabel]); }
        case CHAR_VEGETA: { count = sizeof(gVegetaForms); if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gVegetaForms[idx][fSkin]; color=gVegetaForms[idx][fColor]; ki=gVegetaForms[idx][fKi]; format(label,24,"%s",gVegetaForms[idx][fLabel]); }
        case CHAR_TRUNKS: { count = sizeof(gTrunksForms); if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gTrunksForms[idx][fSkin]; color=gTrunksForms[idx][fColor]; ki=gTrunksForms[idx][fKi]; format(label,24,"%s",gTrunksForms[idx][fLabel]); }
        case CHAR_GOHAN:  { count = sizeof(gGohanForms);  if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gGohanForms[idx][fSkin];  color=gGohanForms[idx][fColor];  ki=gGohanForms[idx][fKi];  format(label,24,"%s",gGohanForms[idx][fLabel]); }
        case CHAR_CELL:   { count = sizeof(gCellForms);   if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gCellForms[idx][fSkin];   color=gCellForms[idx][fColor];   ki=gCellForms[idx][fKi];   format(label,24,"%s",gCellForms[idx][fLabel]); }
        default:          { count = 1; skin = gChar[ch][cSkin]; color = gChar[ch][cColor]; ki = 0; format(label, 24, "%s", gChar[ch][cLabel]); }
    }
    return 1;
}

// Fire an explosion `distance` metres ahead of the player's facing angle,
// returning the blast coordinates so callers can apply scripted damage there.
CreateExplosionEx(playerid, Float:distance, type, Float:radius, &Float:bx, &Float:by, &Float:bz)
{
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    bx = x + (distance * floatsin(-a, degrees));
    by = y + (distance * floatcos(-a, degrees));
    bz = z;
    CreateExplosion(bx, by, bz, type, radius);
    return 1;
}
