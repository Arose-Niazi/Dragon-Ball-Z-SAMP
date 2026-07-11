/*  DBZ / stuff / ranks.inc  —  admin & VIP rank titles (single source of truth)  */
#if defined _dbz_ranks_included
    #endinput
#endif
#define _dbz_ranks_included

// admin_level 0..10
new const gAdminTitles[][] =
{
    "Player",           // 0
    "Trial Admin",      // 1
    "Junior Admin",     // 2
    "Admin",            // 3
    "Senior Admin",     // 4
    "Head Admin",       // 5
    "Moderator",        // 6
    "Super Moderator",  // 7
    "Manager",          // 8
    "Co-Owner",         // 9
    "Owner"             // 10
};

// vip_level 0..3
new const gVipTitles[][] =
{
    "None",             // 0
    "Bronze",           // 1
    "Silver",           // 2
    "Gold"              // 3
};

stock GetAdminTitle(level)
{
    new title[24];
    if (level < 0) level = 0;
    if (level > TOP_ADMIN_LEVEL) level = TOP_ADMIN_LEVEL;
    format(title, sizeof(title), "%s", gAdminTitles[level]);
    return title;
}

stock GetVipTitle(level)
{
    new title[12];
    if (level < 0) level = 0;
    if (level > MAX_VIP_LEVEL) level = MAX_VIP_LEVEL;
    format(title, sizeof(title), "%s", gVipTitles[level]);
    return title;
}
