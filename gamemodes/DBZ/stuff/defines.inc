/*  DBZ / stuff / defines.inc  —  core constants  */
#if defined _dbz_defines_included
    #endinput
#endif
#define _dbz_defines_included

#define GAMEMODE_NAME       "Dragon Ball Z"
#define GAMEMODE_VERSION    "v1.0.0-openmp (0.3DL)"

// ---------------------------------------------------------------------------
//  Custom model slots (0.3DL DL).
//  MUST be >= 20000 and MUST NOT collide with any stock GTA skin id or any
//  transform-state skin id used by the combat logic (see legacy GOKU2=100 etc.).
// ---------------------------------------------------------------------------
#define SKIN_CUSTOM_GOKU        20000
#define SKIN_CUSTOM_ANDROID16   20010

// ---------------------------------------------------------------------------
//  Default class-selection / spawn camera (classic SA-MP Los Santos spot).
//  Real DBZ battleground spawns are ported in a later milestone.
// ---------------------------------------------------------------------------
#define SPAWN_X     1958.3783
#define SPAWN_Y     1343.1572
#define SPAWN_Z     15.3746
#define SPAWN_A     270.0

// Staff / gameplay tuning (expanded across later milestones)
#define TOP_ADMIN_LEVEL     10
#define MAX_VIP_LEVEL       3
