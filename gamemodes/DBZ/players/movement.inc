/*  DBZ / players / movement.inc  —  flight + keypress action shortcuts  */
#if defined _dbz_movement_included
    #endinput
#endif
#define _dbz_movement_included

StartFly(playerid)
{
    if (gPlayer[playerid][pFlying]) return 0;
    gPlayer[playerid][pFlying] = true;

    // Mr. Satan has no Ki - he can't fly, so he straps on a jetpack instead.
    if (gPlayer[playerid][pCharacter] == CHAR_SATAN)
    {
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        GameTextForPlayer(playerid, "~y~Jetpack ~g~ON", 1200, 3);
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(playerid, x, y, z + 3.0);
    ApplyAnimation(playerid, "PARACHUTE", "PARA_steerR", 4.0, true, true, true, true, 0, SYNC_ALL);

    gPlayer[playerid][pFlyTimer] = SetTimerEx("FlyTimer", 100, true, "i", playerid);
    GameTextForPlayer(playerid, "~y~Fly Mode ~g~ON", 1200, 3);
    return 1;
}

StopFly(playerid)
{
    if (!gPlayer[playerid][pFlying]) return 0;
    gPlayer[playerid][pFlying] = false;

    // Mr. Satan: take the jetpack off.
    if (gPlayer[playerid][pCharacter] == CHAR_SATAN)
    {
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        GameTextForPlayer(playerid, "~y~Jetpack ~r~OFF", 1200, 3);
        return 1;
    }

    if (gPlayer[playerid][pFlyTimer] != 0)
    {
        KillTimer(gPlayer[playerid][pFlyTimer]);
        gPlayer[playerid][pFlyTimer] = 0;
    }
    ClearAnimations(playerid);
    GameTextForPlayer(playerid, "~y~Fly Mode ~r~OFF", 1200, 3);
    return 1;
}

ToggleFly(playerid)
{
    if (gPlayer[playerid][pFlying]) StopFly(playerid);
    else StartFly(playerid);
    return 1;
}

forward FlyTimer(playerid);
public FlyTimer(playerid)
{
    if (!IsPlayerConnected(playerid) || !gPlayer[playerid][pFlying])
        return 0;

    new Float:cx, Float:cy, Float:cz;
    GetPlayerCameraFrontVector(playerid, cx, cy, cz);

    new KEY:keys, ud, lr;
    GetPlayerKeys(playerid, keys, ud, lr);

    // flight speed improves with training: +1% per character level (2x at 100)
    new Float:speed = 0.35 * (1.0 + float(GetCharLevel(playerid)) / 100.0) * (1.0 + float(TrFlight(playerid)) * 0.02);
    if (keys & KEY_SPRINT)      speed *= 3.0;    // boost
    else if (keys & KEY_WALK)   speed *= 0.35;   // slow

    new Float:vx = 0.0, Float:vy = 0.0, Float:vz = 0.0;
    if (ud < 0)      { vx = cx * speed;        vy = cy * speed;        vz = cz * speed; }        // forward
    else if (ud > 0) { vx = -cx * speed * 0.5; vy = -cy * speed * 0.5; }                          // back

    if (keys & KEY_FIRE)      vz += 0.30;   // ascend
    if (keys & KEY_HANDBRAKE) vz -= 0.30;   // descend

    SetPlayerVelocity(playerid, vx, vy, vz);
    return 1;
}

// ---------------------------------------------------------------------------
//  Keypress action shortcuts
// ---------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if (!gPlayer[playerid][pLoggedIn])
        return 1;

    DragonBalls_MarkActive(playerid);   // any key input = not AFK

    // Charge Ki: hold Middle Mouse Button (LOOK_BEHIND / SUBMISSION)
    if ((newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)) StartCharge(playerid);
    if (!(newkeys & KEY_SUBMISSION) && (oldkeys & KEY_SUBMISSION)) StopCharge(playerid);

    // Fire energy attack: FIRE (on foot only; in fly mode FIRE = ascend)
    if ((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE) && !gPlayer[playerid][pFlying])
        DoAttack(playerid);

    // Small ki blast: ALT (WALK)
    if ((newkeys & KEY_WALK) && !(oldkeys & KEY_WALK))
        DoKiBlast(playerid);

    // Transform: action key (SECONDARY_ATTACK)
    if ((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
        DoTransform(playerid);

    // Toggle flight: Y
    if ((newkeys & KEY_YES) && !(oldkeys & KEY_YES))
        ToggleFly(playerid);

    // Regenerate: Crouch
    if ((newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH))
        DoRig(playerid);

    // Self-destruct: N
    if ((newkeys & KEY_NO) && !(oldkeys & KEY_NO))
        DoKill(playerid);

    return 1;
}
