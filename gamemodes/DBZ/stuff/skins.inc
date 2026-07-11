/*  DBZ / stuff / skins.inc  —  DBZ character skin ids + combat constants
 *  (Stock GTA:SA ped ids, verbatim from legacy. Goku & Android16 also have
 *   0.3DL custom models mapped in DBZ/players/skinmap.inc.)
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
// Humans / androids
#define SATAN           241
#define VIDEL           56
#define CRILIN          121
#define YAMCHA          204
#define TENSHINSHAN     81
#define GELO            1
#define ANDROID16       181
#define ANDROID17       128
#define ANDROID18       91
#define ANDROID19       29

#define MAX_CHARACTERS  14

// Explosion models used by attacks
#define EXP_SMALL       11      // small ki flash
#define EXP_BIG         7       // large blast
#define EXP_MEDIUM      6
#define EXP_FIERY       1
#define EXP_TINY        12

// Ki costs / gameplay tuning
#define KI_BLAST_COST   5.0     // ALT small blast
#define KI_RIG_COST     5.0     // /rig
#define ATTACK_COOLDOWN 10000   // ms between /att uses
#define ABSORB_AMOUNT   25.0
