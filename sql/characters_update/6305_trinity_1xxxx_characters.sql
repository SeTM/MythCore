ALTER TABLE `arena_team`
CHANGE `rating` `rating` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
CHANGE `rank` `rank` INT(10) UNSIGNED NOT NULL DEFAULT '0';

ALTER TABLE `character_homebind`
    CHANGE `map` `mapId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
    CHANGE `zone` `zoneId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Zone Identifier',
    CHANGE `position_x` `posX` float NOT NULL DEFAULT '0',
    CHANGE `position_y` `posY` float NOT NULL DEFAULT '0',
    CHANGE `position_z` `posZ` float NOT NULL DEFAULT '0';

ALTER TABLE `character_battleground_data`
    CHANGE `instance_id` `instanceId` int(10) unsigned NOT NULL COMMENT 'Instance Identifier',
    CHANGE `join_map` `joinMapId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
    CHANGE `join_x` `joinX` float NOT NULL DEFAULT '0',
    CHANGE `join_y` `joinY` float NOT NULL DEFAULT '0',
    CHANGE `join_z` `joinZ` float NOT NULL DEFAULT '0',
    CHANGE `join_o` `joinO` float NOT NULL DEFAULT '0',
    CHANGE `taxi_start` `taxiStart` int(10) unsigned NOT NULL DEFAULT '0',
    CHANGE `taxi_end` `taxiEnd` int(10) unsigned NOT NULL DEFAULT '0',
    CHANGE `mount_spell` `mountSpell` mediumint(8) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `arena_team_member`
ADD COLUMN `personalRating` SMALLINT(5) NOT NULL DEFAULT '0' AFTER guid;

UPDATE arena_team_member
INNER JOIN character_arena_stats ON arena_team_member.guid = character_arena_stats.guid
INNER JOIN arena_team ON arena_team.arenaTeamId = arena_team_member.arenaTeamId AND (slot = 0 AND TYPE = 2 OR slot = 1 AND TYPE = 3 OR slot = 2 AND TYPE = 5)
SET arena_team_member.personalRating = character_arena_stats.personalRating;

ALTER TABLE `character_arena_stats`
DROP COLUMN `personalRating`;

