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
    #include "DBZ\players\characters"
    #include "DBZ\players\ki"
    #include "DBZ\players\combat"
    #include "DBZ\players\spawn"
    #include "DBZ\players\movement"
    #include "DBZ\players\database"
    #include "DBZ\players\accounts"
    #include "DBZ\players\timers"
    #include "DBZ\world\battlegrounds"
    #include "DBZ\world\dragonballs"
    #include "DBZ\cmds\admin"
    #include "DBZ\cmds\moderation"
    #include "DBZ\cmds\combat_cmds"
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
    #include "DBZ/players/characters"
    #include "DBZ/players/ki"
    #include "DBZ/players/combat"
    #include "DBZ/players/spawn"
    #include "DBZ/players/movement"
    #include "DBZ/players/database"
    #include "DBZ/players/accounts"
    #include "DBZ/players/timers"
    #include "DBZ/world/battlegrounds"
    #include "DBZ/world/dragonballs"
    #include "DBZ/cmds/admin"
    #include "DBZ/cmds/moderation"
    #include "DBZ/cmds/combat_cmds"
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
    AddCharModel(4, SKIN_CUSTOM_GOKU,        "Goku.dff",       "Goku.txd");
    AddCharModel(4, SKIN_CUSTOM_ANDROID16,   "16Fighter.dff",  "16Fighter.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA,      "Vegeta.dff",     "Vegeta.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA_SSJ,  "VegetaSSJ.dff",  "VegetaSSJ.txd");
    AddCharModel(4, SKIN_CUSTOM_VEGETA_SSJ2, "VegetaSSJ2.dff", "VegetaSSJ2.txd");

    // ---- Class selection: 14 DBZ characters (classid == character index) ----
    for (new i = 0; i < MAX_CHARACTERS; i++)
    {
        new skin = gChar[i][cSkin];
        if (i == 0)  skin = SKIN_CUSTOM_GOKU;        // Goku custom model
        if (i == 1)  skin = SKIN_CUSTOM_VEGETA;      // Vegeta custom model
        if (i == 10) skin = SKIN_CUSTOM_ANDROID16;   // Android 16 custom model
        AddPlayerClass(skin, -249.0, 6.0, 117.0, 0.0);
    }

    CreateDragonBalls();
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
public OnPlayerConnect(playerid)
{
    ResetPlayerData(playerid);
    CreateKiHUD(playerid);

    SendClientMessage(playerid, COLOR_YELLOW, "{FFFF00}Welcome to {33AA33}Dragon Ball Z{FFFF00} - the open.mp / 0.3DL rebuild!");
    SendClientMessage(playerid, COLOR_WHITE,  "Type {33AA33}/keys{FFFFFF} to see the action shortcuts.");

    Account_Check(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
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
    gPlayer[playerid][pCharacter] = classid;
    SetPlayerPos(playerid, -249.0, 6.0, 117.0);
    SetPlayerFacingAngle(playerid, 0.0);
    SetPlayerCameraPos(playerid, -249.0, 9.0, 117.0);
    SetPlayerCameraLookAt(playerid, -249.0, 6.0, 117.0);

    new gt[32];
    format(gt, sizeof(gt), "%s%s", gChar[classid][cGt], gChar[classid][cLabel]);
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
    gPlayer[playerid][pDeaths]++;
    if (killerid != INVALID_PLAYER_ID)
    {
        gPlayer[killerid][pKills]++;
        gPlayer[killerid][pScore]++;
        SetPlayerScore(killerid, gPlayer[killerid][pScore]);
    }
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    HandleDragonPickup(playerid, pickupid);
    return 1;
}
