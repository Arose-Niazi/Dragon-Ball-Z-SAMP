/*  DBZ / players / damage.inc  —  scripted attack damage + power scaling
 *
 *  Attacks now deal REAL damage: every blast point checks for nearby victims and
 *  applies damage scaled by attacker vs defender effective power. Each victim is
 *  hit at most ONCE per attack (serial guard), armour absorbs first, and the
 *  killer is remembered for kill attribution/XP.
 */
#if defined _dbz_damage_included
    #endinput
#endif
#define _dbz_damage_included

#define DMG_HIT_RADIUS      7.0     // blast-point hit detection radius
#define KILL_ATTRIB_MS      8000    // how long a last-hit counts for a kill

new gAttackSerial[MAX_PLAYERS];
new gDmgSerial[MAX_PLAYERS][MAX_PLAYERS];   // [victim][attacker] = serial already hit

BeginAttack(playerid)
{
    gAttackSerial[playerid]++;
    return 1;
}

// Damage after both fighters' power, form, and passives are applied.
Float:CalcDamage(attacker, victim, Float:base)
{
    new Float:dmg = base;

    // attacker scaling: effective power (form bonus already included in it)
    new attEff = GetEffPower(attacker);
    dmg *= (1.0 + float(attEff) / 150.0);

    // Goku: Kaioken burst
    if (gPlayer[attacker][pKaiokenUntil] > gettime()) dmg *= 1.5;

    // Vegeta: Saiyan Pride — hits harder when badly hurt
    if (gPlayer[attacker][pCharacter] == CHAR_VEGETA)
    {
        new Float:hp; GetPlayerHealth(attacker, hp);
        if (hp < gPlayer[attacker][pHealthMax] * 0.3) dmg *= 1.3;
    }

    // Krillin: precision — 10% critical strike
    if (gPlayer[attacker][pCharacter] == CHAR_KRILLIN && random(10) == 0)
    {
        dmg *= 2.0;
        GameTextForPlayer(attacker, "~r~CRITICAL!", 1200, 3);
    }

    // defender mitigation: power + passives
    dmg /= (1.0 + float(GetEffPower(victim)) / 300.0);
    if (gPlayer[victim][pCharacter] == CHAR_TIEN) dmg *= 0.85;   // Discipline

    return dmg;
}

// Apply damage at a blast point. Returns number of victims hit.
DealDamageAt(attacker, Float:x, Float:y, Float:z, Float:baseDmg)
{
    new hits = 0;
    foreach (new victim : Player)
    {
        if (victim == attacker) continue;
        if (!gPlayer[victim][pLoggedIn]) continue;
        if (gDmgSerial[victim][attacker] == gAttackSerial[attacker]) continue;   // already hit this attack
        if (!IsPlayerInRangeOfPoint(victim, DMG_HIT_RADIUS, x, y, z)) continue;
        if (GetPlayerVirtualWorld(victim) != GetPlayerVirtualWorld(attacker)) continue;

        gDmgSerial[victim][attacker] = gAttackSerial[attacker];

        // Mr. Satan: Champion's Luck — 15% miracle dodge
        if (gPlayer[victim][pCharacter] == CHAR_SATAN && random(100) < 15)
        {
            GameTextForPlayer(victim,   "~g~MIRACLE DODGE!", 1200, 3);
            GameTextForPlayer(attacker, "~r~DODGED!", 1200, 3);
            continue;
        }

        new Float:dmg = CalcDamage(attacker, victim, baseDmg);

        // armour absorbs first, remainder hits health
        new Float:armor, Float:hp;
        GetPlayerArmour(victim, armor);
        GetPlayerHealth(victim, hp);
        if (armor > 0.0)
        {
            if (armor >= dmg) { SetPlayerArmour(victim, armor - dmg); dmg = 0.0; }
            else              { SetPlayerArmour(victim, 0.0); dmg -= armor; }
        }
        if (dmg > 0.0)
            SetPlayerHealth(victim, hp - dmg);

        gPlayer[victim][pLastHitBy]       = attacker;
        gPlayer[victim][pLastHitTick]     = GetTickCount();
        gPlayer[victim][pLastDamagedTick] = GetTickCount();

        // Yamcha: Wolf Spirit — recover Ki on every landed hit
        if (gPlayer[attacker][pCharacter] == CHAR_YAMCHA) GiveKi(attacker, 3.0);

        GiveCharXP(attacker, XP_PER_HIT);
        hits++;
    }
    return hits;
}

// Kill credit: engine killerid if valid, else recent last-hit (explosion kills).
GetKillAttribution(playerid, killerid)
{
    if (killerid != INVALID_PLAYER_ID) return killerid;
    new last = gPlayer[playerid][pLastHitBy];
    if (last != INVALID_PLAYER_ID && IsPlayerConnected(last)
        && GetTickCount() - gPlayer[playerid][pLastHitTick] < KILL_ATTRIB_MS)
        return last;
    return INVALID_PLAYER_ID;
}
