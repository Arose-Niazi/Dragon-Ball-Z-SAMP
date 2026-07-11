/*  DBZ / stuff / server_vars.inc  —  server-wide config & state  */
#if defined _dbz_server_vars_included
    #endinput
#endif
#define _dbz_server_vars_included

// ---------------------------------------------------------------------------
//  Owner designation (config-driven — replaces the legacy hardcoded owner
//  name checks and the /iamownerheresetmelevel10 backdoor). Names listed here
//  are auto-granted Owner + max admin level on login. Case-insensitive.
// ---------------------------------------------------------------------------
new const gOwnerNames[][MAX_PLAYER_NAME] =
{
    "Arose_Niazi"       // <-- put your in-game owner name(s) here
};

stock bool:IsOwnerName(const name[])
{
    for (new i = 0; i < sizeof(gOwnerNames); i++)
        if (!strcmp(name, gOwnerNames[i], true))
            return true;
    return false;
}

// ---------------------------------------------------------------------------
//  Jail location (interior 6 - police cell)
// ---------------------------------------------------------------------------
#define JAIL_X          264.6288
#define JAIL_Y          77.5573
#define JAIL_Z          1001.0389
#define JAIL_INTERIOR   6
