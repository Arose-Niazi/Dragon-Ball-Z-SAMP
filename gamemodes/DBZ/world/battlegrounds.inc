/*  DBZ / world / battlegrounds.inc  —  battleground selection + spawn arrays  */
#if defined _dbz_battlegrounds_included
    #endinput
#endif
#define _dbz_battlegrounds_included

// 8 battlegrounds, 2 spawn points each (x,y,z)
new const Float:gBG[8][2][3] =
{
    {{-562.7196,-189.0080,78.4062},   {-529.9219,-189.8709,78.4062}},    // 0 Abandoned Village
    {{397.3382,-2070.2937,13.8998},   {372.9983,-2069.4833,13.9451}},    // 1 Tenkaichi Tournament
    {{-2665.1315,1908.1401,-37.8794}, {-2708.8198,1904.1984,-37.2827}},  // 2 Underwater
    {{1529.3504,-1359.3781,329.4609}, {1557.7271,-1352.8771,329.4609}},  // 3 Skyscraper
    {{-1251.3450,768.4552,34.5781},   {-1205.4771,801.5731,34.5781}},    // 4 Bridge
    {{-68.4304,-17.8501,3.1171},      {-53.8105,16.1618,3.1171}},        // 5 Training Zone
    {{183.161331,1860.846679,20.661357},{228.632171,1898.935668,17.648057}}, // 6 Area 51
    {{2272.188476,1623.508178,94.921875},{2204.618164,1603.807128,68.726562}} // 7 Casino
};
new const gBGNames[9][] =
{
    "Abandoned Village", "Tenkaichi Tournament", "Underwater", "Skyscraper",
    "Bridge", "Training Zone", "Area 51", "Casino", "the Betting Room"
};

forward UnfreezeTimer(playerid);
public UnfreezeTimer(playerid)
{
    if (IsPlayerConnected(playerid) && !gPlayer[playerid][pJailed])
        TogglePlayerControllable(playerid, true);
    return 1;
}

AnnounceSpawn(playerid, const location[])
{
    new msg[144];
    format(msg, sizeof(msg), "{FF0000}INFO: {FFFF00}%s {FFFFFF}spawned in {33AA33}%s.", GetName(playerid), location);
    SendClientMessageToAll(COLOR_WHITE, msg);
    return 1;
}

ShowBattlegroundDialog(playerid)
{
    TogglePlayerControllable(playerid, false);
    GameTextForPlayer(playerid, "~w~Loading...", 1000, 3);
    ShowPlayerDialog(playerid, DIALOG_SPAWN, DIALOG_STYLE_LIST, "Select a battleground",
        "Abandoned Village\nTenkaichi Tournament\nUnderwater\nSkyscraper\nBridge\nTraining Zone\nArea 51\nCasino\nBetting Room (No Fight)",
        "Select", "Random");
    return 1;
}

HandleBattleground(playerid, response, listitem)
{
    new Float:x, Float:y, Float:z, bg, pt, interior = 0;

    if (!response) // Random
    {
        bg = random(8);
        pt = random(2);
        x = gBG[bg][pt][0]; y = gBG[bg][pt][1]; z = gBG[bg][pt][2];
        AnnounceSpawn(playerid, "a random battleground");
    }
    else if (listitem == 8) // Betting Room (No Fight)
    {
        x = 830.6016; y = 5.9404; z = 1004.1797; interior = 3;
        SetKi(playerid, 0.0);
        AnnounceSpawn(playerid, gBGNames[8]);
        GameTextForPlayer(playerid, "~r~DON'T FIGHT HERE", 3000, 3);
        SetPlayerInterior(playerid, interior);
        SetPlayerPos(playerid, x, y, z);
        TogglePlayerControllable(playerid, true);
        return 1;
    }
    else
    {
        bg = listitem;
        if (bg < 0 || bg > 7) bg = 0;
        pt = random(2);
        x = gBG[bg][pt][0]; y = gBG[bg][pt][1]; z = gBG[bg][pt][2];
        AnnounceSpawn(playerid, gBGNames[bg]);
    }

    SetPlayerInterior(playerid, interior);
    SetPlayerPos(playerid, x, y, z);
    TogglePlayerControllable(playerid, true);
    GameTextForPlayer(playerid, "~g~GET READY... ~r~FIGHT!", 3000, 3);
    return 1;
}
