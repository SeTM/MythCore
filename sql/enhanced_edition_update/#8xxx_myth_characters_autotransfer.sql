/* -- PART 1
DROP TABLE IF EXISTS `max_values`; -- DEPRICATED TABLE
CREATE TABLE `max_values` (        -- CLEANER TEMPORY TABLE
  `entry_1_character_guid` INT(20) UNSIGNED DEFAULT NULL COMMENT 'For Character Guids',
  `entry_2_arena_team_id` INT(20) UNSIGNED DEFAULT NULL COMMENT 'For Arena Team Guids',
  `entry_3_item_guid` INT(20) UNSIGNED DEFAULT NULL COMMENT 'For Item Guids',
  `entry_4_guild_id` INT(20) UNSIGNED DEFAULT NULL COMMENT 'For Guild IDs', 
  `entry_5_pet_guid` INT(20) UNSIGNED DEFAULT NULL COMMENT 'for Pet IDs',
  `entry_6_corpse_guid` INT(20) UNSIGNED DEFAULT NULL COMMENT 'for Corpse IDs',
  `entry_7_mail_id` INT(20) UNSIGNED DEFAULT NULL COMMENT 'for Mail ID',
  `entry_8_guild_name` CHAR(24) DEFAULT '' COMMENT 'for Guild Name',
  `entry_9_equipmentset_id` INT(20) UNSIGNED DEFAULT NULL COMMENT 'for Equipment Set IDs'
  
) ENGINE=MYISAM DEFAULT CHARSET=UTF8 ROW_FORMAT=DYNAMIC COMMENT='CLEANER TEMPORY TABLE';

INSERT INTO `max_values` (`entry_1_character_guid`) SELECT MAX(guid) FROM characters;
INSERT INTO `max_values` (`entry_2_arena_team_id`) SELECT MAX(arenaTeamId) FROM arena_team;
INSERT INTO `max_values` (`entry_3_item_guid`) SELECT MAX(guid) FROM item_instance;
INSERT INTO `max_values` (`entry_4_guild_id`) SELECT MAX(guildid) FROM guild;
INSERT INTO `max_values` (`entry_5_pet_guid`) SELECT MAX(id) FROM character_pet;
INSERT INTO `max_values` (`entry_6_corpse_guid`) SELECT MAX(corpseGuid) FROM corpse;
INSERT INTO `max_values` (`entry_7_mail_id`) SELECT MAX(id) FROM mail;
INSERT INTO `max_values` (`entry_8_guild_name`) SELECT `name` FROM guild;
INSERT INTO `max_values` (`entry_9_equipmentset_id`) SELECT MAX(setguid) FROM character_equipmentsets;
*/

-- PART 2
/*
DROP TABLE IF EXISTS `max_account`; -- DEPRICATED TABLE
CREATE TABLE `max_account` (        -- CLEANER TEMPORY TABLE
  `entry_1_account_id` INT(20) UNSIGNED DEFAULT NULL COMMENT 'For Account IDs',
  `entry_2_account_name` CHAR(24) DEFAULT '' COMMENT 'for Guild Name'
) ENGINE=MYISAM DEFAULT CHARSET=UTF8 ROW_FORMAT=DYNAMIC COMMENT='CLEANER TEMPORY TABLE';

INSERT INTO `max_account` (`entry_1_account_id`) SELECT MAX(id) FROM account;
*/

/*
-- PART 4
UPDATE `account` SET `username` = CONCAT(`username`, "new") WHERE `username` IN (SELECT entry_2_account_name FROM `max_account`);
UPDATE `account` SET `id` = id + (SELECT MAX(entry_1_account_id) FROM `max_account`);
*/

/*
-- PART 3
DROP TABLE IF EXISTS 
`account_data`,             	-- DEPRICATED TABLE
`account_instance_times`,   	-- DEPRICATED TABLE
`account_tutorial`,         	-- DEPRICATED TABLE
`addons`,                   	-- DEPRICATED TABLE
`arena_team_history`,       	-- DEPRICATED TABLE
`armory_character_stats`,   	-- DEPRICATED TABLE
`armory_game_chart`,        	-- DEPRICATED TABLE
`auctionhouse`,             	-- DEPRICATED TABLE
`auctionhousebot`,          	-- DEPRICATED TABLE
`battlefield`,              	-- DEPRICATED TABLE
`bugreport`,                	-- DEPRICATED TABLE
`channels`,                 	-- DEPRICATED TABLE
`character_aura`,           	-- DEPRICATED TABLE
`character_battleground_data`, 	-- DEPRICATED TABLE
`character_battleground_random`,-- DEPRICATED TABLE
`character_declinedname`, 	    -- DEPRICATED TABLE
`character_feed_log`,		    -- DEPRICATED TABLE
`character_instance`,		    -- DEPRICATED TABLE
`character_pet_declinedname`,	-- DEPRICATED TABLE
`character_skin_default`,	    -- DEPRICATED TABLE
`cheat_first_report`,		    -- DEPRICATED TABLE
`cheat_reports`,		        -- DEPRICATED TABLE
`cheat_temp_reports`,	    	-- DEPRICATED TABLE
`cheaters`,			            -- DEPRICATED TABLE
`creature_respawn`,	        	-- DEPRICATED TABLE
`custom_commands`,		        -- DEPRICATED TABLE
`game_event_condition_save`,	-- DEPRICATED TABLE
`game_event_save`,		        -- DEPRICATED TABLE
`gameobject_respawn`,	    	-- DEPRICATED TABLE
`gm_subsurveys`,		        -- DEPRICATED TABLE
`gm_surveys`,			        -- DEPRICATED TABLE
`gm_tickets`, 			        -- DEPRICATED TABLE
`group_instance`,		        -- DEPRICATED TABLE
`group_member`,			        -- DEPRICATED TABLE
`groups`,			            -- DEPRICATED TABLE
`guild_bank_eventlog`, 		    -- DEPRICATED TABLE
`guild_eventlog`,		        -- DEPRICATED TABLE
`instance`,			            -- DEPRICATED TABLE
`instance_reset`,		        -- DEPRICATED TABLE
`item_refund_instance`,		    -- DEPRICATED TABLE
`item_soulbound_trade_data`,	-- DEPRICATED TABLE
`lag_reports`,			        -- DEPRICATED TABLE
`mail_external`,		        -- DEPRICATED TABLE
`mail_external_items`,	    	-- DEPRICATED TABLE
`pet_aura`,			            -- DEPRICATED TABLE
`petition`,			            -- DEPRICATED TABLE
`petition_sign`,		        -- DEPRICATED TABLE
`players_reports_status`,	    -- DEPRICATED TABLE
`pool_quest_save`,		        -- DEPRICATED TABLE
`reserved_name`,		        -- DEPRICATED TABLE
`worldstates`;			        -- DEPRICATED TABLE

UPDATE arena_team_member SET arenaTeamId = arenaTeamId + (SELECT MAX(entry_1_character_guid) FROM `max_values`), guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE arena_team SET arenaTeamId = arenaTeamId + (SELECT MAX(entry_1_character_guid) FROM `max_values`), captainGuid = captainGuid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);

UPDATE character_account_data SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_achievement SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_achievement_progress SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_action SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_arena_stats SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_banned SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);

UPDATE character_equipmentsets SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`),
setguid = setguid + (SELECT MAX(entry_9_equipmentset_id) FROM `max_values`),
item1 = item1 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item2 = item2 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item3 = item3 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item4 = item4 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item5 = item5 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item6 = item6 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item7 = item7 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item8 = item8 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item9 = item9 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item10 = item10 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item11 = item11 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item12 = item12 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item13 = item13 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item14 = item14 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item15 = item15 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item16 = item16 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item17 = item17 + (SELECT MAX(entry_3_item_guid) FROM `max_values`),
item18 = item18 + (SELECT MAX(entry_3_item_guid) FROM `max_values`);

UPDATE character_gifts SET guid = guid + (SELECT MAX(entry_1_character_guid)FROM `max_values`),item_guid = item_guid + (SELECT MAX(entry_3_item_guid)FROM `max_values`);
UPDATE character_glyphs SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_homebind SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_inventory SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`), item = item +(SELECT MAX(entry_3_item_guid) FROM `max_values`);

UPDATE character_pet SET id = id + (SELECT MAX(entry_5_pet_guid) FROM `max_values`), `owner` = `owner` + (SELECT MAX(entry_1_character_guid) FROM `max_values`);

UPDATE character_queststatus SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_queststatus_daily SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_queststatus_rewarded SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_queststatus_weekly SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);

UPDATE character_reputation SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_skills SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_social SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_spell SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_spell_cooldown SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_stats SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE character_talent SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE characters SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);

UPDATE corpse SET guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`), corpseGuid = corpseGuid + (SELECT MAX(entry_6_corpse_guid) FROM `max_values`);

UPDATE item_instance SET guid = guid + (SELECT MAX(entry_3_item_guid) FROM `max_values`),owner_guid = owner_guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);

UPDATE guild SET guildid = guildid + (SELECT MAX(entry_4_guild_id) FROM `max_values`),leaderguid = leaderguid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE guild_bank_item SET guildid = guildid + (SELECT MAX(entry_4_guild_id) FROM `max_values`),item_guid = item_guid + (SELECT MAX(entry_3_item_guid) FROM `max_values`);
UPDATE guild_bank_right SET guildid = guildid + (SELECT MAX(entry_4_guild_id) FROM `max_values`);
UPDATE guild_bank_tab SET guildid = guildid + (SELECT MAX(entry_4_guild_id) FROM `max_values`);
UPDATE guild_member SET guildid = guildid + (SELECT MAX(entry_4_guild_id) FROM `max_values`), guid = guid + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE guild_rank SET guildid = guildid + (SELECT MAX(entry_4_guild_id) FROM `max_values`);

UPDATE mail SET id = id + (SELECT MAX(entry_7_mail_id) FROM `max_values`),sender = sender + (SELECT MAX(entry_1_character_guid) FROM `max_values`), receiver = receiver + (SELECT MAX(entry_1_character_guid) FROM `max_values`);
UPDATE mail_items SET mail_id = mail_id + (SELECT MAX(entry_7_mail_id) FROM `max_values`), item_guid = item_guid + (SELECT MAX(entry_3_item_guid) FROM `max_values`);

UPDATE pet_spell SET guid = guid + (SELECT MAX(entry_5_pet_guid) FROM `max_values`);
UPDATE pet_spell_cooldown SET guid = guid + (SELECT MAX(entry_5_pet_guid) FROM `max_values`);

UPDATE `characters` SET `money` = 2000000;

UPDATE `characters` SET `at_login` = 0x01;

UPDATE `guild` SET `name` = CONCAT(`name`, "t") WHERE `name` IN (SELECT entry_8_guild_name FROM `max_values`);
UPDATE `guild` SET `bankmoney` = 0;
UPDATE character_inventory SET bag = bag + (SELECT MAX(entry_3_item_guid) FROM `max_values`) WHERE bag NOT IN (0);


DROP TABLE IF EXISTS `max_values`;      -- DEPRICATED TABLE
*/

/*
-- PART 5
UPDATE `characters` SET `account` = account + (SELECT MAX(entry_1_account_id) FROM `max_account`);
DROP TABLE IF EXISTS `max_account`;     -- DEPRICATED TABLE */