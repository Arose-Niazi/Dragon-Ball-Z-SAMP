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
#define SKIN_CUSTOM_VEGETA      20020
#define SKIN_CUSTOM_VEGETA_SSJ  20021
#define SKIN_CUSTOM_VEGETA_SSJ2 20022
#define SKIN_CUSTOM_SATAN       20030
#define SKIN_CUSTOM_VIDEL       20040
#define SKIN_CUSTOM_VIDEL2      20041
#define SKIN_CUSTOM_VIDEL3      20042
#define SKIN_CUSTOM_VIDEL4      20043
#define SKIN_CUSTOM_VIDEL5      20044
#define SKIN_CUSTOM_YAMCHA      20050
#define SKIN_CUSTOM_YAMCHA2     20051
#define SKIN_CUSTOM_YAMCHA3     20052
#define SKIN_CUSTOM_PICCOLO     20060
#define SKIN_CUSTOM_PICCOLO2    20061
#define SKIN_CUSTOM_CELL        20070

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
