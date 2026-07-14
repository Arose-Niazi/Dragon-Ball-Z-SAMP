/*  DBZ / cmds / test_cmds.inc  —  OWNER-ONLY testing / bypass commands
 *  For development: fast-forward progression, refill resources, teleport,
 *  hand out collectibles, and flip feature locks live. All gated on pIsOwner.
 */
#if defined _dbz_cmds_test_included
    #endinput
#endif
#define _dbz_cmds_test_included

static bool:TestGate(playerid)
{
    if (gPlayer[playerid][pIsOwner]) return true;
    SendClientMessage(playerid, COLOR_RED, "Owner-only command.");
    return false;
}

// /setcharlevel [1-100] — set CURRENT character's level (stats update live)
CMD:setcharlevel(playerid, params[])
{
    if (!TestGate(playerid)) return 1;
    new lvl;
    if (sscanf(params, "d", lvl) || lvl < 1 || lvl > MAX_CHAR_LEVEL)
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /setcharlevel [1-100]");

    new ch = gPlayer[playerid][pCharacter];
    gProg[playerid][ch][prLevel] = lvl;
    gProg[playerid][ch][prXP]    = 0;
    gProg[playerid][ch][prDirty] = true;

    gPlayer[playerid][pHealthMax] = float(gChar[ch][cBaseHp] + lvl);
    if (!gChar[ch][cAndroid]) gPlayer[playerid][pKiMax] = float(gChar[ch][cKiCap] + lvl);
    UpdateKiBar(playerid);

    new m[128];
    format(m, sizeof(m), "[TEST] %s set to level %d (power %d). Unlocks: moves/skins/tiers now follow this level.",
        gChar[ch][cLabel], lvl, GetEffPower(playerid));
    SendClientMessage(playerid, COLOR_ADMIN, m);
    return 1;
}

// /givexp [amount] — grant XP to current character (watch level-ups fire)
CMD:givexp(playerid, params[])
{
    if (!TestGate(playerid)) return 1;
    new xp;
    if (sscanf(params, "d", xp) || xp < 1 || xp > 1000000)
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /givexp [amount]");
    GiveCharXP(playerid, xp);
    new m[64]; format(m, sizeof(m), "[TEST] +%d XP granted.", xp);
    SendClientMessage(playerid, COLOR_ADMIN, m);
    return 1;
}

// /refill — full HP, armour and Ki
CMD:refill(playerid)
{
    if (!TestGate(playerid)) return 1;
    SetPlayerHealth(playerid, gPlayer[playerid][pHealthMax]);
    SetPlayerArmour(playerid, 100.0);
    SetKi(playerid, gPlayer[playerid][pKiMax]);
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] HP / armour / Ki refilled.");
    return 1;
}

// /giveballs — all 7 Dragon Balls (test /wish instantly)
CMD:giveballs(playerid)
{
    if (!TestGate(playerid)) return 1;
    gPlayer[playerid][pBallsMask] = 0x7F;
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] All 7 Dragon Balls granted - try /wish.");
    return 1;
}

// /giveparts — all 5 radar parts (test Bulma /craft)
CMD:giveparts(playerid)
{
    if (!TestGate(playerid)) return 1;
    gPlayer[playerid][pRadarParts] = 0x1F;
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] All 5 radar parts granted - /craft at Bulma.");
    return 1;
}

// /resetchar — wipe current character back to level 1
CMD:resetchar(playerid)
{
    if (!TestGate(playerid)) return 1;
    new ch = gPlayer[playerid][pCharacter];
    gProg[playerid][ch][prLevel]      = 1;
    gProg[playerid][ch][prXP]         = 0;
    gProg[playerid][ch][prActiveMove] = 0;
    gProg[playerid][ch][prActiveSkin] = 0;
    gProg[playerid][ch][prDirty]      = true;
    gPlayer[playerid][pHealthMax] = float(gChar[ch][cBaseHp] + 1);
    if (!gChar[ch][cAndroid]) gPlayer[playerid][pKiMax] = float(gChar[ch][cKiCap] + 1);
    UpdateKiBar(playerid);
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] Character reset to level 1.");
    return 1;
}

// /traincd — clear the training cooldown
CMD:traincd(playerid)
{
    if (!TestGate(playerid)) return 1;
    gPlayer[playerid][pTrainCd] = 0;
    gPlayer[playerid][pAbsorbCd] = 0;
    gPlayer[playerid][pLastAttack] = 0;
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] Training / absorb / attack cooldowns cleared.");
    return 1;
}

// /transtoggle — flip the transformations/fusion lock live
CMD:transtoggle(playerid)
{
    if (!TestGate(playerid)) return 1;
    gTransformsLocked = !gTransformsLocked;
    new m[96];
    format(m, sizeof(m), "[TEST] Transformations/fusion are now %s.", gTransformsLocked ? ("LOCKED") : ("UNLOCKED (stock-skin forms)"));
    SendClientMessage(playerid, COLOR_ADMIN, m);
    return 1;
}

// /tpt — training zone | /tpbulma — workshop | /tpbg [0-7] — battleground
CMD:tpt(playerid)
{
    if (!TestGate(playerid)) return 1;
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, -60.0, -5.0, 3.5);
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] Teleported to the Training Zone.");
    return 1;
}

CMD:tpbulma(playerid)
{
    if (!TestGate(playerid)) return 1;
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, BULMA_X + 2.0, BULMA_Y, BULMA_Z);
    SendClientMessage(playerid, COLOR_ADMIN, "[TEST] Teleported to Bulma's Workshop.");
    return 1;
}

CMD:tpbg(playerid, params[])
{
    if (!TestGate(playerid)) return 1;
    new bg;
    if (sscanf(params, "d", bg) || bg < 0 || bg > 7)
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /tpbg [0-7]  (0 Village 1 Tenkaichi 2 Underwater 3 Skyscraper 4 Bridge 5 Training 6 Area51 7 Casino)");
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, gBG[bg][0][0], gBG[bg][0][1], gBG[bg][0][2]);
    new m[80]; format(m, sizeof(m), "[TEST] Teleported to %s.", gBGNames[bg]);
    SendClientMessage(playerid, COLOR_ADMIN, m);
    return 1;
}

// /testhelp — list all test commands
CMD:testhelp(playerid)
{
    if (!TestGate(playerid)) return 1;
    SendClientMessage(playerid, COLOR_YELLOW, "==== Owner Test Commands ====");
    SendClientMessage(playerid, COLOR_WHITE, "/setcharlevel [1-100] - set current char level (unlocks follow)");
    SendClientMessage(playerid, COLOR_WHITE, "/givexp [n]  /resetchar  /refill (HP+Ki)  /traincd (clear cooldowns)");
    SendClientMessage(playerid, COLOR_WHITE, "/giveballs (test /wish)  /giveparts (test /craft)  /transtoggle");
    SendClientMessage(playerid, COLOR_WHITE, "/tpt (training)  /tpbulma (workshop)  /tpbg [0-7] (battlegrounds)");
    return 1;
}
