/*  DBZ / cmds / progression_cmds.inc  —  training, moves, skins, stats, crafting  */
#if defined _dbz_cmds_progression_included
    #endinput
#endif
#define _dbz_cmds_progression_included

// current character index, clamped
stock gPlayerid_ch(playerid)
{
    new ch = gPlayer[playerid][pCharacter];
    if (ch < 0 || ch >= MAX_CHARACTERS) ch = 0;
    return ch;
}

CMD:train(playerid)     { return ShowTrainingDialog(playerid); }
CMD:stoptrain(playerid) { return Training_Abort(playerid); }
CMD:craft(playerid)     { return DoCraft(playerid); }
CMD:kaioken(playerid)   { return DoKaioken(playerid); }

// ---------------------------------------------------------------------------
CMD:moves(playerid)
{
    new ch = gPlayer[playerid][pCharacter];
    new lvl = GetCharLevel(playerid);
    new body[512], line[96];
    for (new s = 0; s < 4; s++)
    {
        new mi = ch * 4 + s;
        if (lvl >= gMoveSlotLevel[s])
            format(line, sizeof(line), "%s%s (Ki %d, Dmg %d)%s\n",
                (GetActiveMoveSlot(playerid) == s) ? "{33AA33}> " : "{FFFFFF}",
                gMoves[mi][mvName], gMoves[mi][mvKi], gMoves[mi][mvDmg],
                (GetActiveMoveSlot(playerid) == s) ? " {33AA33}[ACTIVE]" : "");
        else
            format(line, sizeof(line), "{AFAFAF}%s [locked - level %d]\n", gMoves[mi][mvName], gMoveSlotLevel[s]);
        strcat(body, line);
    }
    ShowPlayerDialog(playerid, DIALOG_MOVES, DIALOG_STYLE_LIST, "{FFFF00}Your Moves", body, "Select", "Close");
    return 1;
}

HandleMovePick(playerid, listitem)
{
    if (listitem < 0 || listitem > 3) return 0;
    if (!MoveUnlocked(playerid, listitem))
    {
        new m[96];
        format(m, sizeof(m), "That move unlocks at level %d - keep training!", gMoveSlotLevel[listitem]);
        return SendClientMessage(playerid, COLOR_RED, m);
    }
    new ch = gPlayer[playerid][pCharacter];
    gProg[playerid][ch][prActiveMove] = listitem;
    gProg[playerid][ch][prDirty]      = true;

    new m[112];
    format(m, sizeof(m), "Active move set: %s (fire with the FIRE key or /att).", gMoves[ch * 4 + listitem][mvName]);
    SendClientMessage(playerid, COLOR_GREEN, m);
    return 1;
}

// ---------------------------------------------------------------------------
CMD:skins(playerid)
{
    new ch = gPlayerid_ch(playerid);
    new lvl = GetCharLevel(playerid);
    new body[384], line[80], shown = 0;
    for (new v = 0; v < 5; v++)
    {
        if (gSkinVariants[ch][v] == 0) continue;
        shown++;
        if (lvl >= gSkinSlotLevel[v])
            format(line, sizeof(line), "%sAppearance %d%s\n",
                (gProg[playerid][ch][prActiveSkin] == v) ? "{33AA33}> " : "{FFFFFF}", v + 1,
                (gProg[playerid][ch][prActiveSkin] == v) ? " {33AA33}[ACTIVE]" : "");
        else
            format(line, sizeof(line), "{AFAFAF}Appearance %d [locked - level %d]\n", v + 1, gSkinSlotLevel[v]);
        strcat(body, line);
    }
    if (shown <= 1)
        return SendClientMessage(playerid, COLOR_GREY, "This character has no alternate appearances yet - more models coming!");
    ShowPlayerDialog(playerid, DIALOG_SKINS, DIALOG_STYLE_LIST, "{FFFF00}Your Appearances", body, "Select", "Close");
    return 1;
}

// list rows map 1:1 onto variant slots that exist; resolve row -> variant index
HandleSkinPick(playerid, listitem)
{
    new ch = gPlayerid_ch(playerid);
    new row = -1;
    for (new v = 0; v < 5; v++)
    {
        if (gSkinVariants[ch][v] == 0) continue;
        row++;
        if (row != listitem) continue;

        if (GetCharLevel(playerid) < gSkinSlotLevel[v])
        {
            new m[96];
            format(m, sizeof(m), "That appearance unlocks at level %d - keep training!", gSkinSlotLevel[v]);
            return SendClientMessage(playerid, COLOR_RED, m);
        }
        gProg[playerid][ch][prActiveSkin] = v;
        gProg[playerid][ch][prDirty]      = true;
        if (gPlayer[playerid][pTransform] == 0 && !gPlayer[playerid][pFused])
            SetPlayerSkinMapped(playerid, gChar[ch][cSkin]);
        SendClientMessage(playerid, COLOR_GREEN, "Appearance updated!");
        return 1;
    }
    return 0;
}

// ---------------------------------------------------------------------------
CMD:stats(playerid)
{
    new ch = gPlayerid_ch(playerid);
    new lvl = gProg[playerid][ch][prLevel];
    new m[144];

    format(m, sizeof(m), "==== %s ====", gChar[ch][cLabel]);
    SendClientMessage(playerid, COLOR_YELLOW, m);
    format(m, sizeof(m), "Level %d   |   XP %d / %d   |   Power Level: %d (base %d)",
        lvl, gProg[playerid][ch][prXP], XPNeeded(lvl), GetEffPower(playerid, ch), gChar[ch][cBasePower]);
    SendClientMessage(playerid, COLOR_WHITE, m);
    format(m, sizeof(m), "Kills %d   |   Deaths %d   |   Max HP %.0f   |   Max Ki %.0f",
        gProg[playerid][ch][prKills], gProg[playerid][ch][prDeaths],
        gPlayer[playerid][pHealthMax], gPlayer[playerid][pKiMax]);
    SendClientMessage(playerid, COLOR_WHITE, m);

    new mi = ch * 4 + GetActiveMoveSlot(playerid);
    format(m, sizeof(m), "Active move: %s   |   Forms unlocked: %d   |   Radar parts: %d/5",
        gMoves[mi][mvName], MaxFormUnlocked(playerid), CountRadarParts(playerid));
    SendClientMessage(playerid, COLOR_WHITE, m);
    SendClientMessage(playerid, COLOR_GREY, "Train with /train - switch characters any time, each levels separately!");
    return 1;
}
