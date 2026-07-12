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
    new ch = gPlayer[playerid][pCharacter];
    if (ch < 0 || ch >= MAX_CHARACTERS) ch = 0;
    new skin, color, lbl[24], ki, count;
    GetFormInfo(playerid, gPlayer[playerid][pTransform], skin, color, lbl, ki, count);
    new mi = ch * 4 + GetActiveMoveSlot(playerid);

    new m[144];
    format(m, sizeof(m), "==== %s  |  POWER LEVEL: %d ====", lbl, GetEffPower(playerid));
    SendClientMessage(playerid, COLOR_YELLOW, m);
    format(m, sizeof(m), "Move: %s (Ki %d, Dmg %d)   |   Ki: %.0f / %.0f",
        gMoves[mi][mvName], gMoves[mi][mvKi], gMoves[mi][mvDmg], gPlayer[playerid][pKi], gPlayer[playerid][pKiMax]);
    SendClientMessage(playerid, COLOR_WHITE, m);
    SendClientMessage(playerid, COLOR_GREY, "Full breakdown: /stats  |  loadout: /moves /skins  |  level up: /train");
    return 1;
}
