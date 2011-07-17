-- -------------------------------------------------------------------------
-- --------------- Myth Project 'Characters' Database Update ---------------
-- -------------------------------------------------------------------------
-- 'old' Myth Anticheat Tables
DROP TABLE IF EXISTS `players_reports_status`;
DROP TABLE IF EXISTS `daily_players_reports`;
-- Myth Anticheat
DROP TABLE IF EXISTS `anticheat_config`;
CREATE TABLE `anticheat_config` (
    `checktype` mediumint(8) unsigned NOT NULL COMMENT 'Type of check',
    `description` varchar(255),
    `check_period` int(11) unsigned NOT NULL default '0' COMMENT 'Time period of check, in ms, 0 - always',
    `alarmscount` int(11) unsigned NOT NULL default '1'COMMENT 'Count of alarms before action',
    `disableoperation` tinyint(3) unsigned NOT NULL default '0'COMMENT 'GameGuard disable operations in main core code after check fail',
    `messagenum` int(11) NOT NULL default '0' COMMENT 'Number of system message',
    `intparam1` mediumint(8) NOT NULL default '0' COMMENT 'Int parameter 1',
    `intparam2` mediumint(8) NOT NULL default '0' COMMENT 'Int parameter 2',
    `floatparam1` float NOT NULL default '0' COMMENT 'Float parameter 1',
    `floatparam2` float NOT NULL default '0' COMMENT 'Float parameter 2',
    `action1` mediumint(8) NOT NULL default '0' COMMENT 'Action 1',
    `actionparam1` mediumint(8) NOT NULL default '0' COMMENT 'Action parameter 1',
    `action2` mediumint(8) NOT NULL default '0' COMMENT 'Action 1',
    `actionparam2` mediumint(8) NOT NULL default '0' COMMENT 'Action parameter 1',
    PRIMARY KEY (`checktype`)
) DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='GameGuard configuration';

CREATE TABLE IF NOT EXISTS `anticheat_log` (
    `playername` varchar(32) NOT NULL,
    `checktype` mediumint(8) unsigned NOT NULL,
    `alarm_time` datetime NOT NULL,
    `reason` varchar(255) NOT NULL DEFAULT 'Unknown',
    `guid` int(11) unsigned NOT NULL,
    `action1` mediumint(8) NOT NULL default '0',
    `action2` mediumint(8) NOT NULL default '0',
    PRIMARY KEY (`checktype`, `alarm_time`, `guid`),
    KEY idx_Player (`guid`)
) DEFAULT CHARSET=utf8 COMMENT='GameGuard log table';

TRUNCATE `anticheat_config`;
INSERT INTO `anticheat_config` (`checktype`, `description`, `check_period`, `alarmscount`, `disableoperation`, `messagenum`, `intparam1`, `intparam2`, `floatparam1`, `floatparam2`, `action1`, `actionparam1`, `action2`, `actionparam2`) VALUES
(0, 'Null check', 0, 1, 0, 11777, 0, 0,0, 0, 1, 0, 0, 0),
(1, 'Movement cheat', 0, 1, 0, 11777, 0, 0,0, 0, 2, 1, 0, 0),
(2, 'Spell cheat',0, 1, 0, 11777, 0, 0,0, 0, 2, 1, 0, 0),
(3, 'Quest cheat',0, 1, 0, 11777, 0, 0,0, 0, 2, 1, 0, 0),
(4, 'Transport cheat',0, 3, 0, 11777, 0, 0, 60.0, 0, 2, 1, 0, 0),
(5, 'Damage cheat',   0, 1, 0, 11777, 0, 0,0, 0, 2, 1, 0, 0),
(6, 'Item cheat', 0, 1, 0, 11777, 0, 0,0, 0, 2, 1, 0, 0),
(7, 'Warden check',   0, 1, 0, 11777, 0, 0,0, 0, 2, 1, 0, 0),
(101, 'Speed hack',  500, 5, 0, 11777,10000, 0, 0.0012,0, 2, 1, 0, 0),
(102, 'Fly hack',500, 5, 0, 11777,20000, 0,   10.0,0, 2, 1, 0, 0),
(103, 'Wall climb hack', 500, 2, 0, 11777,10000, 0, 0.0015, 2.37, 0, 0, 0, 0),
(104, 'Waterwalking hack',  1000, 3, 0, 11777,20000, 0,  0,0, 0, 0, 0, 0),
(105, 'Teleport to plane hack',  500, 1, 0, 11777,0, 0, 0.0001,  0.1, 2, 1, 0, 0),
(106, 'AirJump hack' ,   500, 3, 0, 11777,30000, 0,   10.0, 25.0, 0, 0, 0, 0),
(107, 'Teleport hack' ,0, 1, 0, 11777,0, 0,   50.0,0, 2, 1, 0, 0),
(108, 'Fall hack' ,0, 3, 0, 11777,10000, 0,  0,0, 2, 1, 0, 0),
(109, 'Z Axis hack' ,  0, 1, 0, 11777,0, 0,0.00001, 10.0, 2, 1, 0, 0),
(201, 'Spell invalid', 0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(202, 'Spellcast in dead state',   0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(203, 'Spell not valid for player',0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(204, 'Spell not in player book',  0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(501, 'Spell damage hack', 0, 1, 0, 11777,0, 50000,  0,0, 2, 1, 0, 0),
(502, 'Melee damage hack', 0, 1, 0, 11777,0, 50000,  0,0, 2, 1, 0, 0),
(601, 'Item dupe hack',0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(701, 'Warden memory check',   0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(702, 'Warden key check',  0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(703, 'Warden checksum check', 0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0),
(704, 'Warden timeout check',  0, 1, 0, 11777,0, 0,  0,0, 2, 1, 0, 0);

-- Myth OutdoorPvP: Wintergrasp
DELETE FROM `worldstates` WHERE `entry` IN (31001, 31002, 31003, 31004);
INSERT INTO `worldstates` VALUES
(31001, 0, 'WG war status'),
(31002, 0, 'WG clock'),
(31003, 0, 'WG Fortress Defender'),
(31004, 0, 'WG TEMP Battle Control Faction');

-- Truncate Character`s/Pet`s active Buffs, to avoid crashes. Because Mech. && Spells Changed.
TRUNCATE character_aura;
TRUNCATE pet_aura;
-- FIX and Prevent Crash into Guild System
ALTER TABLE `guild`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`name`,`guildid`);
-- FIX and Prevent Crash into Char System
ALTER TABLE `characters`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`guid`,`name`);
-- FIX Anticheat Spam "Memory Check", disable checking
UPDATE `anticheat_config` SET `disableoperation` = 0, `messagenum` = 11777, `intparam1` = 0, `intparam2` = 0, `floatparam1` = 0,
`floatparam2` = 0, `action1` = 0, `actionparam1` = 0, `action2` = 0, `actionparam2` = 0, `check_period` = 0 WHERE `checktype` = 701;