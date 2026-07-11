/*  DBZ / players / ki.inc  —  real Ki stat + progress2 HUD bar + charge
 *  (Replaces the legacy Ki-as-money hack.)
 */
#if defined _dbz_ki_included
    #endinput
#endif
#define _dbz_ki_included

// ------------------------------- HUD ---------------------------------------
CreateKiHUD(playerid)
{
    gPlayer[playerid][pKiBar] = CreatePlayerProgressBar(playerid, 549.0, 25.0, 55.5, 3.2, 0x0000FFFF, 100.0);
    ShowPlayerProgressBar(playerid, gPlayer[playerid][pKiBar]);
    UpdateKiBar(playerid);
    return 1;
}

DestroyKiHUD(playerid)
{
    if (IsValidPlayerProgressBar(playerid, gPlayer[playerid][pKiBar]))
        DestroyPlayerProgressBar(playerid, gPlayer[playerid][pKiBar]);
    gPlayer[playerid][pKiBar] = INVALID_PLAYER_BAR_ID;
    return 1;
}

UpdateKiBar(playerid)
{
    if (!IsValidPlayerProgressBar(playerid, gPlayer[playerid][pKiBar]))
        return 0;
    if (gPlayer[playerid][pKiMax] <= 0.0)
    {
        SetPlayerProgressBarValue(playerid, gPlayer[playerid][pKiBar], 0.0);
        return 0;
    }
    new Float:pct = (gPlayer[playerid][pKi] / gPlayer[playerid][pKiMax]) * 100.0;
    if (pct < 0.0)   pct = 0.0;
    if (pct > 100.0) pct = 100.0;
    SetPlayerProgressBarValue(playerid, gPlayer[playerid][pKiBar], pct);
    return 1;
}

// ------------------------------ Ki stat ------------------------------------
stock Float:GetKi(playerid)
{
    return gPlayer[playerid][pKi];
}

SetKi(playerid, Float:value)
{
    if (value < 0.0) value = 0.0;
    if (value > gPlayer[playerid][pKiMax]) value = gPlayer[playerid][pKiMax];
    gPlayer[playerid][pKi] = value;
    UpdateKiBar(playerid);
    return 1;
}

GiveKi(playerid, Float:amount)
{
    SetKi(playerid, gPlayer[playerid][pKi] + amount);
    return 1;
}

// Androids pay no Ki (always "have" it and never spend).
stock bool:HasKi(playerid, Float:cost)
{
    if (IsAndroid(playerid)) return true;
    return (gPlayer[playerid][pKi] >= cost);
}

SpendKi(playerid, Float:cost)
{
    if (IsAndroid(playerid)) return 1;
    GiveKi(playerid, -cost);
    return 1;
}

// ------------------------------ Charge -------------------------------------
forward ChargeKiTimer(playerid);
public ChargeKiTimer(playerid)
{
    if (!IsPlayerConnected(playerid) || !gPlayer[playerid][pCharging])
        return 0;

    new ch = gPlayer[playerid][pCharacter];
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z + 5.0, 11, 1.0);
    GiveKi(playerid, float(gChar[ch][cCharge]));

    if (gPlayer[playerid][pKi] >= gPlayer[playerid][pKiMax])
        GameTextForPlayer(playerid, "~b~Ki Full", 700, 3);
    return 1;
}

StartCharge(playerid)
{
    if (gPlayer[playerid][pCharging]) return 0;
    if (IsAndroid(playerid))
    {
        GameTextForPlayer(playerid, "~r~Androids have no Ki!", 1500, 3);
        return 0;
    }
    gPlayer[playerid][pCharging] = true;

    // aura: 3 attached objects (model 19197) around the body
    SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.0, 0.0, 0.0, 170.0, 90.0, 90.0, 2.0, 2.0, 2.0);
    SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.0, 0.0, 0.0,   0.0,  0.0,  0.0, 2.0, 2.0, 2.0);
    SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.0, 0.0, 0.0, 170.0,  0.0,  0.0, 2.0, 2.0, 2.0);

    gPlayer[playerid][pChargeTimer] = SetTimerEx("ChargeKiTimer", 250, true, "i", playerid);
    return 1;
}

StopCharge(playerid)
{
    if (!gPlayer[playerid][pCharging]) return 0;
    gPlayer[playerid][pCharging] = false;
    if (gPlayer[playerid][pChargeTimer] != 0)
    {
        KillTimer(gPlayer[playerid][pChargeTimer]);
        gPlayer[playerid][pChargeTimer] = 0;
    }
    for (new i = 0; i < 3; i++)
        if (IsPlayerAttachedObjectSlotUsed(playerid, i))
            RemovePlayerAttachedObject(playerid, i);
    return 1;
}
