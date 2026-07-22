/*  DBZ / world / dragonballs.inc  —  the 7 Dragon Balls as a GLOBAL world resource
 *
 *  There are exactly 7 balls in the world at once. Each is either HELD by an
 *  online, logged-in player, or lying as a world DROP you can pick up.
 *   - Pick up a dropped ball -> you hold it (radar leads rivals to you).
 *   - Die holding balls      -> they drop where you fell (kill a holder to take it).
 *   - Disconnect holding balls -> they scatter to random world spots.
 *   - Can't kill an AFK holder? Get close and /steal a ball off them.
 *   - Gather all 7 and /wish  -> summon Shenron, claim a reward, then all 7
 *     scatter to random spots again (so the hunt restarts).
 *  pBallsMask stays in sync (per-player bitmask of the balls they currently hold)
 *  so HasAllBalls and the website "balls collected" keep working.
 */
#if defined _dbz_dragonballs_included
    #endinput
#endif
#define _dbz_dragonballs_included

#define BALL_COUNT   7
#define BALL_MODEL   1247
#define AFK_MS       90000        // no key input for 90s = AFK (stealable)
#define STEAL_RANGE  5.0

new gBallHolder[BALL_COUNT];                    // playerid holding, or INVALID_PLAYER_ID
new Float:gBallX[BALL_COUNT], Float:gBallY[BALL_COUNT], Float:gBallZ[BALL_COUNT];
new gBallPickup[BALL_COUNT];                    // pickup id when a world drop, else -1
new gLastActive[MAX_PLAYERS];                   // GetTickCount of last key input (AFK)

// Many ground-level scatter spots across San Andreas.
new const Float:gBallSpots[][3] =
{
    {-537.200, -102.969, 63.296},  {-2670.812, 1933.930, 217.273}, {1451.416, -1076.615, 213.382},
    {-1363.999, 493.684, 29.944},  {-61.429, -37.518, 25.980},     {281.206, 1816.537, 8.0},
    {2323.700, 1283.225, 97.661},  {2495.000, -1687.000, 13.5},    {342.500, -1808.000, 4.4},
    {1479.000, -1735.000, 13.5},   {2222.000, -1159.000, 25.9},    {-2029.000, 156.000, 28.8},
    {-2481.000, 2411.000, 15.5},   {2027.000, 1007.000, 10.8},     {1457.000, 2773.000, 10.8},
    {-1436.000, 2608.000, 55.8},   {664.000, -571.000, 16.3},      {1330.000, 327.000, 19.5},
    {646.000, -1751.000, 5.8},     {-230.000, 2793.000, 62.6},     {2340.000, 75.000, 26.5},
    {1685.000, 1447.000, 10.8},    {-1600.000, 715.000, 6.0},      {202.000, -100.000, 1.6},
    {1545.000, -1353.000, 329.0},  {-891.000, 1963.000, 60.0},     {2748.000, -2454.000, 13.6}
};

// ---------------------------------------------------------------------------
DragonBalls_MarkActive(playerid) { gLastActive[playerid] = GetTickCount(); }
stock bool:PlayerIsAFK(playerid) { return (GetTickCount() - gLastActive[playerid]) > AFK_MS; }

static RandomBallSpot(&Float:x, &Float:y, &Float:z)
{
    new s = random(sizeof(gBallSpots));
    x = gBallSpots[s][0]; y = gBallSpots[s][1]; z = gBallSpots[s][2];
}

// Put a ball on the ground as a world drop.
static Ball_MakeDrop(ball, Float:x, Float:y, Float:z)
{
    new prev = gBallHolder[ball];
    gBallHolder[ball] = INVALID_PLAYER_ID;
    gBallX[ball] = x; gBallY[ball] = y; gBallZ[ball] = z;
    if (gBallPickup[ball] != -1) DestroyPickup(gBallPickup[ball]);
    gBallPickup[ball] = CreatePickup(BALL_MODEL, 15, x, y, z);
    if (prev != INVALID_PLAYER_ID && IsPlayerConnected(prev))
        gPlayer[prev][pBallsMask] &= ~(1 << ball);
}

static Ball_DropRandom(ball)
{
    new Float:x, Float:y, Float:z;
    RandomBallSpot(x, y, z);
    Ball_MakeDrop(ball, x, y, z);
}

// Give a dropped ball to a player (pickup / steal).
static Ball_GiveTo(playerid, ball)
{
    gBallHolder[ball] = playerid;
    if (gBallPickup[ball] != -1) { DestroyPickup(gBallPickup[ball]); gBallPickup[ball] = -1; }
    gPlayer[playerid][pBallsMask] |= (1 << ball);
}

stock PlayerBallCount(playerid)
{
    new n = 0;
    for (new i = 0; i < BALL_COUNT; i++) if (gBallHolder[i] == playerid) n++;
    return n;
}

bool:HasAllBalls(playerid)
{
    return (PlayerBallCount(playerid) == BALL_COUNT);
}

// Keep the per-player bitmask (website + fallbacks) in sync with the holder table.
DragonBalls_SyncMask(playerid)
{
    new mask = 0;
    for (new i = 0; i < BALL_COUNT; i++) if (gBallHolder[i] == playerid) mask |= (1 << i);
    gPlayer[playerid][pBallsMask] = mask;
    return mask;
}

// Debug/test: hand all 7 balls to a player.
DragonBalls_GiveAll(playerid)
{
    for (new i = 0; i < BALL_COUNT; i++) if (gBallHolder[i] != playerid) Ball_GiveTo(playerid, i);
    return 1;
}

// ---------------------------------------------------------------------------
CreateDragonBalls()
{
    for (new i = 0; i < BALL_COUNT; i++) { gBallHolder[i] = INVALID_PLAYER_ID; gBallPickup[i] = -1; }
    for (new i = 0; i < BALL_COUNT; i++) Ball_DropRandom(i);
    SetTimer("DragonBallRadarTick", 3000, true);
    return 1;
}

// Live radar: icon i points at ball i (its drop spot, or its holder's position).
forward DragonBallRadarTick();
public DragonBallRadarTick()
{
    foreach (new playerid : Player)
    {
        if (!gPlayer[playerid][pLoggedIn] || !gPlayer[playerid][pDragonRadar]) continue;
        for (new i = 0; i < BALL_COUNT; i++)
        {
            new holder = gBallHolder[i];
            if (holder == playerid) { RemovePlayerMapIcon(playerid, i); continue; }   // you have it
            new Float:x, Float:y, Float:z;
            if (holder != INVALID_PLAYER_ID && IsPlayerConnected(holder))
                GetPlayerPos(holder, x, y, z);
            else { x = gBallX[i]; y = gBallY[i]; z = gBallZ[i]; }
            SetPlayerMapIcon(playerid, i, x, y, z, 56, 0, MAPICON_GLOBAL);
        }
    }
    return 1;
}

ShowDragonBallIcons(playerid)
{
    if (!gPlayer[playerid][pDragonRadar]) return 0;
    for (new i = 0; i < BALL_COUNT; i++)
    {
        if (gBallHolder[i] == playerid) { RemovePlayerMapIcon(playerid, i); continue; }
        new Float:x, Float:y, Float:z, holder = gBallHolder[i];
        if (holder != INVALID_PLAYER_ID && IsPlayerConnected(holder)) GetPlayerPos(holder, x, y, z);
        else { x = gBallX[i]; y = gBallY[i]; z = gBallZ[i]; }
        SetPlayerMapIcon(playerid, i, x, y, z, 56, 0, MAPICON_GLOBAL);
    }
    return 1;
}

// A player walked over a pickup - claim it if it's a ball.
HandleDragonPickup(playerid, pickupid)
{
    for (new i = 0; i < BALL_COUNT; i++)
    {
        if (gBallPickup[i] == pickupid && gBallHolder[i] == INVALID_PLAYER_ID)
        {
            Ball_GiveTo(playerid, i);
            new m[128];
            format(m, sizeof(m), "~y~%d-Star Dragon Ball!~n~~w~You hold %d/7", i + 1, PlayerBallCount(playerid));
            GameTextForPlayer(playerid, m, 3000, 3);
            SendClientMessage(playerid, COLOR_YELLOW, "You picked up a Dragon Ball - guard it! If you die or log off, you drop it.");
            if (HasAllBalls(playerid))
                SendClientMessage(playerid, COLOR_BLUE, "You have all 7! Use /wish to summon Shenron.");
            return 1;
        }
    }
    return 0;
}

// Death: drop every held ball where you fell (spread a little so they don't stack).
DragonBalls_OnDeath(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new dropped = 0;
    for (new i = 0; i < BALL_COUNT; i++)
        if (gBallHolder[i] == playerid)
        {
            Ball_MakeDrop(i, x + float(random(5)) - 2.0, y + float(random(5)) - 2.0, z);
            dropped++;
        }
    if (dropped > 0)
        GameTextForPlayer(playerid, "~r~You dropped your Dragon Balls!", 3000, 3);
    return dropped;
}

// Disconnect: held balls scatter to random world spots so they stay findable.
DragonBalls_OnDisconnect(playerid)
{
    for (new i = 0; i < BALL_COUNT; i++)
        if (gBallHolder[i] == playerid)
            Ball_DropRandom(i);
    return 1;
}

// Steal a ball off a nearby AFK holder (you can't kill them, so mug them).
DragonBalls_Steal(playerid)
{
    if (PlayerIsAFK(playerid))
        return SendClientMessage(playerid, COLOR_GREY, "Wake up first - you look AFK yourself.");

    for (new i = 0; i < BALL_COUNT; i++)
    {
        new holder = gBallHolder[i];
        if (holder == INVALID_PLAYER_ID || holder == playerid) continue;
        if (!IsPlayerConnected(holder) || !PlayerIsAFK(holder)) continue;
        if (DB_PlayerDist(playerid, holder) > STEAL_RANGE) continue;

        Ball_GiveTo(playerid, i);
        new m[128];
        format(m, sizeof(m), "You mugged %s and stole the %d-Star Dragon Ball!", GetName(holder), i + 1);
        SendClientMessage(playerid, COLOR_YELLOW, m);
        format(m, sizeof(m), "%s stole a Dragon Ball off you while you were AFK!", GetName(playerid));
        SendClientMessage(holder, COLOR_RED, m);
        return 1;
    }
    return SendClientMessage(playerid, COLOR_GREY, "No AFK Dragon Ball holder within reach to steal from.");
}

// Small distance helper between two players.
stock Float:DB_PlayerDist(a, b)
{
    if (!IsPlayerConnected(a) || !IsPlayerConnected(b)) return 99999.0;
    new Float:ax, Float:ay, Float:az, Float:bx, Float:by, Float:bz;
    GetPlayerPos(a, ax, ay, az); GetPlayerPos(b, bx, by, bz);
    return VectorSize(ax - bx, ay - by, az - bz);
}

// ---------------------------------------------------------------------------
ShowWishDialog(playerid)
{
    if (GetPlayerInterior(playerid) == 6)
        return SendClientMessage(playerid, COLOR_RED, "Shenron cannot hear you from jail.");
    if (!HasAllBalls(playerid))
    {
        new m[96];
        format(m, sizeof(m), "You hold %d/7 Dragon Balls - find them all to summon Shenron.", PlayerBallCount(playerid));
        return SendClientMessage(playerid, COLOR_RED, m);
    }

    new m[128];
    format(m, sizeof(m), "{FF0000}%s {FFFF00}gathered all 7 Dragon Balls and summoned Shenron!", GetName(playerid));
    SendClientMessageToAll(COLOR_YELLOW, m);

    ShowPlayerDialog(playerid, DIALOG_WISH, DIALOG_STYLE_LIST, "Shenron: State your wish, and I shall grant it!",
        "Surge of Power\t{AFAFAF}massive XP for this character\n\
Zenkai Boost\t{AFAFAF}full heal + overflowing Ki\n\
Warrior's Fortune\t{AFAFAF}$250,000 zeni\n\
Legendary Might\t{AFAFAF}a temporary power aura", "Wish", "Cancel");
    return 1;
}

HandleWish(playerid, response, listitem)
{
    // Whatever they choose (even Cancel), the 7 balls scatter again once Shenron is summoned.
    new ch = gPlayer[playerid][pCharacter];
    if (response)
    {
        switch (listitem)
        {
            case 0: { GiveCharXP(playerid, 2000); SendClientMessage(playerid, COLOR_GREEN, "Shenron floods you with power - a huge surge of XP!"); }
            case 1: { SetPlayerHealth(playerid, gPlayer[playerid][pHealthMax]); if (!IsAndroid(playerid)) SetKi(playerid, gPlayer[playerid][pKiMax]); SendClientMessage(playerid, COLOR_GREEN, "Zenkai! You are fully restored and brimming with Ki."); }
            case 2: { GivePlayerMoney(playerid, 250000); SendClientMessage(playerid, COLOR_GREEN, "Shenron rains down $250,000 zeni!"); }
            case 3: { gPlayer[playerid][pKaiokenUntil] = gettime() + 30; SetPlayerColor(playerid, COLOR_RED); SendClientMessage(playerid, COLOR_GREEN, "Legendary might courses through you for 30 seconds!"); }
        }
    }
    // Shenron departs and scatters the balls to the winds.
    if (ch >= 0) {}   // (ch kept for potential future per-character wishes)
    for (new i = 0; i < BALL_COUNT; i++) Ball_DropRandom(i);
    SendClientMessageToAll(COLOR_BLUE, "The Dragon Balls scatter across San Andreas once more. The hunt begins again!");
    return 1;
}
