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

#include <open.mp>
#include <Pawn.RakNet>

#define FOREACH_I_Actor      0
#define FOREACH_I_Character  0
#define FOREACH_I_Bot        0
#define FOREACH_MULTISCRIPT
#include <foreach>

#include <Pawn.CMD>
#include <sscanf2>

// ---------------------------------------------------------------------------
//  DBZ modules  (WINDOWS_COMPILER toggles the include path separator)
// ---------------------------------------------------------------------------
#if defined WINDOWS_COMPILER
    #include "DBZ\stuff\defines"
    #include "DBZ\stuff\colors"
    #include "DBZ\stuff\dialog_ids"
    #include "DBZ\stuff\server_vars"
    #include "DBZ\players\data"
    #include "DBZ\textdraws\connect"
    #include "DBZ\cmds\cmds"
#else
    #include "DBZ/stuff/defines"
    #include "DBZ/stuff/colors"
    #include "DBZ/stuff/dialog_ids"
    #include "DBZ/stuff/server_vars"
    #include "DBZ/players/data"
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
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
    ShowNameTags(true);
    EnableStuntBonusForAll(false);

    // ---- 0.3DL custom character models (baseid 4 = humanoid skeleton) ----
    // Only Goku & Android 16 have art today; every other character falls back
    // to a stock skin via the class roster until more .dff/.txd are added.
    AddCharModel(4, SKIN_CUSTOM_GOKU,      "Goku.dff",      "Goku.txd");
    AddCharModel(4, SKIN_CUSTOM_ANDROID16, "16Fighter.dff", "16Fighter.txd");

    // ---- Class selection roster ----
    for (new i = 0; i < sizeof(gClassSkins); i++)
    {
        AddPlayerClass(gClassSkins[i], SPAWN_X, SPAWN_Y, SPAWN_Z, SPAWN_A);
    }
    return 1;
}

public OnGameModeExit()
{
    return 1;
}

// ===========================================================================
public OnPlayerConnect(playerid)
{
    // Reset runtime data (persistent account loading arrives in Milestone 2).
    ResetPlayerData(playerid);

    SendClientMessage(playerid, COLOR_YELLOW, "{FFFF00}Welcome to {33AA33}Dragon Ball Z{FFFF00} - the open.mp / 0.3DL rebuild!");
    SendClientMessage(playerid, COLOR_WHITE,  "Type {33AA33}/keys{FFFFFF} for the action shortcuts, or {33AA33}/ping{FFFFFF} to test the server.");
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
    SetPlayerCameraPos(playerid, SPAWN_X + 3.0, SPAWN_Y, SPAWN_Z + 1.0);
    SetPlayerCameraLookAt(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerHealth(playerid, 100.0);
    return 1;
}
