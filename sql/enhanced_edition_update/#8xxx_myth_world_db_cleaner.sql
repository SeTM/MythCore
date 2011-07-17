-- -------------------------------------------------------------------------
-- ---------------- Myth Project "World" Database Cleaner ------------------
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS `db_version_ytdb`;         -- DEPRICATED TABLE
DROP TABLE IF EXISTS `npc_gossip`;              -- DEPRICATED TABLE
DROP TABLE IF EXISTS `game_event_npc_gossip`;   -- DEPRICATED TABLE
DROP TABLE IF EXISTS `lfg_dungeon_encounters`;  -- DEPRICATED TABLE
DROP TABLE IF EXISTS `gameobject_respawn`;      -- DEPRICATED TABLE
DROP TABLE IF EXISTS `creature_respawn`;        -- DEPRICATED TABLE
DROP TABLE IF EXISTS `reserved_name`;           -- DEPRICATED TABLE
DROP TABLE IF EXISTS `custom_texts`;            -- DEPRICATED TABLE
DROP TABLE IF EXISTS `locales_item_set_name`;   -- DEPRICATED TABLE
/*
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS `cleanup_data`;            -- DEPRICATED TABLE
CREATE TABLE `cleanup_data` (                   -- CLEANER TEMPORY TABLE
  `entry1` int(20) unsigned DEFAULT NULL COMMENT 'ID Stream for cleaning N1',
  `entry2` int(20) unsigned DEFAULT NULL COMMENT 'ID Stream for cleaning N2',
  PRIMARY KEY  (`entry1`,`entry2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='CLEANER TEMPORY TABLE';*/
-- -------------------------------------------------------------------------
-- CREATURES
 DELETE FROM `creature` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);                            -- Dinamic // "creature" table
 DELETE FROM `creature_template_addon` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);          -- Dinamic // "creature_template_addon" table
 DELETE FROM `creature_formations` WHERE `leaderGUID` NOT IN (SELECT `guid` FROM `creature`)
OR `memberGUID` NOT IN (SELECT `guid` FROM `creature`);                                                         -- Dinamic // "creature_formations" table
 DELETE FROM `creature_onkill_reputation` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`); -- Dinamic // "creature_onkill_reputation" table
 DELETE FROM `linked_respawn` WHERE `linkedguid` NOT IN (SELECT `guid` FROM `creature`);                        -- Dinamic // "linked_respawn" table
 DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);                              -- Dinamic // "creature_addon" table
 DELETE FROM `battlemaster_entry` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);               -- Dinamic // "battlemaster_entry" table
-- -------------------------------------------------------------------------
-- GAMEOBJECTS
 DELETE FROM `gameobject` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);                        -- Dinamic // "gameobject" table
 DELETE FROM `gameobject_scripts` WHERE `id` NOT IN (SELECT `guid` FROM `gameobject`);                          -- Dinamic // "gameobject_scripts" table
 DELETE FROM `gameobject_involvedrelation` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);       -- Dinamic // "gameobject_involvedrelation" table
 DELETE FROM `gameobject_loot_template` WHERE `entry` NOT IN (SELECT `entry` FROM `gameobject_template`);       -- Dinamic // "gameobject_loot_template" table
 DELETE FROM `gameobject_questrelation` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);          -- Dinamic // "gameobject_questrelation" table
-- -------------------------------------------------------------------------
-- GOSSIPS
/*TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `gossip_menu_id` FROM `creature_template`;
 DELETE FROM `gossip_menu` WHERE `entry` NOT IN (SELECT `entry1` FROM `cleanup_data`);                          -- Dinamic // "gossip_menu" table
 *//*
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `entry` FROM `gossip_menu`;
 DELETE FROM `gossip_menu_option` WHERE `menu_id` NOT IN (SELECT `entry1` FROM `cleanup_data`);                 -- Dinamic // "gossip_menu_option" table
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action_script_id` FROM `gossip_menu_option`;
INSERT IGNORE INTO `cleanup_data`(`entry2`) SELECT `dataint` FROM `gossip_scripts` WHERE `id` NOT IN (SELECT `entry1` FROM `cleanup_data`);
 DELETE FROM `db_script_string` WHERE `entry` IN (SELECT `entry2` FROM `cleanup_data`);                         -- Dinamic // "db_script_string" table
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action_script_id` FROM `gossip_menu_option`; 
 DELETE FROM `gossip_scripts` WHERE `id` NOT IN (SELECT `entry1` FROM `cleanup_data`);                          -- Dinamic // "gossip_scripts" table
*/
-- -------------------------------------------------------------------------
-- CONDITIONS
/* DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14, 15)
AND `SourceGroup` NOT IN (SELECT `entry` FROM `gossip_menu`);                                                   -- Dinamic // "conditions" table
*//*
-- -------------------------------------------------------------------------
-- WAYPOINTS
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `path_id` FROM `creature_addon`;
 DELETE FROM `waypoint_data` WHERE `id` NOT IN (SELECT `entry1` FROM `cleanup_data`);                           -- Dinamic // "waypoint_data" table
 DELETE FROM `waypoints` WHERE `entry` NOT IN (SELECT `entry1` FROM `cleanup_data`);                            -- Dinamic // "waypoints" table
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action` FROM `waypoint_data`; 
 DELETE FROM `script_waypoint` WHERE `entry` NOT IN (SELECT `entry1` FROM `cleanup_data`);                      -- Dinamic // "script_waypoint" table
 SELECT * FROM waypoints WHERE entry IN (SELECT `entry1` FROM `cleanup_data`);
*/

UPDATE `creature_addon` SET `auras` = REPLACE(`auras`,' 0','');
UPDATE `creature_template_addon` SET `auras` = REPLACE(`auras`,' 0','');
UPDATE `creature_addon` SET `auras` = TRIM(`auras`);
UPDATE `creature_template_addon` SET `auras` = TRIM(`auras`);
-- -------------------------------------------------------------------------
-- EVENT AI
/* DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (
SELECT `entry` FROM `creature_template` WHERE `AIName` NOT IN ("EventAI"));                                     -- Dinamic // "creature_ai_scripts" table
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action1_param3` FROM `creature_ai_scripts` WHERE
 `action1_type` = 32 OR `action2_type` = 32 OR `action3_type` = 32;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action2_param3` FROM `creature_ai_scripts` WHERE
 `action1_type` = 32 OR `action2_type` = 32 OR `action3_type` = 32;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action3_param3` FROM `creature_ai_scripts` WHERE
 `action1_type` = 32 OR `action2_type` = 32 OR `action3_type` = 32;
 DELETE FROM `creature_ai_summons` WHERE `id` NOT IN (SELECT `entry1` FROM `cleanup_data`);                     -- Dinamic // "creature_ai_summons" table
TRUNCATE `cleanup_data`;

INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action1_param1` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action1_param2` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action1_param3` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action2_param1` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action2_param2` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action2_param3` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action3_param1` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action3_param2` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `action3_param3` FROM `creature_ai_scripts` WHERE
 `action1_type` = 1 OR `action2_type` = 1 OR `action3_type` = 1;
DELETE FROM `creature_ai_texts` WHERE `entry` NOT IN (SELECT `entry1` FROM `cleanup_data`);                     -- Dinamic // "creature_ai_texts" table
*//*
-- -------------------------------------------------------------------------
-- SMART AI
TRUNCATE `cleanup_data`;
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `entry` FROM `creature_template` WHERE `AIName` = "SmartAI";
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `entry` FROM `gameobject_template` WHERE `AIName` = "SmartGameObjectAI";
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `guid` FROM `creature` WHERE `id` IN (SELECT `entry` FROM `creature_template` WHERE `AIName` = "SmartAI");
INSERT IGNORE INTO `cleanup_data`(`entry1`) SELECT `guid` FROM `gameobject` WHERE `id` IN (SELECT `entry` FROM `gameobject_template` WHERE `AIName` = "SmartGameObjectAI");
DELETE FROM `smart_scripts` WHERE `entryorguid` NOT IN (SELECT `entry1` FROM `cleanup_data`);

DROP TABLE IF EXISTS `cleanup_data`;            -- DEPRICATED TABLE
*/
-- -------------------------------------------------------------------------
-- ------------- Myth Project "World" Database Locales Wipe ----------------
-- -------------------------------------------------------------------------
-- Locales WIPE.
/* Full WIPE */
TRUNCATE locales_achievement_reward;
TRUNCATE locales_creature;
TRUNCATE locales_gameobject;
TRUNCATE locales_gossip_menu_option;
TRUNCATE locales_item;
TRUNCATE locales_item_set_names;
TRUNCATE locales_npc_text;
TRUNCATE locales_page_text;
TRUNCATE locales_points_of_interest;
TRUNCATE locales_quest;
/* You can wipe table per table, locale per locale or both, with the query presented below. */
/* Comment with -- Not needed Queries *//*
UPDATE locales_achievement_reward SET subject_loc8 = '', text_loc8 = '';
UPDATE locales_achievement_reward SET subject_loc7 = '', text_loc7 = '';
UPDATE locales_achievement_reward SET subject_loc6 = '', text_loc6 = '';
UPDATE locales_achievement_reward SET subject_loc5 = '', text_loc5 = '';
UPDATE locales_achievement_reward SET subject_loc4 = '', text_loc4 = '';
UPDATE locales_achievement_reward SET subject_loc3 = '', text_loc3 = '';
UPDATE locales_achievement_reward SET subject_loc2 = '', text_loc2 = '';
UPDATE locales_achievement_reward SET subject_loc1 = '', text_loc1 = '';

UPDATE locales_creature SET name_loc8 = '', subname_loc8 = '';
UPDATE locales_creature SET name_loc7 = '', subname_loc7 = '';
UPDATE locales_creature SET name_loc6 = '', subname_loc6 = '';
UPDATE locales_creature SET name_loc5 = '', subname_loc5 = '';
UPDATE locales_creature SET name_loc4 = '', subname_loc4 = '';
UPDATE locales_creature SET name_loc3 = '', subname_loc3 = '';
UPDATE locales_creature SET name_loc2 = '', subname_loc2 = '';
UPDATE locales_creature SET name_loc1 = '', subname_loc1 = '';

UPDATE locales_gameobject SET name_loc8 = '', castbarcaption_loc8 = '';
UPDATE locales_gameobject SET name_loc7 = '', castbarcaption_loc7 = '';
UPDATE locales_gameobject SET name_loc6 = '', castbarcaption_loc6 = '';
UPDATE locales_gameobject SET name_loc5 = '', castbarcaption_loc5 = '';
UPDATE locales_gameobject SET name_loc4 = '', castbarcaption_loc4 = '';
UPDATE locales_gameobject SET name_loc3 = '', castbarcaption_loc3 = '';
UPDATE locales_gameobject SET name_loc2 = '', castbarcaption_loc2 = '';
UPDATE locales_gameobject SET name_loc1 = '', castbarcaption_loc1 = '';

UPDATE locales_gossip_menu_option SET option_text_loc8 = '', box_text_loc8 = '';
UPDATE locales_gossip_menu_option SET option_text_loc7 = '', box_text_loc7 = '';
UPDATE locales_gossip_menu_option SET option_text_loc6 = '', box_text_loc6 = '';
UPDATE locales_gossip_menu_option SET option_text_loc5 = '', box_text_loc5 = '';
UPDATE locales_gossip_menu_option SET option_text_loc4 = '', box_text_loc4 = '';
UPDATE locales_gossip_menu_option SET option_text_loc3 = '', box_text_loc3 = '';
UPDATE locales_gossip_menu_option SET option_text_loc2 = '', box_text_loc2 = '';
UPDATE locales_gossip_menu_option SET option_text_loc1 = '', box_text_loc1 = '';

UPDATE locales_item SET name_loc8 = '', description_loc8 = '';
UPDATE locales_item SET name_loc7 = '', description_loc7 = '';
UPDATE locales_item SET name_loc6 = '', description_loc6 = '';
UPDATE locales_item SET name_loc5 = '', description_loc5 = '';
UPDATE locales_item SET name_loc4 = '', description_loc4 = '';
UPDATE locales_item SET name_loc3 = '', description_loc3 = '';
UPDATE locales_item SET name_loc2 = '', description_loc2 = '';
UPDATE locales_item SET name_loc1 = '', description_loc1 = '';

UPDATE locales_item_set_names SET name_loc8 = '';
UPDATE locales_item_set_names SET name_loc7 = '';
UPDATE locales_item_set_names SET name_loc6 = '';
UPDATE locales_item_set_names SET name_loc5 = '';
UPDATE locales_item_set_names SET name_loc4 = '';
UPDATE locales_item_set_names SET name_loc3 = '';
UPDATE locales_item_set_names SET name_loc2 = '';
UPDATE locales_item_set_names SET name_loc1 = '';

UPDATE locales_npc_text SET
Text0_0_loc8 = '', Text0_1_loc8 = '',
Text1_0_loc8 = '', Text1_1_loc8 = '',
Text2_0_loc8 = '', Text2_1_loc8 = '',
Text3_0_loc8 = '', Text3_1_loc8 = '',
Text4_0_loc8 = '', Text4_1_loc8 = '',
Text5_0_loc8 = '', Text5_1_loc8 = '',
Text6_0_loc8 = '', Text6_1_loc8 = '',
Text7_0_loc8 = '', Text7_1_loc8 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc7 = '', Text0_1_loc7 = '',
Text1_0_loc7 = '', Text1_1_loc7 = '',
Text2_0_loc7 = '', Text2_1_loc7 = '',
Text3_0_loc7 = '', Text3_1_loc7 = '',
Text4_0_loc7 = '', Text4_1_loc7 = '',
Text5_0_loc7 = '', Text5_1_loc7 = '',
Text6_0_loc7 = '', Text6_1_loc7 = '',
Text7_0_loc7 = '', Text7_1_loc7 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc6 = '', Text0_1_loc6 = '',
Text1_0_loc6 = '', Text1_1_loc6 = '',
Text2_0_loc6 = '', Text2_1_loc6 = '',
Text3_0_loc6 = '', Text3_1_loc6 = '',
Text4_0_loc6 = '', Text4_1_loc6 = '',
Text5_0_loc6 = '', Text5_1_loc6 = '',
Text6_0_loc6 = '', Text6_1_loc6 = '',
Text7_0_loc6 = '', Text7_1_loc6 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc5 = '', Text0_1_loc5 = '',
Text1_0_loc5 = '', Text1_1_loc5 = '',
Text2_0_loc5 = '', Text2_1_loc5 = '',
Text3_0_loc5 = '', Text3_1_loc5 = '',
Text4_0_loc5 = '', Text4_1_loc5 = '',
Text5_0_loc5 = '', Text5_1_loc5 = '',
Text6_0_loc5 = '', Text6_1_loc5 = '',
Text7_0_loc5 = '', Text7_1_loc5 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc4 = '', Text0_1_loc4 = '',
Text1_0_loc4 = '', Text1_1_loc4 = '',
Text2_0_loc4 = '', Text2_1_loc4 = '',
Text3_0_loc4 = '', Text3_1_loc4 = '',
Text4_0_loc4 = '', Text4_1_loc4 = '',
Text5_0_loc4 = '', Text5_1_loc4 = '',
Text6_0_loc4 = '', Text6_1_loc4 = '',
Text7_0_loc4 = '', Text7_1_loc4 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc3 = '', Text0_1_loc3 = '',
Text1_0_loc3 = '', Text1_1_loc3 = '',
Text2_0_loc3 = '', Text2_1_loc3 = '',
Text3_0_loc3 = '', Text3_1_loc3 = '',
Text4_0_loc3 = '', Text4_1_loc3 = '',
Text5_0_loc3 = '', Text5_1_loc3 = '',
Text6_0_loc3 = '', Text6_1_loc3 = '',
Text7_0_loc3 = '', Text7_1_loc3 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc2 = '', Text0_1_loc2 = '',
Text1_0_loc2 = '', Text1_1_loc2 = '',
Text2_0_loc2 = '', Text2_1_loc2 = '',
Text3_0_loc2 = '', Text3_1_loc2 = '',
Text4_0_loc2 = '', Text4_1_loc2 = '',
Text5_0_loc2 = '', Text5_1_loc2 = '',
Text6_0_loc2 = '', Text6_1_loc2 = '',
Text7_0_loc2 = '', Text7_1_loc2 = '' ;

UPDATE locales_npc_text SET
Text0_0_loc1 = '', Text0_1_loc1 = '',
Text1_0_loc1 = '', Text1_1_loc1 = '',
Text2_0_loc1 = '', Text2_1_loc1 = '',
Text3_0_loc1 = '', Text3_1_loc1 = '',
Text4_0_loc1 = '', Text4_1_loc1 = '',
Text5_0_loc1 = '', Text5_1_loc1 = '',
Text6_0_loc1 = '', Text6_1_loc1 = '',
Text7_0_loc1 = '', Text7_1_loc1 = '' ;

UPDATE locales_page_text SET Text_loc8 = '';
UPDATE locales_page_text SET Text_loc7 = '';
UPDATE locales_page_text SET Text_loc6 = '';
UPDATE locales_page_text SET Text_loc5 = '';
UPDATE locales_page_text SET Text_loc4 = '';
UPDATE locales_page_text SET Text_loc3 = '';
UPDATE locales_page_text SET Text_loc2 = '';
UPDATE locales_page_text SET Text_loc1 = '';

UPDATE locales_points_of_interest SET icon_name_loc8 = '';
UPDATE locales_points_of_interest SET icon_name_loc7 = '';
UPDATE locales_points_of_interest SET icon_name_loc6 = '';
UPDATE locales_points_of_interest SET icon_name_loc5 = '';
UPDATE locales_points_of_interest SET icon_name_loc4 = '';
UPDATE locales_points_of_interest SET icon_name_loc3 = '';
UPDATE locales_points_of_interest SET icon_name_loc2 = '';
UPDATE locales_points_of_interest SET icon_name_loc1 = '';

UPDATE locales_quest SET Title_loc8 = '',
Details_loc8 = '', Objectives_loc8 = '',
OfferRewardText_loc8 = '', RequestItemsText_loc8 = '',
EndText_loc8 = '', CompletedText_loc8 = '',
ObjectiveText1_loc8 = '', ObjectiveText2_loc8 = '',
ObjectiveText3_loc8 = '', ObjectiveText4_loc8 = '';

UPDATE locales_quest SET Title_loc7 = '',
Details_loc7 = '', Objectives_loc7 = '',
OfferRewardText_loc7 = '', RequestItemsText_loc7 = '',
EndText_loc7 = '', CompletedText_loc7 = '',
ObjectiveText1_loc7 = '', ObjectiveText2_loc7 = '',
ObjectiveText3_loc7 = '', ObjectiveText4_loc7 = '';

UPDATE locales_quest SET Title_loc6 = '',
Details_loc6 = '', Objectives_loc6 = '',
OfferRewardText_loc6 = '', RequestItemsText_loc6 = '',
EndText_loc6 = '', CompletedText_loc6 = '',
ObjectiveText1_loc6 = '', ObjectiveText2_loc6 = '',
ObjectiveText3_loc6 = '', ObjectiveText4_loc6 = '';

UPDATE locales_quest SET Title_loc5 = '',
Details_loc5 = '', Objectives_loc5 = '',
OfferRewardText_loc5 = '', RequestItemsText_loc5 = '',
EndText_loc5 = '', CompletedText_loc5 = '',
ObjectiveText1_loc5 = '', ObjectiveText2_loc5 = '',
ObjectiveText3_loc5 = '', ObjectiveText4_loc5 = '';

UPDATE locales_quest SET Title_loc4 = '',
Details_loc4 = '', Objectives_loc4 = '',
OfferRewardText_loc4 = '', RequestItemsText_loc4 = '',
EndText_loc4 = '', CompletedText_loc4 = '',
ObjectiveText1_loc4 = '', ObjectiveText2_loc4 = '',
ObjectiveText3_loc4 = '', ObjectiveText4_loc4 = '';

UPDATE locales_quest SET Title_loc3 = '',
Details_loc3 = '', Objectives_loc3 = '',
OfferRewardText_loc3 = '', RequestItemsText_loc3 = '',
EndText_loc3 = '', CompletedText_loc3 = '',
ObjectiveText1_loc3 = '', ObjectiveText2_loc3 = '',
ObjectiveText3_loc3 = '', ObjectiveText4_loc3 = '';

UPDATE locales_quest SET Title_loc2 = '',
Details_loc2 = '', Objectives_loc2 = '',
OfferRewardText_loc2 = '', RequestItemsText_loc2 = '',
EndText_loc2 = '', CompletedText_loc2 = '',
ObjectiveText1_loc2 = '', ObjectiveText2_loc2 = '',
ObjectiveText3_loc2 = '', ObjectiveText4_loc2 = '';

UPDATE locales_quest SET Title_loc1 = '',
Details_loc1 = '', Objectives_loc1 = '',
OfferRewardText_loc1 = '', RequestItemsText_loc1 = '',
EndText_loc1 = '', CompletedText_loc1 = '',
ObjectiveText1_loc1 = '', ObjectiveText2_loc1 = '',
ObjectiveText3_loc1 = '', ObjectiveText4_loc1 = '';
*/