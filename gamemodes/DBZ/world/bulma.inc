/*  DBZ / world / bulma.inc  —  Bulma's workshop: craft the Dragon Radar
 *
 *  Five radar PARTS are hidden across the battlegrounds. Collect all five and
 *  bring them to Bulma (Capsule Corp stand) - /craft assembles your Dragon Radar,
 *  which reveals uncollected Dragon Balls on the map.
 */
#if defined _dbz_bulma_included
    #endinput
#endif
#define _dbz_bulma_included

#define BULMA_X     2002.766113
#define BULMA_Y     1532.768798
#define BULMA_Z     34.918472
#define BULMA_SKIN  SKIN_CUSTOM_BULMA   // DBFZ Bulma custom model

new gBulmaActor = INVALID_ACTOR_ID;
new gRadarPart[5];

// hidden near the battlegrounds so fighters stumble on them
new const Float:gPartPos[5][3] =
{
    {-559.0, -191.0, 78.4},     // Abandoned Village
    {395.0, -2052.0, 8.2},      // Tenkaichi Tournament
    {-1225.0, 785.0, 34.6},     // Bridge
    {2225.0, 1602.0, 68.8},     // Casino
    {-45.0, -5.0, 3.2}          // Training Zone
};

CreateBulmaWorkshop()
{
    gBulmaActor = CreateActor(BULMA_SKIN, BULMA_X, BULMA_Y, BULMA_Z, 180.0);
    SetActorInvulnerable(gBulmaActor, true);
    Create3DTextLabel("{33CCFF}Bulma's Workshop\n{FFFFFF}Bring 5 radar parts and use {33AA33}/craft\n{AFAFAF}to build a Dragon Radar", COLOR_WHITE, BULMA_X, BULMA_Y, BULMA_Z + 1.1, 25.0, 0, false);

    for (new i = 0; i < 5; i++)
        gRadarPart[i] = CreatePickup(1210, 15, gPartPos[i][0], gPartPos[i][1], gPartPos[i][2]);
    return 1;
}

CountRadarParts(playerid)
{
    new n = 0;
    for (new i = 0; i < 5; i++)
        if (gPlayer[playerid][pRadarParts] & (1 << i)) n++;
    return n;
}

// returns 1 if the pickup was a radar part
HandlePartPickup(playerid, pickupid)
{
    for (new i = 0; i < 5; i++)
    {
        if (pickupid != gRadarPart[i]) continue;
        if (gPlayer[playerid][pDragonRadar])
        {
            GameTextForPlayer(playerid, "~b~You already built your radar", 1500, 3);
            return 1;
        }
        if (gPlayer[playerid][pRadarParts] & (1 << i))
        {
            GameTextForPlayer(playerid, "~y~You already have this part", 1500, 3);
            return 1;
        }
        gPlayer[playerid][pRadarParts] |= (1 << i);
        new m[128];
        format(m, sizeof(m), "You found a radar part! (%d/5)%s", CountRadarParts(playerid),
            (CountRadarParts(playerid) == 5) ? " - take them to Bulma and /craft!" : "");
        SendClientMessage(playerid, COLOR_GREEN, m);
        return 1;
    }
    return 0;
}

DoCraft(playerid)
{
    if (!IsPlayerInRangeOfPoint(playerid, 6.0, BULMA_X, BULMA_Y, BULMA_Z))
        return SendClientMessage(playerid, COLOR_GREY, "You need to be at Bulma's Workshop to craft (marked near the old radar spot).");
    if (gPlayer[playerid][pDragonRadar])
        return SendClientMessage(playerid, COLOR_GREY, "Bulma: You already have a working Dragon Radar!");

    new parts = CountRadarParts(playerid);
    if (parts < 5)
    {
        new m[112];
        format(m, sizeof(m), "Bulma: I need 5 parts and you only have %d. They're scattered around the battlegrounds!", parts);
        return SendClientMessage(playerid, COLOR_LIGHTBLUE, m);
    }

    gPlayer[playerid][pRadarParts]  = 0;
    gPlayer[playerid][pDragonRadar] = true;
    SendClientMessage(playerid, COLOR_GREEN, "Bulma: All done! Your Dragon Radar now shows uncollected Dragon Balls on the map.");
    PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
    ShowDragonBallIcons(playerid);
    return 1;
}
