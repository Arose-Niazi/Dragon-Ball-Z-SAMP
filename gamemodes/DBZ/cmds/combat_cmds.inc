/*  DBZ / cmds / combat_cmds.inc  —  gameplay commands (fallbacks for the keybinds)  */
#if defined _dbz_cmds_combat_included
    #endinput
#endif
#define _dbz_cmds_combat_included

CMD:att(playerid)       { return DoAttack(playerid); }
CMD:attack(playerid)    { return DoAttack(playerid); }
CMD:trans(playerid)     { return DoTransform(playerid); }
CMD:transform(playerid) { return DoTransform(playerid); }
CMD:fus(playerid)       { return DoFusion(playerid); }
CMD:fusion(playerid)    { return DoFusion(playerid); }
CMD:fly(playerid)       { return ToggleFly(playerid); }
CMD:rig(playerid)       { return DoRig(playerid); }
CMD:kill(playerid)      { return DoKill(playerid); }
CMD:absorb(playerid)    { return DoAbsorb(playerid); }
CMD:absrob(playerid)    { return DoAbsorb(playerid); }  // legacy typo alias
CMD:wish(playerid)      { return ShowWishDialog(playerid); }

CMD:power(playerid)
{
    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    new aname[32];
    GetAttackName(skin, aname);

    new m[144];
    format(m, sizeof(m), "==== %s ====", lbl);
    SendClientMessage(playerid, COLOR_YELLOW, m);
    format(m, sizeof(m), "Attack: %s  (Ki cost: %d)", aname, GetAttackKi(skin));
    SendClientMessage(playerid, COLOR_WHITE, m);
    format(m, sizeof(m), "Ki: %.0f / %.0f    Charge rate: %d/tick", gPlayer[playerid][pKi], gPlayer[playerid][pKiMax], gChar[gPlayer[playerid][pCharacter]][cCharge]);
    SendClientMessage(playerid, COLOR_WHITE, m);
    format(m, sizeof(m), "Self-destruct Ki: %d", GetSelfDestructKi(playerid));
    SendClientMessage(playerid, COLOR_WHITE, m);
    return 1;
}
