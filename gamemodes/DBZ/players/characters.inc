/*  DBZ / players / characters.inc  —  14-character data, transform ladders, fx  */
#if defined _dbz_characters_included
    #endinput
#endif
#define _dbz_characters_included

enum E_CHAR
{
    cSkin,
    cStyle,
    cLabel[16],
    cColor,
    cGt[4],
    bool:cAndroid,
    bool:cAbsorb,
    bool:cWeak,
    cCharge,        // Ki per 250ms charge tick
    cKiCap,         // default Ki cap
    cDefAtkKi       // default attack Ki cost
}

new const gChar[MAX_CHARACTERS][E_CHAR] =
{
    {GOKU0,       FIGHT_STYLE_KUNGFU,   "GOKU",      COLOR_WHITE,     "~r~", false, false, false, 5, 100, 25},
    {VEGETA0,     FIGHT_STYLE_KUNGFU,   "VEGETA",    COLOR_WHITE,     "~b~", false, false, false, 5, 100, 25},
    {TRUNKS0,     FIGHT_STYLE_KUNGFU,   "TRUNKS",    COLOR_WHITE,     "~y~", false, false, false, 5, 100, 25},
    {GOHAN0,      FIGHT_STYLE_KUNGFU,   "GOHAN",     COLOR_WHITE,     "~g~", false, false, false, 5, 100, 25},
    {SATAN,       FIGHT_STYLE_BOXING,   "HERCULE",   COLOR_PINK,      "~p~", false, false, true,  3, 75,  15},
    {VIDEL,       FIGHT_STYLE_BOXING,   "VIDEL",     COLOR_PINK,      "~p~", false, false, true,  4, 90,  20},
    {CRILIN,      FIGHT_STYLE_KUNGFU,   "KRILLIN",   COLOR_WHITE,     "~r~", false, false, false, 5, 100, 25},
    {YAMCHA,      FIGHT_STYLE_KUNGFU,   "YAMCHA",    COLOR_WHITE,     "~b~", false, false, false, 5, 100, 25},
    {TENSHINSHAN, FIGHT_STYLE_KUNGFU,   "TIEN",      COLOR_WHITE,     "~y~", false, false, false, 5, 100, 25},
    {GELO,        FIGHT_STYLE_GRABKICK, "DR.GERO",   COLOR_LIGHTBLUE, "~g~", true,  true,  false, 0, 0,   20},
    {ANDROID16,   FIGHT_STYLE_KNEEHEAD, "ANDROID16", COLOR_LIGHTBLUE, "~p~", true,  false, false, 0, 0,   30},
    {ANDROID17,   FIGHT_STYLE_KNEEHEAD, "ANDROID17", COLOR_LIGHTBLUE, "~p~", true,  false, false, 0, 0,   30},
    {ANDROID18,   FIGHT_STYLE_KNEEHEAD, "ANDROID18", COLOR_LIGHTBLUE, "~r~", true,  false, false, 0, 0,   25},
    {ANDROID19,   FIGHT_STYLE_GRABKICK, "ANDROID19", COLOR_LIGHTBLUE, "~b~", true,  true,  false, 0, 0,   25}
};

// --- transformation ladders (index 0 = base) ---
enum E_FORM { fSkin, fColor, fLabel[16], fKi }

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

// Map DBZ base skins with 0.3DL art to their custom model slots (M5).
SetPlayerSkinMapped(playerid, skin)
{
    switch (skin)
    {
        case GOKU0:     return SetPlayerSkin(playerid, SKIN_CUSTOM_GOKU);
        case ANDROID16: return SetPlayerSkin(playerid, SKIN_CUSTOM_ANDROID16);
    }
    return SetPlayerSkin(playerid, skin);
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
    new Float:x, Float:y, Float:z, txt[48];
    GetPlayerPos(playerid, x, y, z);
    format(txt, sizeof(txt), "~y~%s", name);
    foreach (new i : Player)
        if (IsPlayerInRangeOfPoint(i, 75.0, x, y, z))
            GameTextForPlayer(i, txt, 2000, 1);
    return 1;
}

// Fire an explosion `distance` metres ahead of the player's facing angle.
CreateExplosionEx(playerid, Float:distance, type, Float:radius)
{
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
    CreateExplosion(x, y, z, type, radius);
    return 1;
}

// Resolve form data for the player's current ladder + index.
GetFormInfo(playerid, idx, &skin, &color, label[], &ki, &count)
{
    new ch = gPlayer[playerid][pCharacter];
    if (gPlayer[playerid][pFused])
    {
        if (ch == 0)
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
        case 0: { count = sizeof(gGokuForms);   if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gGokuForms[idx][fSkin];   color=gGokuForms[idx][fColor];   ki=gGokuForms[idx][fKi];   format(label,24,"%s",gGokuForms[idx][fLabel]); }
        case 1: { count = sizeof(gVegetaForms); if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gVegetaForms[idx][fSkin]; color=gVegetaForms[idx][fColor]; ki=gVegetaForms[idx][fKi]; format(label,24,"%s",gVegetaForms[idx][fLabel]); }
        case 2: { count = sizeof(gTrunksForms); if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gTrunksForms[idx][fSkin]; color=gTrunksForms[idx][fColor]; ki=gTrunksForms[idx][fKi]; format(label,24,"%s",gTrunksForms[idx][fLabel]); }
        case 3: { count = sizeof(gGohanForms);  if(idx<0)idx=0; if(idx>=count)idx=count-1; skin=gGohanForms[idx][fSkin];  color=gGohanForms[idx][fColor];  ki=gGohanForms[idx][fKi];  format(label,24,"%s",gGohanForms[idx][fLabel]); }
        default:{ count = 1; skin = gChar[ch][cSkin]; color = gChar[ch][cColor]; ki = 0; format(label, 24, "%s", gChar[ch][cLabel]); }
    }
    return 1;
}
