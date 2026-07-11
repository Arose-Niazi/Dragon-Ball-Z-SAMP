/*  DBZ / players / database.inc  —  MySQL connection + schema
 *
 *  Backend: maddinat0r MySQL R41 plugin (mysql_connect / mysql_pquery / cache_*).
 *  Connection failure is NON-FATAL: the server still boots so it can be tested
 *  without a live DB, but account features are disabled until connected.
 */
#if defined _dbz_database_included
    #endinput
#endif
#define _dbz_database_included

new MySQL:g_SQL;
new bool:gDBConnected = false;

ConnectDatabase()
{
    mysql_log(ERROR | WARNING);
    g_SQL = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);

    if (mysql_errno(g_SQL) != 0)
    {
        new err[128];
        mysql_error(err, sizeof(err));
        printf("[DBZ][MySQL] Connection FAILED: %s", err);
        printf("[DBZ][MySQL] Running WITHOUT persistence. Set credentials in gamemodes/DBZ/stuff/db_config.inc");
        gDBConnected = false;
        return 0;
    }

    gDBConnected = true;
    print("[DBZ][MySQL] Connected successfully.");
    SetupDatabaseSchema();
    return 1;
}

SetupDatabaseSchema()
{
    // accounts (unix `expire` timestamps in bans; 0 = permanent)
    mysql_tquery(g_SQL, "CREATE TABLE IF NOT EXISTS `accounts` (`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,`name` VARCHAR(24) NOT NULL,`password` VARCHAR(129) NOT NULL,`admin_level` TINYINT UNSIGNED NOT NULL DEFAULT 0,`vip_level` TINYINT UNSIGNED NOT NULL DEFAULT 0,`is_owner` TINYINT UNSIGNED NOT NULL DEFAULT 0,`score` INT NOT NULL DEFAULT 0,`kills` INT UNSIGNED NOT NULL DEFAULT 0,`deaths` INT UNSIGNED NOT NULL DEFAULT 0,`character_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,`transform` TINYINT UNSIGNED NOT NULL DEFAULT 0,`ki` FLOAT NOT NULL DEFAULT 100,`ki_max` FLOAT NOT NULL DEFAULT 100,`health_max` FLOAT NOT NULL DEFAULT 100,`balls_mask` TINYINT UNSIGNED NOT NULL DEFAULT 0,`dragon_radar` TINYINT UNSIGNED NOT NULL DEFAULT 0,`banned` TINYINT UNSIGNED NOT NULL DEFAULT 0,`jailed` TINYINT UNSIGNED NOT NULL DEFAULT 0,`jail_time` INT UNSIGNED NOT NULL DEFAULT 0,`warns` TINYINT UNSIGNED NOT NULL DEFAULT 0,`reg_date` DATETIME DEFAULT NULL,`last_login` DATETIME DEFAULT NULL,`last_ip` VARCHAR(46) DEFAULT NULL,PRIMARY KEY (`id`),UNIQUE KEY `name` (`name`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // bans by name
    mysql_tquery(g_SQL, "CREATE TABLE IF NOT EXISTS `bans` (`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,`name` VARCHAR(24) NOT NULL,`reason` VARCHAR(128) NOT NULL DEFAULT '',`admin` VARCHAR(24) NOT NULL DEFAULT 'System',`expire` INT UNSIGNED NOT NULL DEFAULT 0,`date` DATETIME DEFAULT NULL,PRIMARY KEY (`id`),KEY `name` (`name`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // bans by ip
    mysql_tquery(g_SQL, "CREATE TABLE IF NOT EXISTS `ip_bans` (`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,`ip` VARCHAR(46) NOT NULL,`reason` VARCHAR(128) NOT NULL DEFAULT '',`admin` VARCHAR(24) NOT NULL DEFAULT 'System',`expire` INT UNSIGNED NOT NULL DEFAULT 0,`date` DATETIME DEFAULT NULL,PRIMARY KEY (`id`),KEY `ip` (`ip`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    print("[DBZ][MySQL] Schema ensured (accounts, bans, ip_bans).");
    return 1;
}
