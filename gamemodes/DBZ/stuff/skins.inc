/*  DBZ / stuff / skins.inc  —  DBZ character skin ids + combat constants
 *  Stock GTA:SA ped ids act as FORM IDENTITY keys; 0.3DL custom models are
 *  applied on top via SetPlayerSkinMapped (DBZ/players/characters.inc).
 */
#if defined _dbz_skins_included
    #endinput
#endif
#define _dbz_skins_included

// Goku line
#define GOKU0           124
#define GOKU1           247
#define GOKU2           100
#define GOKU3           248
// Vegeta line
#define VEGETA0         96
#define VEGETA1         291
#define VEGETAS         72
#define VEGETA2         147
#define VEGETA_GOD      292
#define VEGETA_BLUE     293
// Trunks line
#define TRUNKS0         217
#define TRUNKS1         101
#define TRUNKSS         97
// Gohan line
#define GOHAN0          176
#define GOHAN1          177
#define GOHAN2          154
// Fusions
#define VEGEKU0         46
#define VEGEKU1         223
#define GOGETA          98
// Humans
#define SATAN           241
#define VIDEL           56
#define CRILIN          121
#define YAMCHA          204
#define TENSHINSHAN     81
// Androids / new fighters
#define ANDROID16       181
#define PICCOLO         183
#define CELL            212
#define CELL_SUPER      213

#define MAX_CHARACTERS  12

// Explosion models used by attack patterns
#define EXP_SMALL       11      // small ki flash
#define EXP_BIG         7       // large blast
#define EXP_MEDIUM      6
#define EXP_FIERY       1
#define EXP_TINY        12

// Ki costs / gameplay tuning
#define KI_BLAST_COST   5.0     // ALT small blast
#define KI_RIG_COST     5.0     // regen
#define ATTACK_COOLDOWN 10000   // ms between special attacks
#define ABSORB_AMOUNT   20.0    // Cell: HP+Ki stolen per absorb
#define ABSORB_COOLDOWN 15      // seconds
