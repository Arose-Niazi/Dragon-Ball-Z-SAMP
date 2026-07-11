/*  DBZ / stuff / db_config.inc  —  MySQL connection credentials
 *
 *  Persistence backend: MySQL (maddinat0r R41 plugin).
 *  Toggle LOCAL_DB in dbz.pwn to switch between the local and remote credential
 *  sets below. DO NOT commit real production credentials — replace the
 *  placeholders locally or (preferably) inject them via your deployment.
 */
#if defined _dbz_db_config_included
    #endinput
#endif
#define _dbz_db_config_included

#if defined LOCAL_DB
    #define SQL_HOST    "127.0.0.1"
    #define SQL_USER    "dbz"
    #define SQL_PASS    "change_me_local"
    #define SQL_DB      "dbz"
#else
    #define SQL_HOST    "CHANGE_ME_REMOTE_HOST"
    #define SQL_USER    "dbz"
    #define SQL_PASS    "CHANGE_ME_REMOTE_PASS"
    #define SQL_DB      "dbz"
#endif
