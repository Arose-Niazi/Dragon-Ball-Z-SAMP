/*  DBZ / world / dragonballs.inc  —  7 Dragon Balls + Radar + /wish  */
#if defined _dbz_dragonballs_included
    #endinput
#endif
#define _dbz_dragonballs_included

new gDragonBall[7];
new gRadarPickup;

new const Float:gBallPos[7][3] =
{
    {-537.200683, -102.969543, 63.296875},
    {-2670.812255, 1933.930419, 217.273895},
    {1451.416748, -1076.615478, 213.382812},
    {-1363.999755, 493.684875, 29.944622},
    {-61.429683, -37.518638, 25.980148},
    {281.206451, 1816.537475, 1.007812},
    {2323.700439, 1283.225341, 97.661628}
};

CreateDragonBalls()
{
    for (new i = 0; i < 7; i++)
        gDragonBall[i] = CreatePickup(1247, 15, gBallPos[i][0], gBallPos[i][1], gBallPos[i][2]);
    gRadarPickup = CreatePickup(1252, 15, 2002.766113, 1532.768798, 34.918472);
    return 1;
}

ShowDragonBallIcons(playerid)
{
    if (!gPlayer[playerid][pDragonRadar])
        return 0;
    for (new i = 0; i < 7; i++)
        if (!(gPlayer[playerid][pBallsMask] & (1 << i)))
            SetPlayerMapIcon(playerid, i, gBallPos[i][0], gBallPos[i][1], gBallPos[i][2], 56, 0, MAPICON_GLOBAL);
    return 1;
}

bool:HasAllBalls(playerid)
{
    return ((gPlayer[playerid][pBallsMask] & 0x7F) == 0x7F);
}

HandleDragonPickup(playerid, pickupid)
{
    for (new i = 0; i < 7; i++)
    {
        if (pickupid == gDragonBall[i])
        {
            if (gPlayer[playerid][pBallsMask] & (1 << i))
            {
                GameTextForPlayer(playerid, "~y~You already found this Dragon Ball", 2000, 3);
                return 1;
            }
            gPlayer[playerid][pBallsMask] |= (1 << i);
            new m[128];
            format(m, sizeof(m), "You found the %d-Star Dragon Ball! Don't tell anyone!", i + 1);
            SendClientMessage(playerid, COLOR_YELLOW, m);
            SendClientMessage(playerid, COLOR_BLUE, "Collect all 7, then use /wish to summon Shenron!");
            RemovePlayerMapIcon(playerid, i);
            return 1;
        }
    }
    if (pickupid == gRadarPickup)
    {
        gPlayer[playerid][pDragonRadar] = true;
        SendClientMessage(playerid, COLOR_GREEN, "You picked up Bulma's Dragon Radar! Uncollected balls now show on your map.");
        ShowDragonBallIcons(playerid);
        return 1;
    }
    return 0;
}

ShowWishDialog(playerid)
{
    if (GetPlayerInterior(playerid) == 6)
        return SendClientMessage(playerid, COLOR_RED, "Shenron cannot hear you from jail.");
    if (!HasAllBalls(playerid))
        return SendClientMessage(playerid, COLOR_RED, "You haven't found all 7 Dragon Balls yet!");

    SendClientMessage(playerid, COLOR_RED, "YOU FOUND ALL 7 DRAGON BALLS!!!");
    new m[128];
    format(m, sizeof(m), "{FF0000}%s {FFFF00}has summoned Shenron!", GetName(playerid));
    SendClientMessageToAll(COLOR_YELLOW, m);

    ShowPlayerDialog(playerid, DIALOG_WISH, DIALOG_STYLE_LIST, "Shenron: I'll grant only one wish!",
        "Sword for Trunks\nKnife for Videl\nRocket Launcher for Android 16", "Wish", "Cancel");

    // Reset balls + radar immediately (legacy behaviour)
    gPlayer[playerid][pBallsMask]   = 0;
    gPlayer[playerid][pDragonRadar] = false;
    for (new i = 0; i < 7; i++)
        RemovePlayerMapIcon(playerid, i);
    return 1;
}

HandleWish(playerid, response, listitem)
{
    if (!response)
        return 1;
    switch (listitem)
    {
        case 0: { gPlayer[playerid][pSword]   = true; SendClientMessage(playerid, COLOR_GREEN, "You wished for the Sword! Spawn as Trunks to wield it."); }
        case 1: { gPlayer[playerid][pKnife]   = true; SendClientMessage(playerid, COLOR_GREEN, "You wished for the Knife! Spawn as Videl to wield it."); }
        case 2: { gPlayer[playerid][pBazooka] = true; SendClientMessage(playerid, COLOR_GREEN, "You wished for the Rocket Launcher! Spawn as Android 16 to wield it."); }
    }
    return 1;
}
