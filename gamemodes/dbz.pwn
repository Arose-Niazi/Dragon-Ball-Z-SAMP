/*
 * ============================================================================
 *   DRAGON BALL Z  —  open.mp / SA-MP 0.3DL edition
 * ============================================================================
 *   A ground-up rebuild of the classic "Dragon Ball Z Deathmatch" gamemode
 *   (originally by Sasino97) on the modern open.mp framework.
 *
 *   Maintainer : Arose Niazi
 *   Toolchain  : open.mp + QAWNO (Pawn 3.10) + Pawn.CMD + sscanf2 + foreach
 *   Legacy 0.3z source preserved under legacy/ and tagged v0.3z.
 *
 *   ---------------------------------------------------------------------------
 *   MILESTONE 1 — minimal COMPILING scaffold:
 *     - open.mp branding + class selection
 *     - Pawn.CMD command dispatch (/ping, /keys)
 *     - 0.3DL custom-model registration (Goku, Android 16)
 *   Accounts, real-Ki, keypress combat, custom objects come in M2-M6.
 *   ---------------------------------------------------------------------------
 */

// Toggle the MySQL credential set in DBZ/stuff/db_config.inc
// (comment out to use the remote / production credentials instead).
#define LOCAL_DB

#include <open.mp>
#include <Pawn.RakNet>

#define FOREACH_I_Actor      0
#define FOREACH_I_Character  0
#define FOREACH_I_Bot        0
#define FOREACH_MULTISCRIPT
#include <foreach>

#include <Pawn.CMD>
#include <sscanf2>
#include <a_mysql>
#include <progress2>

// ---------------------------------------------------------------------------
//  DBZ modules  (WINDOWS_COMPILER toggles the include path separator)
// ---------------------------------------------------------------------------
#if defined WINDOWS_COMPILER
    #include "DBZ\stuff\defines"
    #include "DBZ\stuff\colors"
    #include "DBZ\stuff\skins"
    #include "DBZ\stuff\dialog_ids"
    #include "DBZ\stuff\ranks"
    #include "DBZ\stuff\server_vars"
    #include "DBZ\stuff\db_config"
    #include "DBZ\players\data"
    #include "DBZ\players\perms"
    #include "DBZ\players\database"
    #include "DBZ\players\characters"
    #include "DBZ\players\ki"
    #include "DBZ\players\progression"
    #include "DBZ\players\damage"
    #include "DBZ\players\training"
    #include "DBZ\players\combat"
    #include "DBZ\players\spawn"
    #include "DBZ\players\movement"
    #include "DBZ\players\accounts"
    #include "DBZ\world\battlegrounds"
    #include "DBZ\world\dragonballs"
    #include "DBZ\world\bulma"
    #include "DBZ\players\timers"
    #include "DBZ\cmds\admin"
    #include "DBZ\cmds\moderation"
    #include "DBZ\cmds\combat_cmds"
    #include "DBZ\cmds\progression_cmds"
    #include "DBZ\cmds\test_cmds"
    #include "DBZ\players\dialogs"
    #include "DBZ\textdraws\connect"
    #include "DBZ\cmds\cmds"
#else
    #include "DBZ/stuff/defines"
    #include "DBZ/stuff/colors"
    #include "DBZ/stuff/skins"
    #include "DBZ/stuff/dialog_ids"
    #include "DBZ/stuff/ranks"
    #include "DBZ/stuff/server_vars"
    #include "DBZ/stuff/db_config"
    #include "DBZ/players/data"
    #include "DBZ/players/perms"
    #include "DBZ/players/database"
    #include "DBZ/players/characters"
    #include "DBZ/players/ki"
    #include "DBZ/players/progression"
    #include "DBZ/players/damage"
    #include "DBZ/players/training"
    #include "DBZ/players/combat"
    #include "DBZ/players/spawn"
    #include "DBZ/players/movement"
    #include "DBZ/players/accounts"
    #include "DBZ/world/battlegrounds"
    #include "DBZ/world/dragonballs"
    #include "DBZ/world/bulma"
    #include "DBZ/players/timers"
    #include "DBZ/cmds/admin"
    #include "DBZ/cmds/moderation"
    #include "DBZ/cmds/combat_cmds"
    #include "DBZ/cmds/progression_cmds"
    #include "DBZ/cmds/test_cmds"
    #include "DBZ/players/dialogs"
    #include "DBZ/textdraws/connect"
    #include "DBZ/cmds/cmds"
#endif

#include <crashdetect>

// ===========================================================================
main()
{
    print(" ");
    print("  =====================================");
    print("   Dragon Ball Z  -  open.mp / 0.3DL");
    printf("   %s", GAMEMODE_VERSION);
    print("  =====================================");
    print(" ");
}

// ===========================================================================
public OnGameModeInit()
{
    SetGameModeText(GAMEMODE_NAME);
    ConnectDatabase();
    SetTimer("SecondTimer", 1000, true);
    SetTimer("AutoSaveTimer", 240000, true);
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
    ShowNameTags(true);
    EnableStuntBonusForAll(false);
    SetNameTagDrawDistance(20.0);
    SetWeather(1);
    SetWorldTime(12);

    // ---- 0.3DL custom character models (baseid 4 = humanoid skeleton) ----
    AddCharModel(4, SKIN_CUSTOM_GOKU,        "Goku.dff",        "Goku.txd");
    AddCharModel(4, SKIN_CUSTOM_GOKU_V2,     "GokuV2.dff",      "GokuV2.txd");
    AddCharModel(4, SKIN_CUSTOM_GOKU_V3,     "GokuV3.dff",      "GokuV3.txd");
    AddCharModel(4, SKIN_CUSTOM_GOKU_V4,     "GokuV4.dff",      "GokuV4.txd");
    AddCharModel(4, SKIN_CUSTOM_GOKU_V5,     "GokuV5.dff",      "GokuV5.txd");
    AddCharModel(4, SKIN_CUSTOM_ANDROID16,   "16Fighter.dff",   "16Fighter.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA,      "Vegeta.dff",      "Vegeta.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA_V2,   "VegetaV2.dff",    "VegetaV2.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA_V3,   "VegetaV3.dff",    "VegetaV3.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA_V4,   "VegetaV4.dff",    "VegetaV4.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA_V5,   "VegetaV5.dff",    "VegetaV5.txd");
    AddCharModel(4, SKIN_CUSTOM_GOHAN,       "Gohan.dff",       "Gohan.txd");
    AddCharModel(4, SKIN_CUSTOM_GOHAN_V2,    "GohanV2.dff",     "GohanV2.txd");
    AddCharModel(4, SKIN_CUSTOM_GOHAN_V3,    "GohanV3.dff",     "GohanV3.txd");
    AddCharModel(4, SKIN_CUSTOM_TRUNKS,      "Trunks.dff",      "Trunks.txd");
    AddCharModel(4, SKIN_CUSTOM_TRUNKS_V2,   "TrunksV2.dff",    "TrunksV2.txd");
    AddCharModel(4, SKIN_CUSTOM_TRUNKS_V3,   "TrunksV3.dff",    "TrunksV3.txd");
    AddCharModel(4, SKIN_CUSTOM_BULMA,       "Bulma.dff",       "Bulma.txd");
    AddCharModel(4, SKIN_CUSTOM_SATAN,       "Satan.dff",       "Satan.txd");
    AddCharModel(4, SKIN_CUSTOM_VIDEL,       "Videl.dff",       "Videl.txd");
    AddCharModel(4, SKIN_CUSTOM_VIDEL2,      "Videl2.dff",      "Videl2.txd");
    AddCharModel(4, SKIN_CUSTOM_VIDEL3,      "VidelMovie.dff",  "VidelMovie.txd");
    AddCharModel(4, SKIN_CUSTOM_VIDEL4,      "VidelMovie2.dff", "VidelMovie2.txd");
    AddCharModel(4, SKIN_CUSTOM_VIDEL5,      "VidelFight.dff",  "VidelFight.txd");
    AddCharModel(4, SKIN_CUSTOM_YAMCHA,      "Yamcha.dff",      "Yamcha.txd");
    AddCharModel(4, SKIN_CUSTOM_YAMCHA2,     "Yamcha2.dff",     "Yamcha2.txd");
    AddCharModel(4, SKIN_CUSTOM_YAMCHA3,     "Yamcha3.dff",     "Yamcha3.txd");
    AddCharModel(4, SKIN_CUSTOM_PICCOLO,     "Piccolo.dff",     "Piccolo.txd");
    AddCharModel(4, SKIN_CUSTOM_PICCOLO2,    "Piccolo2.dff",    "Piccolo2.txd");
    AddCharModel(4, SKIN_CUSTOM_CELL,        "Cell.dff",        "Cell.txd");

    // ---- Class selection: unlocked characters only (classid -> character map) ----
    // NOTE: AddPlayerClass only accepts stock skin ids (0-311); custom 0.3DL
    // models are applied via SetPlayerSkin in OnPlayerRequestClass / on spawn.
    gClassCount = 0;
    for (new i = 0; i < MAX_CHARACTERS; i++)
    {
        if (gCharLocked[i]) continue;
        AddPlayerClass(gChar[i][cSkin], -249.0, 6.0, 117.0, 0.0);
        gClassToChar[gClassCount++] = i;
    }

    CreateDragonBalls();
    CreateBulmaWorkshop();
    return 1;
}

public OnGameModeExit()
{
    if (gDBConnected)
    {
        mysql_close(g_SQL);
    }
    return 1;
}

// ===========================================================================
public OnIncomingConnection(playerid, ip_address[], port)
{
    printf("[DBZ][conn] Incoming: id %d from %s:%d", playerid, ip_address, port);
    return 1;
}

public OnPlayerConnect(playerid)
{
    printf("[DBZ][conn] OnPlayerConnect fired for id %d", playerid);
    ResetPlayerData(playerid);
    Prog_Reset(playerid);
    Training_Reset(playerid);
    CreateKiHUD(playerid);

    SendClientMessage(playerid, COLOR_YELLOW, "{FFFF00}Welcome to {33AA33}Dragon Ball Z{FFFF00} - the open.mp / 0.3DL rebuild!");
    SendClientMessage(playerid, COLOR_WHITE,  "Type {33AA33}/keys{FFFFFF} to see the action shortcuts.");

    Account_Check(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    printf("[DBZ][conn] OnPlayerDisconnect id %d reason %d", playerid, reason);
    StopCharge(playerid);
    StopFly(playerid);
    DestroyKiHUD(playerid);
    if (gPlayer[playerid][pLabel] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(gPlayer[playerid][pLabel]);
        gPlayer[playerid][pLabel] = Text3D:INVALID_3DTEXT_ID;
    }
    SavePlayerData(playerid);
    ResetPlayerData(playerid);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    new ch = (classid >= 0 && classid < gClassCount) ? gClassToChar[classid] : 0;
    gPlayer[playerid][pCharacter] = ch;
    SetPlayerPos(playerid, -249.0, 6.0, 117.0);
    SetPlayerFacingAngle(playerid, 0.0);
    SetPlayerCameraPos(playerid, -249.0, 9.0, 117.0);
    SetPlayerCameraLookAt(playerid, -249.0, 6.0, 117.0);
    // NOTE: intentionally NO custom-skin preview here — applying DL models during
    // class selection crashes clients with stale caches; customs apply on spawn.

    new gt[48];
    format(gt, sizeof(gt), "%s%s~n~~w~Lv.%d", gChar[ch][cGt], gChar[ch][cLabel], GetCharLevel(playerid, ch));
    GameTextForPlayer(playerid, gt, 3000, 1);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    if (gPlayer[playerid][pJailed])
    {
        ReapplyJail(playerid);
        return 1;
    }
    ApplyCharacterSpawn(playerid);
    ShowDragonBallIcons(playerid);
    ShowBattlegroundDialog(playerid);
    return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
    #pragma unused reason
    StopCharge(playerid);
    StopFly(playerid);
    Training_Abort(playerid);

    new ch = gPlayer[playerid][pCharacter];
    gPlayer[playerid][pDeaths]++;
    if (ch >= 0 && ch < MAX_CHARACTERS)
    {
        gProg[playerid][ch][prDeaths]++;
        gProg[playerid][ch][prDirty] = true;
    }

    // credit explosion/beam kills via last-hit attribution
    new killer = GetKillAttribution(playerid, killerid);
    if (killer != INVALID_PLAYER_ID && killer != playerid)
    {
        gPlayer[killer][pKills]++;
        gPlayer[killer][pScore]++;
        SetPlayerScore(killer, gPlayer[killer][pScore]);

        new kch = gPlayer[killer][pCharacter];
        if (kch >= 0 && kch < MAX_CHARACTERS)
        {
            gProg[killer][kch][prKills]++;
            gProg[killer][kch][prDirty] = true;
        }

        // stronger victims are worth more XP
        new xp = XP_KILL_BASE + GetEffPower(playerid) / 3;
        GiveCharXP(killer, xp);

        new m[144];
        format(m, sizeof(m), "{FF9900}%s {FFFFFF}defeated {FF9900}%s {AFAFAF}(+%d XP)", GetName(killer), GetName(playerid), xp);
        SendClientMessageToAll(COLOR_WHITE, m);
    }

    gPlayer[playerid][pLastHitBy] = INVALID_PLAYER_ID;
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    Training_OnRaceCP(playerid);
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    Training_OnGroundCP(playerid);
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if (HandlePartPickup(playerid, pickupid)) return 1;
    HandleDragonPickup(playerid, pickupid);
    return 1;
}
