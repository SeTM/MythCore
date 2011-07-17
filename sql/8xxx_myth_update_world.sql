-- -------------------------------------------------------------------------}
-- ----------------- Myth Project "World" Database Update ------------------
-- -------------------------------------------------------------------------{
TRUNCATE `version`;
INSERT INTO `version` VALUES (NULL,NULL,'MythDB v7.1.6 WOTKL','MythAI v7.1.6 WOTKL', 602);
-- -------------------------------------------------------------------------}
-- ------------ Myth Project "Auto Complete" Quests Update -----------------
-- -------------------------------------------------------------------------{
UPDATE `quest_template` SET `QuestFlags` = 0 WHERE `entry` IN (
24476, 20439, 12967, 13396, 12589, 12671, 13011,
12987, 12663, 12664, 12673, 12676, 12630, 12713, 12512, 24507, 24498, 24815, 11337,
14163, 11335, 24426, 10866, 10163, 12887, 13829, 12843, 13679, 13838, 13221, 13418,  
11070, 11069, 11064, 10772, 12717, 13839, 12261, 12685, 12665, 12647,
12924, 12915, 11661, 12886, 11310, 12557, 12994,
24564, 13663, 24558,
24560, 11711, 7481,
8309, 12641);
-- -------------------------------------------------------------------------}
-- --------------------------- Icecrown Citadel ----------------------------
-- -------------------------------------------------------------------------{
DELETE FROM `waypoint_scripts` WHERE `dataint` = 38879;
DELETE FROM `waypoint_data` WHERE `action` IN (716, 717, 718, 719, 70, 721, 722, 747, 748, 749, 750);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (/*93949, 93948, 93947, 93946,*/ -93949, -93948, -93947, -93946);
DELETE FROM `areatrigger_teleport` WHERE `id` = 5718;

DELETE FROM `creature` WHERE `id` IN (38557, 37013, 38995, 37813, 36659, 37950, 37824, 37970, 37972, 37973, 37187, 37200);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL, 36659, 631, 15, 1, 11686, 0, 4267.87, 3137.33, 360.469, 0, 300, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37813, 631, 15, 1, 30790, 0, -493.905, 2211.35, 541.114, 3.18037, 604800, 0, 0, 12299490, 0, 0, 0, 0, 0, 0),
(NULL, 37950, 631, 15, 16, 0, 0, 4203.65, 2483.89, 390.961, 5.51524, 604800, 0, 0, 6000003, 0, 0, 0, 0, 33540, 8),
(NULL, 37013, 631, 15, 1, 0, 0, 4421.9, 3092.42, 372.456, 0.994838, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4472.55, 3110.78, 360.469, 2.35619, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4244.04, 3092.66, 372.97, 0.977384, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4463.86, 3101.57, 360.469, 2.04204, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4291.45, 3181.25, 372.97, 4.10152, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4411.07, 3154.75, 360.469, 5.81195, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4312.36, 3160.84, 372.97, 3.80482, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4490.33, 3113.29, 372.411, 2.53073, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4481.93, 3153.87, 360.469, 3.57792, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4291.18, 3092.92, 372.97, 2.33874, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4409.69, 3119.34, 360.469, 0.471239, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4419.42, 3164.15, 360.469, 5.46288, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4401.28, 3112.96, 372.431, 0.785398, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4471.93, 3163.9, 360.469, 3.92699, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4243.89, 3181.74, 372.97, 5.44543, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4419.03, 3109.9, 360.469, 0.767945, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4469.67, 3181.77, 372.311, 4.11898, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4480.85, 3118.98, 360.469, 2.67035, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4463.88, 3172.66, 360.469, 4.24115, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4222.44, 3161.69, 372.97, 5.53269, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4428.15, 3101.17, 360.469, 1.11701, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4421.79, 3181.76, 372.29, 5.46288, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4469.68, 3092.91, 372.325, 2.35619, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4223.47, 3113.58, 372.97, 0.767945, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4401.32, 3160.83, 372.316, 5.55015, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4490.13, 3160.97, 372.312, 3.82227, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4428.96, 3173.66, 360.469, 5.13127, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37013, 631, 15, 1, 0, 0, 4312.14, 3112.98, 372.97, 2.51327, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 38995, 631, 15, 1, 0, 0, 505.212, -2124.35, 1040.94, 3.14159, 604800, 0, 0, 13945000, 4258000, 0, 0, 0, 0, 0),
(NULL, 37824, 631, 15, 1, 0, 0, 4388.1, 3213.29, 408.74, 3.83972, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37824, 631, 15, 1, 11686, 0, 4388.1, 3213.29, 408.74, 3.83972, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37824, 631, 15, 1, 11686, 0, 4324.28, 3215.04, 408.705, 5.58505, 86400, 0, 0, 25200, 0, 0, 0, 0, 0, 0),
(NULL, 37970, 631, 15, 1, 0, 0, 4680.29, 2769.24, 364.17, 3.14159, 86400, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(NULL, 37972, 631, 15, 1, 0, 0, 4682.73, 2783.42, 364.17, 3.14159, 86400, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(NULL, 37973, 631, 15, 1, 0, 0, 4682.89, 2755.11, 364.17, 3.14159, 86400, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(NULL, 37187, 631, 15, 64, 0, 2021, -542.014, 2211.24, 539.291, 6.27645, 720000, 0, 0, 4183500, 0, 0, 0, 0, 0, 0),
(NULL, 37200, 631, 15, 128, 0, 2022, -542.014, 2211.24, 539.291, 6.27645, 720000, 0, 0, 4183500, 0, 0, 0, 0, 0, 0);
UPDATE `creature` SET `position_z` = 1040 WHERE `id` = 22515 AND `map` = 631;
UPDATE `creature` SET `curhealth` = 1 WHERE `id` IN (37970, 38401, 38784, 38785, 37972, 38399, 38769, 37973, 38400, 38771);

DELETE FROM `creature_template` WHERE `entry` IN (37970, 37972, 37973, 38401, 38784, 38785, 38399, 38769, 38770, 38400, 38771, 38772, 36672);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `Ainame`, `MovementType`, `inhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(36672, 0, 0, 0, 0, 0, 1126, 11686, 0, 0,'Coldflame','','', 0, 80, 80, 0, 21, 21, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 0, 0, 1, 33554432, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128,'npc_coldflame', 12340),
(37970, 38401, 38784, 38785, 0, 0, 30858, 0, 0, 0,'Prince Valanar','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 37970, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 405, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10092, 0, 1,'boss_prince_valanar_icc', 12340),
(37972, 38399, 38769, 38770, 0, 0, 30857, 0, 0, 0,'Prince Keleseth','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 405, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10077, 0, 1,'boss_prince_keleseth_icc', 12340),
(37973, 38400, 38771, 38772, 0, 0, 30856, 0, 0, 0,'Prince Taldaram','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 405, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10091, 0, 1,'boss_prince_taldaram_icc', 12340),
(38399, 0, 0, 0, 0, 0, 30857, 0, 0, 0,'Prince Keleseth (1)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 70, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1620, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10077, 0, 1,'', 12340),
(38400, 0, 0, 0, 0, 0, 30856, 0, 0, 0,'Prince Taldaram (1)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 70, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1620, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10091, 0, 1,'', 12340),
(38401, 0, 0, 0, 0, 0, 30858, 0, 0, 0,'Prince Valanar (1)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 2000, 2000, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 100, 6, 108, 38401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1620, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10092, 0, 1,'', 12340),
(38769, 0, 0, 0, 0, 0, 30857, 0, 0, 0,'Prince Keleseth (2)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 546.75, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10077, 0, 1,'', 12340),
(38770, 0, 0, 0, 0, 0, 30857, 0, 0, 0,'Prince Keleseth (3)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 2187, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10077, 0, 1,'', 12340),
(38771, 0, 0, 0, 0, 0, 30856, 0, 0, 0,'Prince Taldaram (2)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 546.75, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10091, 0, 1,'', 12340),
(38772, 0, 0, 0, 0, 0, 30856, 0, 0, 0,'Prince Taldaram (3)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 2187, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10091, 0, 1,'', 12340),
(38784, 0, 0, 0, 0, 0, 30858, 0, 0, 0,'Prince Valanar (2)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 2000, 2000, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 100, 6, 108, 38784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 546.75, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10092, 0, 1,'', 12340),
(38785, 0, 0, 0, 0, 0, 30858, 0, 0, 0,'Prince Valanar (3)','','', 0, 83, 83, 2, 16, 16, 0, 1.6, 1.42857, 1, 3, 509, 683, 0, 805, 35, 2000, 2000, 1, 536904000, 8, 0, 0, 0, 0, 0, 371, 535, 100, 6, 108, 38785, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 2187, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 0, 10092, 0, 1,'', 12340);

DELETE FROM `creature_template_addon` WHERE `entry` IN (37690, 37672, 36659, 38186, 37945, 38429, 38430, 37918, 37006, 37186, 36597);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(37690, 0, 0, 0, 0, 0,'70345 70343'),
(37672, 0, 0, 0, 0, 0,'70385 70405'),
(36597, 0, 0, 1, 0, 0, 72846),
(38186, 0, 0, 0, 0, 0, 71304),
(37945, 0, 0, 0, 0, 0, 70763),
(38429, 0, 0, 0, 0, 0, 71986),
(38430, 0, 0, 0, 0, 0, 71994),
(37918, 0, 0, 0, 0, 0, 70715),
(37186, 0, 0, 0, 0, 0, 70022),
(37006, 0, 0, 0, 0, 0, 69776);

UPDATE `creature_template` SET `equipment_id` = 0 WHERE `Entry` IN (37970, 37972, 37973, 38399, 38400, 38401, 38769, 38770, 38771, 38772, 38784, 38785);
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (36609, 39120, 39121, 39122, 37007);
UPDATE `creature_template` SET `vehicleid` = 533 WHERE `entry` IN (36609, 39120, 39121, 39122);
UPDATE `creature_template` SET `modelid1` = 11686 WHERE `entry` IN (36633, 39305, 39306, 39307, 15214);
UPDATE `creature_template` SET `dmg_multiplier` = 52 WHERE `entry` = 36824; -- Spirit Warden
UPDATE `creature_template` SET `dmg_multiplier` = 35 WHERE `entry` = 36823; -- Terenas Menethil
UPDATE `creature_template` SET `ScriptName` = 'npc_terenas_fighter_icc' WHERE `entry` = 3682;
UPDATE `creature_template` SET `ScriptName` = 'npc_ice_sphere_icc' WHERE `entry` = 36633;
UPDATE `creature_template` SET `ScriptName` = 'npc_defile_icc' WHERE `entry` = 38757;
UPDATE `creature_template` SET `ScriptName` = 'npc_spirit_warden_icc' WHERE `entry` = 36824;
UPDATE `creature_template` SET `ScriptName` = 'boss_the_lich_king' WHERE `entry` = 36597;
UPDATE `creature_template` SET `ScriptName` = 'npc_tirion_icc' WHERE `entry` = 38995;
UPDATE `creature_template` SET `ScriptName` = 'npc_valkyr_icc' WHERE `entry` = 36609;
UPDATE `creature_template` SET `ScriptName` = 'npc_vile_spirit_icc' WHERE `entry` = 37799;
UPDATE `creature_template` SET `ScriptName` = 'npc_shambling_horror_icc' WHERE `entry` = 37698;
UPDATE `creature_template` SET `ScriptName` = 'npc_raging_spirit_icc' WHERE `entry` = 36701;
UPDATE `creature_template` SET `lootid` = 37970 WHERE `entry` = 37973;
UPDATE `creature_template` SET `lootid` = 37970 WHERE `entry` = 37972;
UPDATE `creature_template` SET `lootid` = 38401 WHERE `entry` = 38400;
UPDATE `creature_template` SET `lootid` = 38401 WHERE `entry` = 38399;
UPDATE `creature_template` SET `lootid` = 38784 WHERE `entry` = 38771;
UPDATE `creature_template` SET `lootid` = 38784 WHERE `entry` = 38769;
UPDATE `creature_template` SET `lootid` = 38785 WHERE `entry` = 38772;
UPDATE `creature_template` SET `lootid` = 38785 WHERE `entry` = 38770;
UPDATE `creature_template` SET `dynamicflags` = 9 WHERE `entry` IN (37973, 37972, 38400, 38399, 38771, 38769, 38772, 38770);
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854399 WHERE `entry` IN (37970, 37972, 37973, 38401, 38784, 38785, 38399, 38769, 38770, 38400, 38771, 38772);
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554434, `type_flags` = 1024 WHERE `entry` = 36672;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 37950;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 0, type_flags = 0, `VehicleId` = 533 WHERE `entry` IN (36619, 38233, 38459, 38460);
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `minlevel` = 80, `maxlevel` = 80, `flags_extra` = 128, `unit_flags` = 0 WHERE `entry` = 37013;
UPDATE `creature_template` SET `faction_A` = 21, `faction_H` = 21, `unit_flags` = 33600, `vehicleId` = 639 WHERE `entry` IN (37813, 38402, 38582, 38583);
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `type_flags` = 67113036 WHERE `entry` IN (36789, 38174);
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `minlevel` = 80, `maxlevel` = 80 WHERE `entry` IN (37006, 37986, 38107, 38548, 36659, 37690, 37562, 38159);
UPDATE `creature_template` SET `mechanic_immune_mask` = 634339327 WHERE `entry` IN (36855, 38106, 38296, 38297);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (37007, 38301);
UPDATE `creature_template` SET `spell1` = 70360, `spell2` = 70539, `spell3` = 70542, `VehicleId` = 591 WHERE `entry` = 37672;
UPDATE `creature_template` SET `spell1` = 72527, `spell2` = 72457, `spell3` = 70542, `VehicleId` = 591 WHERE `entry` = 38285;
UPDATE `creature_template` SET `dynamicflags` = 8, `npcflag` = 0, `unit_flags` = 32832 WHERE `entry` = 38995;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (36899, 38123);
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` IN (37985, 37799, 39284, 39285, 39286);
UPDATE `creature_template` SET `InhabitType` = 5,`flags_extra` = `flags_extra`|0x80 WHERE `entry` = 30298;
UPDATE `creature_template` SET `InhabitType` = 5,`minlevel` = 82,`maxlevel` = 82,`faction_A` = 14,`faction_H` = 14,`speed_walk` = 0.142857 WHERE `entry` IN (38454, 38775, 38776, 38777); -- Kinetic Bomb
UPDATE `creature_template` SET `minlevel` = 82,`maxlevel` = 82,`flags_extra` = `flags_extra`|0x80 WHERE `entry` = 38458; -- Kinetic Bomb Target
UPDATE `creature_template` SET `minlevel` = 82,`maxlevel` = 82,`exp` = 2,`flags_extra` = `flags_extra`|0x80 WHERE `entry` = 38422; -- Shock Vortex
UPDATE `creature_template` SET `minlevel` = 82,`maxlevel` = 82,`exp` = 2,`speed_walk` = 1.57143,`unit_flags` = 33554432,`flags_extra` = `flags_extra`|0x80 WHERE `entry` = 38332; -- Ball of Flame
UPDATE `creature_template` SET `minlevel` = 82,`maxlevel` = 82,`exp` = 2,`speed_walk` = 1.57143,`unit_flags` = 33554432,`flags_extra` = `flags_extra`|0x80 WHERE `entry` = 38451; -- Ball of Inferno Flame
UPDATE `creature_template` SET `unit_flags` = 536904000,`RegenHealth` = 0,`speed_run` = 1.428571,`speed_walk` = 1.6 WHERE `entry` IN (37970, 38401, 38784, 38785); -- Prince Valanar
UPDATE `creature_template` SET `unit_flags` = 536904000,`RegenHealth` = 0,`speed_run` = 1.428571,`speed_walk` = 1.6 WHERE `entry` IN (37972, 38399, 38769, 38770); -- Prince Keleseth
UPDATE `creature_template` SET `unit_flags` = 536904000,`RegenHealth` = 0,`speed_run` = 1.428571,`speed_walk` = 1.6 WHERE `entry` IN (37973, 38400, 38771, 38772); -- Prince Taldaram
UPDATE `creature_template` SET `RegenHealth` = 0 WHERE `entry` IN (38369, 38174);
UPDATE `creature_template` SET `dynamicflags` = 8 WHERE `entry` IN (37970, 38401, 38784, 38785);
UPDATE `creature_template` SET `vehicleId` = 531 WHERE `entry` IN (36609, 39120, 39121, 39122);
UPDATE `creature_template` SET `mechanic_immune_mask` = 667631615 WHERE `entry` IN (37533, 37534, 38219, 38220, 37217, 38103, 37025, 38064, 36880, 37655, 37126, 38258, 37007, 38031);
UPDATE `creature_template` SET `spell1` = 70360, `spell2` = 72457, `spell3` = 70542, `VehicleId` = 591 WHERE `entry` = 38788;
UPDATE `creature_template` SET `spell1` = 70360, `spell2` = 72875, `spell3` = 70542, `VehicleId` = 591 WHERE `entry` = 38789;
UPDATE `creature_template` SET `spell1` = 70360, `spell2` = 72876, `spell3` = 70542, `VehicleId` = 591 WHERE `entry` = 38790;
UPDATE `creature_template` SET `unit_flags` = 33555204, `flags_extra` = 128 WHERE `entry` IN (37986, 37824, 38234, 38317, 36659, 38548, 37186, 37006, 37918, 37690, 38068, 38163, 38584, 38752);
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` IN (37986, 38234, 38317, 36659, 38548, 37186);
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 38234;
UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 38569;

UPDATE `creature_model_info` SET `bounding_radius` = 5,`combat_reach` = 5 WHERE `modelid` = 31119;
UPDATE `creature_model_info` SET `bounding_radius` = 0.5425,`combat_reach` = 1.75 WHERE `modelid` IN (30856, 30857, 30858);
UPDATE `creature_model_info` SET `gender` = 1 WHERE `modelid` = 30362;

UPDATE `waypoint_scripts` SET `delay` = 3 WHERE `dataint` = 38879 AND `command` = 15;
DELETE FROM `spell_scripts` WHERE `id` = 72429 AND `command` = 15;
INSERT INTO `spell_scripts` VALUES
(72429, 0, 3, 15, 72423, 0, 0, 0, 0, 0, 0);

SET @LIGHT_S_HAMMER := 70781;
SET @ORATORY_OF_THE_DAMNED := 70856;
SET @RAMPART_OF_SKULLS := 70857;
SET @DEATHBRINGER_S_RISE := 70858;
SET @UPPER_SPIRE := 70859;
SET @SINDRAGOSA_S_LAIR := 70861;
SET @FROZEN_THRONE := 70860;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (@LIGHT_S_HAMMER,@ORATORY_OF_THE_DAMNED,@RAMPART_OF_SKULLS,@DEATHBRINGER_S_RISE,@UPPER_SPIRE,@SINDRAGOSA_S_LAIR,@FROZEN_THRONE);
DELETE FROM `spell_target_position` WHERE `id` IN (@LIGHT_S_HAMMER,@ORATORY_OF_THE_DAMNED,@RAMPART_OF_SKULLS,@DEATHBRINGER_S_RISE,@UPPER_SPIRE,@SINDRAGOSA_S_LAIR,@FROZEN_THRONE);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(@LIGHT_S_HAMMER, 631, -17.0711, 2211.47, 30.0546, 3.14159),
(@ORATORY_OF_THE_DAMNED, 631, -503.593, 2211.47, 62.7621, 3.14159),
(@RAMPART_OF_SKULLS, 631, -615.146, 2211.47, 199.909, 0.0),
(@DEATHBRINGER_S_RISE, 631, -549.073, 2211.29, 539.223, 0.0),
(@UPPER_SPIRE, 631, 4199.484, 2769.323, 351.3722, 3.124139),
(@SINDRAGOSA_S_LAIR, 631, 4356.580, 2565.75, 220.402, 4.71238),
(@FROZEN_THRONE, 631, 529.3969, -2124.66, 1041.37, 3.14159);

DELETE FROM `spell_proc_event` WHERE `entry` IN (
70602, 72178, 69762, 70107, 72176, 71604, 72833, 70904,
72832, 72455, 70672, 72408, 72256, 71971, 70001, 71494);
INSERT INTO `spell_proc_event` VALUES
(70107, 0x08, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000054, 0x00000000, 0, 20, 0),
(69762, 0x00, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00014000, 0x00000000, 0, 101, 0),
(72176, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00051154, 0x00000000, 0, 100, 0),
(70602, 0x20, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x000AAA20, 0x00000000, 0, 100, 0),
(71494, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 101, 0),
(72178, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00055510, 0x00000000, 0, 100, 0),
(71604, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(70001, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(71971, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(72256, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(72408, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(70672, 0x28, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000008, 0x00000000, 0, 100, 0),
(72455, 0x28, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000008, 0x00000000, 0, 100, 0),
(72832, 0x28, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000008, 0x00000000, 0, 100, 0),
(72833, 0x28, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000008, 0x00000000, 0, 100, 0),
(70904, 0x10, 0x06, 0x00000000, 0x00000000, 0x00000000, 0x00008000, 0x00000000, 0, 100, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` IN ( 
74361, 70541, 73779, 73780, 73781, 70337, 73912, 73913, 73914, 68981, 74270, 74271, 74272,
70534, 69110, 72262, 73159, 74506, 71598, 72743, 72429, 74115, 70501, 74325, 70498, 70500,
68980, 68576, 69030, 72133, 73789, 73788, 73790, 70766, 70873, 70964, 71941, 71899);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(74361,'spell_lich_king_valkyr_summon'),
(70541,'spell_lich_king_infection'),
(73779,'spell_lich_king_infection'),
(73780,'spell_lich_king_infection'),
(73781,'spell_lich_king_infection'),
(70337,'spell_lich_king_necrotic_plague'),
(73912,'spell_lich_king_necrotic_plague'),
(73913,'spell_lich_king_necrotic_plague'),
(73914,'spell_lich_king_necrotic_plague'),
(68981,'spell_lich_king_winter'),
(74270,'spell_lich_king_winter'),
(74271,'spell_lich_king_winter'),
(74272,'spell_lich_king_winter'),
(70534,'spell_vile_spirit_distance_check'),
(69110,'spell_ice_burst_distance_check'),
(72262,'spell_lich_king_quake'),
(73159,'spell_lich_king_play_movie'),
(74506,'spell_valkyr_carry_can_cast'),
(71598,'spell_creature_permanent_feign_death'),
(72743,'spell_lich_king_defile'),
(72429,'spell_lich_king_tirion_mass_resurrection'),
(74115,'spell_lich_king_pain_and_suffering'),
(70501,'spell_vile_spirit_target_search'),
(68576,'spell_valkyr_eject_passenger'),
(69030,'spell_valkyr_target_search'),
(72133,'spell_lich_king_pain_and_suffering_effect'),
(73789,'spell_lich_king_pain_and_suffering_effect'),
(73788,'spell_lich_king_pain_and_suffering_effect'),
(73790,'spell_lich_king_pain_and_suffering_effect'),
(70498,'spell_lich_king_vile_spirit_summon'),
(70500,'spell_lich_king_vile_spirit_summon_visual'),
(68980,'spell_lich_king_harvest_soul'),
(74325,'spell_lich_king_harvest_soul'),
(70766,'spell_dream_state'),
(70873,'spell_valithria_vigor'),
(70964,'spell_valithria_vigor'),
(71941,'spell_valithria_vigor'),
(71899,'spell_blood_queen_bloodbolt_whirl');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` IN (37868, 36791, 37863, 37886, 37934, 38068, 37698, 36701);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (37868, 36791, 37863, 37886, 37934, 38068, 37698, 36701);
INSERT INTO `creature_ai_scripts` VALUES
(85021059, 37868, 0, 0, 100, 7, 15000, 15000, 27000, 27000, 11, 71179, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Mana Void'),
(85021060, 37868, 0, 0, 100, 25, 15000, 15000, 27000, 27000, 11, 71741, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Mana Void'),
(85021061, 37868, 0, 0, 100, 3, 10000, 10000, 18000, 22000, 11, 70759, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Frostbolt Volley'),
(85021062, 37868, 0, 0, 100, 9, 10000, 10000, 18000, 22000, 11, 71889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Frostbolt Volley'),
(85021063, 37868, 0, 0, 100, 5, 10000, 10000, 18000, 22000, 11, 72015, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Frostbolt Volley'),
(85021064, 37868, 0, 0, 100, 17, 10000, 10000, 18000, 22000, 11, 72016, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Frostbolt Volley'),
(85021065, 37868, 0, 0, 100, 31, 18000, 18000, 28000, 28000, 11, 70602, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Risen Archmage - Cast Corruption'),
(85021066, 38068, 0, 0, 100, 30, 30000, 30000, 0, 0, 37, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,'Mana Void - Self Destruct'),
(80021007, 36791, 0, 0, 100, 7, 8000, 8000, 22000, 25000, 11, 69325, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Casts Lay Waste'),
(80021008, 36791, 0, 0, 100, 25, 8000, 8000, 22000, 25000, 11, 71730, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Casts Lay Waste'),
(80021009, 36791, 0, 0, 100, 6, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Stop Movement on Aggro'),
(80021010, 36791, 4, 0, 100, 6, 0, 0, 0, 0, 11, 70754, 1, 0, 22, 6, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Cast Fireball and Set Phase 1 on Aggro'),
(80021011, 36791, 3, 0, 100, 6, 15, 0, 0, 0, 21, 1, 0, 0, 22, 5, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Start Movement and Set Phase 2 when Mana is at 15%'),
(80021012, 36791, 0, 6, 100, 7, 0, 0, 1500, 3000, 11, 70754, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Cast Fireball above 15% Mana (Phase 1)'),
(80021013, 36791, 3, 5, 100, 6, 100, 28, 0, 0, 21, 0, 0, 0, 22, 6, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
(80021014, 36791, 9, 0, 100, 7, 30, 50, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Start Movement Beyond 30 Yards'),
(80021015, 36791, 7, 0, 100, 6, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - On Evade set Phase to 0'),
(80021016, 36791, 0, 0, 100, 24, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Stop Movement on Aggro'),
(80021017, 36791, 4, 0, 100, 24, 0, 0, 0, 0, 11, 71748, 1, 0, 22, 6, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Cast Fireball and Set Phase 1 on Aggro'),
(80021018, 36791, 3, 0, 100, 24, 15, 0, 0, 0, 21, 1, 0, 0, 22, 5, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Start Movement and Set Phase 2 when Mana is at 15%'),
(80021019, 36791, 0, 6, 100, 25, 0, 0, 1500, 3000, 11, 71748, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Cast Fireball above 15% Mana (Phase 1)'),
(80021020, 36791, 3, 5, 100, 24, 100, 28, 0, 0, 21, 0, 0, 0, 22, 6, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
(80021021, 36791, 9, 0, 100, 25, 30, 50, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - Start Movement Beyond 30 Yards'),
(80021022, 36791, 7, 0, 100, 24, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blazing Skeleton - On Evade set Phase to 0'),
(86021086, 37863, 4, 0, 100, 30, 0, 0, 0, 0, 11, 70588, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Suppresser - Cast Suppression'),
(82021033, 37886, 0, 0, 100, 7, 10000, 11000, 22000, 28000, 11, 70633, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Gluttonous Abomination - Casts Gut Spray'),
(82021034, 37886, 0, 0, 100, 25, 10000, 11000, 22000, 28000, 11, 71283, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Gluttonous Abomination - Casts Gut Spray'),
(82021035, 37886, 6, 0, 100, 30, 0, 0, 0, 0, 11, 70675, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,'Gluttonous Abomination - Casts on death Summon Rot Worm'),
(80021026, 37934, 2, 0, 100, 7, 10, 0, 12300, 14900, 11, 70744, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blistering Zombie - Casts Acid Burst at 10% HP'),
(80021027, 37934, 2, 0, 100, 25, 10, 0, 12300, 14900, 11, 71733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Blistering Zombie - Casts Acid Burst at 10% HP'),
(85021075, 37698, 2, 0, 100, 6, 25, 0, 0, 0, 11, 72143, 0, 0, 1, -106, 0, 0, 0, 0, 0, 0,'Shambling Horror - Casts Enrage at 25% HP'),
(85021076, 37698, 2, 0, 100, 24, 25, 0, 0, 0, 11, 72146, 0, 0, 1, -106, 0, 0, 0, 0, 0, 0,'Shambling Horror - Casts Enrage at 25% HP'),
(85021077, 37698, 0, 0, 100, 7, 7000, 9000, 15000, 17000, 11, 72149, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Shambling Horror - Casts Shockwave'),
(85021078, 37698, 0, 0, 100, 25, 7000, 9000, 15000, 17000, 11, 73794, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Shambling Horror - Casts Shockwave'),
(85021054, 36701, 0, 0, 100, 7, 10000, 10000, 25000, 35000, 11, 69242, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Raging Spirit - Cast Soul Shriek'),
(85021055, 36701, 0, 0, 100, 25, 10000, 10000, 25000, 35000, 11, 73800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Raging Spirit - Cast Soul Shriek');

DELETE FROM `conditions` WHERE `SourceEntry` IN (
72852, 72851, 72850, 71621, 72748, 72747, 72746, 72745, 72401, 71704, 72852, 72851, 72850,
71621, 72527, 70360, 69508, 70881, 70360, 36659, 70781, 70856, 70857, 70858, 70859, 70860,
70861, 69157, 71614, 70588, 74074, 69782, 69796, 69798, 69801, 69782, 69796, 69798, 69783,
69797, 69799, 69802, 69782, 69796, 69798, 69801, 70079, 69801, 71415, 71412, 71617, 71704);
DELETE FROM `conditions` WHERE `ConditionValue2` IN (SELECT `id` FROM `creature` WHERE `map` = 631);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (70572, 72202, 72260, 70952, 70982, 70981, 70983, 71070, 71081, 71080, 70598);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 21 AND `SourceGroup` IN (37672, 38285);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13, 0, 69157, 0, 18, 1, 36659, 0, 0,'','Festergut - Gaseous Blight'),
(13, 0, 69162, 0, 18, 1, 36659, 0, 0,'','Festergut - Gaseous Blight'),
(13, 0, 69164, 0, 18, 1, 36659, 0, 0,'','Festergut - Gaseous Blight'),
(13, 0, 71614, 0, 18, 1, 38995, 0, 0,'','LichKing - Ice Lock'),
(13, 0, 70588, 0, 18, 1, 36789, 0, 0,'','Valithria - Suppression'),
(13, 0, 70588, 0, 18, 1, 38174, 0, 0,'','Valithria - Suppression'),
(13, 0, 69125, 0, 18, 1, 37013, 0, 0,'',''),
(13, 0, 70360, 0, 18, 1, 37690, 0, 0,'','Mutated Abomination - Eat Ooze target'),
(13, 0, 72527, 0, 18, 1, 37690, 0, 0,'','Mutated Abomination - Eat Ooze target'),
(21, 37672, 71516, 0, 3, 49888, 0, 0, 0,'','Mutated Abomination - Unholy Infusion'),
(21, 38285, 71516, 0, 3, 49888, 0, 0, 0,'','Mutated Abomination - Unholy Infusion'),
(13, 0, 70952, 0, 18, 1, 37970, 0, 0,'','Valanar - Invocation of Blood'),
(13, 0, 70982, 0, 18, 1, 37973, 0, 0,'','Taldaram - Invocation of Blood'),
(13, 0, 70981, 0, 18, 1, 37972, 0, 0,'','Keleseth - Invocation of Blood'),
(13, 0, 70983, 0, 18, 1, 37970, 0, 0,'','Valanar - Invocation of Blood beam'),
(13, 0, 70983, 0, 18, 1, 37973, 0, 0,'','Taldaram - Invocation of Blood beam'),
(13, 0, 70983, 0, 18, 1, 37972, 0, 0,'','Keleseth - Invocation of Blood beam'),
(13, 0, 71070, 0, 18, 1, 37970, 0, 0,'','Valanar - Invocation of Blood visual'),
(13, 0, 71081, 0, 18, 1, 37973, 0, 0,'','Taldaram - Invocation of Blood visual'),
(13, 0, 71080, 0, 18, 1, 37972, 0, 0,'','Keleseth - Invocation of Blood visual'),
(13, 0, 74074, 0, 18, 1, 36597, 0, 0,'','The Lich King - Plague Siphon'),
(13, 0, 71621, 0, 18, 1, 38309, 1, 0,'','Putricide - Green Bottle'),
(13, 0, 72850, 0, 18, 1, 38309, 1, 0,'','Putricide - Green Bottle'),
(13, 0, 72851, 0, 18, 1, 38309, 1, 0,'','Putricide - Green Bottle'),
(13, 0, 72852, 0, 18, 1, 38309, 1, 0,'','Putricide - Green Bottle'),
(13, 0, 71704, 0, 18, 1, 38309, 1, 0,'','Putricide - Green Bottle'),
(13, 0, 72401, 0, 18, 1, 37672, 0, 0,'','Putricide - Mutated Abomination'),
(13, 0, 72401, 0, 18, 1, 38285, 0, 0,'','Putricide - Mutated Abomination'),
(13, 0, 72745, 0, 18, 1, 36678, 0, 0,'','Putricide - Mutated Plague'),
(13, 0, 72746, 0, 18, 1, 36678, 0, 0,'','Putricide - Mutated Plague'),
(13, 0, 72747, 0, 18, 1, 36678, 0, 0,'','Putricide - Mutated Plague'),
(13, 0, 72748, 0, 18, 1, 36678, 0, 0,'','Putricide - Mutated Plague'),
(13, 0, 71621, 0, 18, 1, 38308, 2, 0,'','Putricide - Orange Bottle'),
(13, 0, 72850, 0, 18, 1, 38308, 2, 0,'','Putricide - Orange Bottle'),
(13, 0, 72851, 0, 18, 1, 38308, 2, 0,'','Putricide - Orange Bottle'),
(13, 0, 72852, 0, 18, 1, 38308, 2, 0,'','Putricide - Orange Bottle'),
(13, 0, 71704, 0, 18, 1, 38308, 2, 0,'','Putricide - Orange Bottle'),
(13, 0, 71617, 0, 18, 1, 38317, 0, 0,'','Putricide - Tear Gas'),
(13, 0, 71412, 0, 18, 1, 37824, 0, 0,'','Putricide - Unstable Experiment'),
(13, 0, 71415, 0, 18, 1, 37824, 0, 0,'','Putricide - Unstable Experiment'),
(13, 0, 69783, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69797, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69799, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69802, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69782, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69796, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69798, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 69801, 0, 18, 1, 37013, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 70079, 0, 18, 1, 36678, 0, 0,'','Rotface - Ooze Flood'),
(13, 0, 70572, 0, 18, 1, 37920, 0, 0,'','Deathbringer Saurfang - Grip of Agony'),
(13, 0, 70572, 0, 18, 1, 37200, 0, 0,'','Deathbringer Saurfang - Grip of Agony'),
(13, 0, 70572, 0, 18, 1, 37187, 0, 0,'','Deathbringer Saurfang - Grip of Agony'),
(13, 0, 70572, 0, 18, 1, 37830, 0, 0,'','Deathbringer Saurfang - Grip of Agony'),
(13, 0, 72202, 0, 18, 1, 37813, 0, 0,'','Deathbringer Saurfang - Blood Link'),
(13, 0, 72260, 0, 18, 1, 37920, 0, 0,'','Deathbringer Saurfang - Mark of the Fallen Champion heal');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`Comment`) VALUES
(13, 70598, 18, 1,'Sindragosa''s Fury - player targets');

DELETE FROM `gameobject` WHERE `id` IN (202396, 202161);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(NULL, 202396, 631, 15, 1, 4309.686, 2491.27441, 211.170792, 0.209439442, 0, 0, 0, 0, 120, 0, 0),
(NULL, 202161, 631, 15, 1, 503.62, -2124.66, 1036.61, 3.14159, 7.7568, 0, 0, 0, 604800, 100, 1),
(NULL, 202161, 631, 15, 1, 495.708, -2523.75, 1045.95, 3.14159, 7.7568, 0, 0, 0, 604800, 100, 1);

UPDATE `gameobject_template` SET `ScriptName` = 'icecrown_citadel_teleport' WHERE `entry` IN (202223, 202235, 202242, 202243, 202244, 202245, 202246);
UPDATE `gameobject_template` SET `flags` = 0 WHERE `entry` IN (202235, 202242, 202243, 202244, 202245, 202246, 202223, 201741);
UPDATE `gameobject_template` SET `ScriptName` = '', `data10` = 70308 WHERE `entry` = 201584;
UPDATE `gameobject_template` SET `flags` = 33,`faction` = 114 WHERE `entry` IN (202396, 201722);
UPDATE `gameobject_template` SET `ScriptName` = 'go_icc_spirit_alarm' WHERE `entry` IN (201814, 201815, 201816, 201817);
UPDATE `gameobject` SET `phaseMask` = 1 WHERE `id` IN (202242, 202243, 202244, 202245, 202235, 202223, 202246);
UPDATE `gameobject` SET `phaseMask` = 17 WHERE `id` IN (201375, 201374);
UPDATE `gameobject` SET `state` = 0 WHERE `id` IN (201375, 201613, 201614);
UPDATE `gameobject_template` SET `flags` = 32 WHERE `entry` = 202161;

-- Conditions
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (70117, 70157);
DELETE FROM `spell_linked_spell` WHERE `spell_effect` IN (72202, 69166, 70347, 72380, 69706, 70702, 70311, 69291, 70338, 72846, 69201, 74074);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(70117, 70122, 1,'Sindragosa - Icy Grip'),
(70157, 69700, 2,'Sindragosa - Ice Tomb resistance'),
(70360, 70347, 0,'Eat Ooze'),
(72379, 72380, 0,'Blood Nova'),
(72380, 72202, 0,'Blood Nova 10N'),
(72438, 72202, 0,'Blood Nova 25N'),
(72439, 72202, 0,'Blood Nova 10H'),
(72440, 72202, 0,'Blood Nova 25H'),
(72409, 72202, 0,'Rune of Blood 25N'),
(72447, 72202, 0,'Rune of Blood 10H'),
(72448, 72202, 0,'Rune of Blood 25H'),
(72449, 72202, 0,'Rune of Blood 25H'),
(69195, 69166, 0,'Pungent Blight 10N'),
(71279, 69166, 0,'Pungent Blight 25N'),
(73031, 69166, 0,'Pungent Blight 10H'),
(73032, 69166, 0,'Pungent Blight 25H'),
(70715, 70702, 0,'?'),
(-69674, 69706, 0,'Rotface: Mutated Infection Summon'),
(-71224, 69706, 0,'Rotface: Mutated Infection Summon'),
(-73022, 69706, 0,'Rotface: Mutated Infection Summon'),
(-73023, 69706, 0,'Rotface: Mutated Infection Summon'),
(-70337, 70338, 0,'The Lich King: Necrotic plague initial cast'),
(-70337, 72846, 0,'The Lich King: Necrotic plague immun'),
(-70338, 70338, 0,'The Lich King: Necrotic jump'),
(-69200, 69201, 0,'The Lich King: Raging Spirit'),
(-70338, 74074, 0,'The Lich King: Plague Siphon');

-- Npc spell click spell
DELETE FROM `npc_spellclick_spells` WHERE npc_entry IN (37945, 38430);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) VALUES
(37945, 70766, 0, 0, 0, 3, 0, 0, 0),
(38430, 70766, 0, 0, 0, 3, 0, 0, 0);

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN ( 
12825, 12818, 12764, 12909, 12826, 12822, 12996, 12972, 12989,
12758, 12955, 13049, 13060, 13102, 13133, 13134, 13135 );
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12825, 12, 2, 0,''),
(12818, 12, 3, 0,''),
(12764, 12, 0, 0,''),
(12909, 12, 1, 0,''),
(12826, 12, 3, 0,''),
(12822, 11, 0, 0,'achievement_all_you_can_eat'), -- All You Can Eat (10 player)
(12822, 12, 0, 0,''), -- All You Can Eat (10 player)
(12996, 11, 0, 0,'achievement_all_you_can_eat'), -- All You Can Eat (10 player) Heroic
(12996, 12, 2, 0,''), -- All You Can Eat (10 player) Heroic
(12972, 11, 0, 0,'achievement_all_you_can_eat'), -- All You Can Eat (25 player)
(12972, 12, 1, 0,''), -- All You Can Eat (25 player)
(12989, 11, 0, 0,'achievement_all_you_can_eat'), -- All You Can Eat (25 player) Heroic
(12989, 12, 3, 0,''), -- All You Can Eat (25 player) Heroic
(12758, 12, 0, 0,''), -- The Frostwing Halls (10 player) Sindragosa
(12955, 12, 1, 0,''), -- The Frostwing Halls (25 player) Sindragosa
(13049, 12, 2, 0,''), -- Heroic: The Frostwing Halls (10 player) Sindragosa
(13060, 12, 3, 0,''), -- Heroic: The Frostwing Halls (25 player) Sindragosa
(13102, 12, 0, 0,''), -- Sindragosa kills (Icecrown 10 player)
(13133, 12, 1, 0,''), -- Sindragosa kills (Icecrown 25 player)
(13134, 12, 2, 0,''), -- Sindragosa kills (Heroic Icecrown 10 player)
(13135, 12, 3, 0,''); -- Sindragosa kills (Heroic Icecrown 25 player)

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 19753 AND `spell_effect` IN
(-70923, -70924, -73015, -70867, -70871, -70879, -70949, -70950, -71473, -71525, -71530, -71531, -71532, -71533);
INSERT INTO `spell_linked_spell` VALUES
(19753, -70923, 1,''),
(19753, -70924, 1,''),
(19753, -73015, 1,''),
(19753, -70867, 1,''),
(19753, -70871, 1,''),
(19753, -70879, 1,''),
(19753, -70949, 1,''),
(19753, -70950, 1,''),
(19753, -71473, 1,''),
(19753, -71525, 1,''),
(19753, -71530, 1,''),
(19753, -71531, 1,''),
(19753, -71532, 1,''),
(19753, -71533, 1,'');

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (21146, 21147, 21148, 21149);
DELETE FROM `item_loot_template` WHERE `entry` = 21271;
INSERT INTO `item_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(21271, 21241, 100, 1, 0, 5, 5);

DELETE FROM `creature_template` WHERE `entry` IN (
36791, 37863, 37868, 37886, 37907, 37918, 37934, 37945, 37950, 37985, 38068, 38186, 38421, 38429, 38430, 38752, 36789);
INSERT INTO `creature_template` VALUES 
(36791, 38169, 38721, 38722, 0, 38121, 22773, 0, 0, 0,'Blazing Skeleton','','', 0, 83, 83, 2, 16, 16, 0, 1.5, 1.14286, 1, 1, 435, 653, 0, 163, 50.8, 2000, 2000, 2, 0, 8, 0, 0, 0, 0, 0, 348, 522, 130, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70754, 69325, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'EventAI', 0, 3, 6, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_icc_valithria_blazing_skeleton', 12340),
(37863, 38171, 38727, 38737, 0, 38121, 25592, 0, 0, 0,'Suppresser','','', 0, 80, 80, 2, 16, 16, 0, 1, 0.992063, 1, 1, 420, 630, 0, 157, 10, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 336, 504, 126, 6, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_icc_valithria_supressor', 12340),
(37868, 38167, 38725, 38735, 0, 38121, 7919, 0, 0, 0,'Risen Archmage','','', 0, 81, 81, 2, 16, 16, 0, 1, 1.14286, 1, 1, 405, 609, 0, 152, 21.5, 2000, 2000, 2, 0, 8, 0, 0, 0, 0, 0, 324, 487, 122, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 8, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_icc_valithria_risen_archmage', 12340),
(37886, 38166, 38724, 38734, 0, 38121, 7858, 0, 0, 0,'Gluttonous Abomination','','', 0, 83, 83, 2, 16, 16, 0, 1, 1.14286, 1, 1, 468, 702, 0, 175, 47.2, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 374, 562, 140, 6, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70633, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_icc_valithria_gluttonous_abomination', 12340),
(37907, 38168, 38726, 38736, 0, 0, 12346, 0, 0, 0,'Rot Worm','','', 0, 80, 80, 2, 16, 16, 0, 1.8, 1.14286, 1, 1, 420, 630, 0, 157, 10, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 336, 504, 126, 10, 2080, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,'npc_icc_valithria_rot_worm', 12340),
(37918, 0, 0, 0, 0, 0, 169, 11686, 0, 0,'Column of Frost','','', 0, 1, 1, 2, 14, 14, 0, 1, 1.14286, 1, 0, 1, 2, 0, 0, 1, 2000, 2000, 1, 33555204, 8, 0, 0, 0, 0, 0, 1, 2, 0, 10, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128,'npc_column_of_frost_icc', 12340),
(37934, 38170, 38723, 38733, 0, 38121, 22124, 0, 0, 0,'Blistering Zombie','','', 0, 80, 80, 2, 16, 16, 0, 2, 0.714286, 1, 1, 420, 630, 0, 157, 10, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 336, 504, 126, 6, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 94, 1, 0, 8388624, 0,'npc_icc_valithria_blistering_zombie', 12340),
(37945, 0, 0, 0, 0, 0, 30844, 0, 0, 0,'Dream Portal','','vehichleCursor', 0, 80, 80, 2, 35, 35, 16777216, 1, 1.14286, 1, 1, 420, 630, 0, 157, 10, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 336, 504, 126, 6, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 5, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_dreamportal_icc', 12340),
(37950, 0, 0, 0, 0, 0, 30318, 0, 0, 0,'Valithria Dreamwalker','','', 0, 82, 82, 2, 35, 35, 0, 1, 1.14286, 1, 3, 1, 1, 0, 1, 2, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 1, 1, 1, 2, 4108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 10000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 12584976, 0,'npc_valithria_alternative', 12340),
(37985, 0, 0, 0, 0, 0, 169, 30877, 0, 0,'Dream Cloud','','', 0, 1, 1, 2, 14, 14, 0, 1, 1.14286, 1, 0, 1, 2, 0, 0, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 1, 2, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 1, 7, 0.007937, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128,'npc_dreamcloud_icc', 12340),
(38068, 0, 0, 0, 0, 0, 169, 11686, 0, 0,'Mana Void','','', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 0.7, 2000, 2000, 1, 33555204, 8, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'EventAI', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128,'npc_icc_valithria_mana_void', 12340),
(38186, 0, 0, 0, 0, 0, 30844, 0, 0, 0,'Dream Portal (Pre-effect)','','vehichleCursor', 0, 1, 1, 2, 35, 35, 0, 1, 1.14286, 1, 1, 1, 1, 0, 1, 2, 2000, 2000, 1, 33554432, 8, 0, 0, 0, 0, 0, 1, 1, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_dreamportal_icc', 12340),
(38421, 0, 0, 0, 0, 0, 169, 31088, 0, 0,'Nightmare Cloud','','', 0, 81, 81, 2, 14, 14, 0, 1, 1.14286, 1, 0, 436, 654, 0, 163, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 349, 523, 130, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 7, 0.007937, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128,'npc_dreamcloud_icc', 12340),
(38429, 0, 0, 0, 0, 0, 30844, 0, 0, 0,'Nightmare Portal (Pre-effect)','','vehichleCursor', 0, 81, 81, 2, 35, 35, 0, 1, 1.14286, 1, 1, 436, 654, 0, 163, 2, 2000, 2000, 1, 33554432, 8, 0, 0, 0, 0, 0, 349, 523, 130, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_dreamportal_icc', 12340),
(38430, 0, 0, 0, 0, 0, 30844, 0, 0, 0,'Nightmare Portal','','vehichleCursor', 0, 80, 80, 2, 35, 35, 16777216, 1, 1.14286, 1, 1, 420, 630, 0, 157, 2, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 336, 504, 126, 6, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 5, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0,'npc_dreamportal_icc', 12340),
(38752, 0, 0, 0, 0, 0, 26623, 0, 0, 0,'Green Dragon Combat Trigger','','', 0, 80, 80, 2, 16, 16, 0, 1, 1.14286, 1, 1, 1, 2, 0, 1, 1, 2000, 2000, 1, 32832, 8, 0, 0, 0, 0, 0, 1, 2, 126, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 358, 803160063, 0,'npc_icc_combat_stalker', 12340),
(36789, 38174, 0, 0, 0, 0, 30318, 0, 0, 0,'Valithria Dreamwalker','','', 0, 83, 83, 2, 35, 35, 0, 1.8, 1.14286, 1, 3, 468, 702, 0, 175, 47.2, 2000, 2000, 1, 536870912, 8, 0, 0, 0, 0, 0, 374, 562, 140, 2, 67113036, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70904, 71196, 71189, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 860.524, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 801849343, 1,'boss_valithria', 12340);
 
UPDATE `creature_template` SET `ScriptName` = 'svalna_temp' WHERE `entry` = 37126;

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1666070 AND -1666063;
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0, -1666063,'Heroes, lend me your aid! I... I cannot hold them off much longer! You must heal my wounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17064, 1, 0, 0,''),
(0, -1666064,'I have opened a portal into the Emerald Dream. Your salvation lies within, heroes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 0, 1, 0, 0,''),
(0, -1666065,'My strength is returning! Press on, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17070, 1, 0, 0,''),
(0, -1666066,'I will not last much longer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17069, 1, 0, 0,''),
(0, -1666067,'Forgive me for what I do! I... cannot... stop... ONLY NIGHTMARES REMAIN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17072, 1, 0, 0,''),
(0, -1666068,'A tragic loss...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17066, 1, 0, 0,''),
(0, -1666069,'FAILURES!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17067, 1, 0, 0,''),
(0, -1666070,'I am renewed! Ysera grants me the favor to lay these foul creatures to rest!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17071, 1, 0, 0,'');

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1810031 AND -1810001;
INSERT INTO `script_texts` (entry,content_default,content_loc1,content_loc2,content_loc3,content_loc4,content_loc5,content_loc6,content_loc7,content_loc8,sound,type,LANGUAGE,emote,comment)VALUES
(-1810001,'So...the Light\'s vaunted justice has finally arrived. Shall I lay down Frostmourne and throw myself at your mercy, Fordring?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17349, 1, 0, 0,''),
(-1810002,'We will grant you a swift death, Arthas. More than can be said for the thousands you\'ve tortured and slain.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17390, 1, 0, 0,''),
(-1810003,'You will learn of that first hand. When my work is complete, you will beg for mercy -- and I will deny you. Your anguished cries will be testament to my unbridled power.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17350, 1, 0, 0,''),
(-1810004,'So be it. Champions, attack!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17391, 1, 0, 0,''),
(-1810005,'I\'ll keep you alive to witness the end, Fordring. I would not want the Light\'s greatest champion to miss seeing this wretched world remade in my image.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17351, 1, 0, 0,''),
(-1810006,'Come then champions, feed me your rage!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17352, 1, 0, 0,''),
(-1810007,'I will freeze you from within until all that remains is an icy husk!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17369, 1, 0, 0,''),
(-1810008,'Apocalypse!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17371, 1, 0, 0,''),
(-1810009,'Bow down before your lord and master!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17372, 1, 0, 0,''),
(-1810010,'Hope wanes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17363, 1, 0, 0,''),
(-1810011,'The end has come!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17364, 1, 0, 0,''),
(-1810012,'Face now your tragic end!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17365, 1, 0, 0,''),
(-1810013,'No question remains unanswered. No doubts linger. You are Azeroth\'s greatest champions! You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught, your unbridled fury... Is it truly righteousness that drives you? I wonder.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17353, 1, 0, 0,''),
(-1810014,'You trained them well, Fordring. You delivered the greatest fighting force this world has ever known... right into my hands exactly as I intended. You shall be rewarded for your unwitting sacrifice.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17355, 1, 0, 0,''),
(-1810015,'Watch now as I raise them from the dead to become masters of the Scourge. They will shroud this world in chaos and destruction. Azeroth\'s fall will come at their hands -- and you will be the first to die.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17356, 1, 0, 0,''),
(-1810016,'I delight in the irony.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17357, 1, 0, 0,''),
(-1810017,'LIGHT, GRANT ME ONE FINAL BLESSING. GIVE ME THE STRENGTH... TO SHATTER THESE BONDS!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17392, 1, 0, 0,''),
(-1810018,'Impossible...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17358, 1, 0, 0,''),
(-1810019,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17360, 1, 0, 0,''),
(-1810020,'No more, Arthas! No more lives will be consumed by your hatred!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17393, 1, 0, 0,''),
(-1810021,'Free at last! It is over, my son. This is the moment of reckoning.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17397, 1, 0, 0,''),
(-1810022,'The Lich King must fall!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17389, 1, 0, 0,''),
(-1810023,'Rise up, champions of the Light!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17398, 1, 0, 0,''),
(-1810024,'Now I stand, the lion before the lambs... and they do not fear.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17361, 1, 0, 0,''),
(-1810025,'They cannot fear.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17362, 1, 0, 0,''),
(-1810026,'Argh... Frostmourne, obey me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17367, 1, 0, 0,''),
(-1810027,'Frostmourne hungers...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17366, 1, 0, 0,''),
(-1810028,'Frostmourne feeds on the soul of your fallen ally!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17368, 1, 0, 0,''),
(-1810029,'Val\'kyr, your master calls!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17373, 1, 0, 0,''),
(-1810030,'Watch as the world around you collapses!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17370, 1, 0, 0,''),
(-1810031,'You gnats actually hurt me! Perhaps I\'ve toyed with you long enough, now taste the vengeance of the grave!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 17359, 1, 0, 0,'');

-- Quest: Shadowmourne Questline
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (72934, 72928);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13, 0, 72934, 0, 18, 1, 0, 0, 0,'','Blood-Queen - Blood Infusion Quest Credit'),
(13, 0, 72928, 0, 18, 1, 0, 0, 0,'','Deathbringer Saurfang - achievement');
UPDATE `quest_template` SET `PrevQuestId` = 24749 WHERE `entry` = 24756;
-- -------------------------------------------------------------------------}
-- ----------------------------- Pit of Saron ------------------------------
-- -------------------------------------------------------------------------{
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (36794);
DELETE FROM `script_texts` WHERE `entry` IN (-1658074, -1658075, -1658076, -1658077, -1658078, -1658080, -1658081, -1658082, -1658084, -1658085, -1658086, -1658087, -1658088);
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES 
(0, -1658074,'Intruders have entered the masters domain. Signal the alarms!', 16747, 1, 0, 0,'Tyrannus Opening'),
(0, -1658075,'Hmph fodder Not even fit to labor in the quarry. Relish these final moments for soon you will be nothing more than mindless undead', 16748, 1, 0, 0,'Tyrannus Opening'),
(0, -1658076,'Soldiers of the Horde, attack!', 17045, 1, 0, 0,'Sylvanas Opening'),
(0, -1658077,'Heroes of the Alliance, attack!', 16626, 1, 0, 0,'Jaina Opening'),
(0, -1658078,'Your last waking memory will be of agonizing pain', 16749, 1, 0, 0,'Tyrannus Opening'),
(0, -1658080,'Pathetic weaklings', 17046, 1, 0, 0,'Sylvanas Opening'),
(0, -1658081,'NO! YOU MONSTER!', 16627, 1, 0, 0,'Jaina Opening'),
(0, -1658082,'Minions, destroy these interlopers!', 16751, 1, 0, 0,'Tyrannus Opening'),
(0, -1658084,'I do what i must. Please forgive me noble soldiers', 16628, 1, 0, 0,'Jaina Opening'),
(0, -1658085,'You will have to battle your way through this cesspit on your own.', 17047, 0, 0, 0,'Sylvanas Opening'),
(0, -1658086,'You will have to make your way across this quarry on your own.', 16629, 0, 0, 0,'Jaina Opening'),
(0, -1658087,'Free any horde slaves that you come across. We will most certainly need there assistance in battling Tyrannus. I will gather reinforcements and join you on the other side of the quarry.', 17048, 0, 0, 0,'Sylvanas Opening'),
(0, -1658088,'Free any Alliance slaves that you come across. We will most certainly need there assistance in battling Tyrannus. I will gather reinforcements and join you on the other side of the quarry.', 16630, 0, 0, 0,'Jaina Opening');
UPDATE `creature_template` SET `ScriptName` = "npc_jaina_or_sylvanas_intro" WHERE `entry` IN (36990, 36993);
UPDATE `creature_template` SET `ScriptName` = "npc_jaina_or_sylvanas_outro" WHERE `entry` IN (38189, 38188);
DELETE FROM `creature` WHERE `id` = 38189;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(38189, 658, 1, 64, 0, 1290, 1071.58, 89.0826, 631.493, 1.93394, 300, 0, 0, 6972500, 85160, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `ScriptName` = "npc_tyrannus_icicle" WHERE `entry` IN (32780);
-- -------------------------------------------------------------------------}
-- -------------------------- Halls Of Reflection --------------------------
-- -------------------------------------------------------------------------{
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_jaina_and_sylvana_HRintro' WHERE `entry` IN (37221, 37223);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_falric' WHERE `entry` = 38112;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_marwyn' WHERE `entry` = 38113;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_lich_king_hr' WHERE `entry` = 36954;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_lich_king_hor' WHERE `entry` = 37226;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_jaina_and_sylvana_HRextro' WHERE `entry` IN (36955, 37554);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_raging_gnoul' WHERE `entry` = 36940;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_risen_witch_doctor' WHERE `entry` = 36941;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_abon' WHERE `entry` = 37069;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_frostworn_general' WHERE `entry` = 36723;
UPDATE `instance_template` SET `script` = 'instance_halls_of_reflection' WHERE `map` = 668;
UPDATE `creature_template` SET `scale` = 0.8, `equipment_id` = 1221 WHERE `entry` IN (37221, 36955);
UPDATE `creature_template` SET `speed_walk` = 1.5, `speed_run` = 2.0 WHERE `entry` IN (36954, 37226);
UPDATE `creature_template` SET `equipment_id` = 1290 WHERE `entry` IN (37223, 37554);
UPDATE `creature_template` SET `equipment_id` = 0 WHERE `entry` = 36954;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 37223;
UPDATE `creature_template` SET `scale` = 0.8 WHERE `entry` IN (36658, 37225, 37223, 37226, 37554);
UPDATE `creature_template` SET `unit_flags` = 768, `type_flags` = 268435564 WHERE `entry` IN (38177, 38176, 38173, 38172, 38567, 38175);
UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` =  37014;
UPDATE `gameobject_template` SET `faction` = 1375 WHERE `entry` IN (197341, 202302, 201385, 201596);
UPDATE `creature` SET `phaseMask` = 128 WHERE `id` = 36993;
UPDATE `creature` SET `phaseMask` = 64 WHERE `id` = 36990;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc6`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(-1594473,'Foolish girl. You seek that, which I killed long ago. He is nearly a ghost now. A fate ago in my mind.', NULL, 17229, 1, 0, 0, 67234),
(-1594474,'I will not make the same mistake again. This time there will be no escape. You fail to serve me in undead. Now, all that remains for you is oblivion!', NULL, 17228, 1, 0, 0, 67234),
-- SCENE - Hall Of Reflection (Extro) - PreEscape
(-1594477,'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.', NULL, 17212, 1, 0, 0, 67234),
(-1594478,'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', NULL, 17213, 1, 0, 0, 67234),
(-1594479,'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!', NULL, 16644, 0, 0, 1, 67234),
(-1594480,'He\'s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.', NULL, 17058, 0, 0, 1, 67234),
-- SCENE - Hall Of Reflection (Extro) - Escape
(-1594481,'Death\'s cold embrace awaits.', NULL, 17221, 1, 0, 0, 67234),
(-1594482,'Rise minions, do not left them us!', NULL, 17216, 1, 0, 0, 67234),
(-1594483,'Minions sees them. Bring their corpses back to me!', NULL, 17222, 1, 0, 0, 67234),
(-1594484,'No...', NULL, 17214, 1, 0, 0, 67234),
(-1594485,'All is lost!', NULL, 17215, 1, 0, 0, 67234),
(-1594486,'There is no escape!', NULL, 17217, 1, 0, 0, 67234),
(-1594487,'I will destroy this barrier. You must hold the undead back!', NULL, 16607, 1, 0, 0, 67234),
(-1594488,'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!', NULL, 17029, 1, 0, 0, 67234),
(-1594489,'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!', NULL, 16608, 1, 0, 0, 67234),
(-1594490,'Another barrier? Stand strong, champions! I will bring the wall down!', NULL, 17030, 1, 0, 0, 67234),
(-1594491,'Succumb to the chill of the grave.', NULL, 17218, 1, 0, 0, 67234),
(-1594492,'Another dead end.', NULL, 17219, 1, 0, 0, 67234),
(-1594493,'How long can you fight it?', NULL, 17220, 1, 0, 0, 67234),
(-1594494,'<need translate>', NULL, 16609, 0, 0, 0, 67234),
(-1594495,'Your barriers can\'t hold us back much longer, monster. I will shatter them all!', NULL, 16610, 1, 0, 0, 67234),
(-1594496,'I grow tired of these games, Arthas! Your walls can\'t stop me!', NULL, 17031, 1, 0, 0, 67234),
(-1594497,'You won\'t impede our escape, fiend. Keep the undead off me while I bring this barrier down!', NULL, 17032, 1, 0, 0, 67234),
(-1594498,'There\'s an opening up ahead. GO NOW!', NULL, 16645, 1, 0, 0, 67234),
(-1594499,'We\'re almost there... Don\'t give up!', NULL, 16646, 1, 0, 0, 67234),
(-1594500,'There\'s an opening up ahead. GO NOW!', NULL, 17059, 1, 0, 0, 67234),
(-1594501,'We\'re almost there! Don\'t give up!', NULL, 17060, 1, 0, 0, 67234),
(-1594502,'It... It\'s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!', NULL, 16647, 1, 0, 0, 67234),
(-1594503,'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!', NULL, 17061, 1, 0, 0, 67234),
(-1594504,'Nowhere to run! You\'re mine now...', NULL, 17223, 1, 0, 0, 67234),
(-1594505,'Soldiers of Lordaeron, rise to meet your master\'s call!', NULL, 16714, 1, 0, 0, 67234),
(-1594506,'The master surveyed his kingdom and found it... lacking. His judgement was swift and without mercy. Death to all!', NULL, 16738, 1, 0, 0, 67234),
-- FrostWorn General
(-1594519,'You are not worthy to face the Lich King!', NULL, 16921, 1, 0, 0, 67234),
(-1594520,'Master, I have failed...', NULL, 16922, 1, 0, 0, 67234);

DELETE FROM script_waypoint WHERE `entry` IN (36955, 37226, 37554);
INSERT INTO script_waypoint VALUES
-- Jaina
(36955, 0, 5587.682, 2228.586, 733.011, 0,'WP1'),
(36955, 1, 5600.715, 2209.058, 731.618, 0,'WP2'),
(36955, 2, 5606.417, 2193.029, 731.129, 0,'WP3'),
(36955, 3, 5598.562, 2167.806, 730.918, 0,'WP4 - Summon IceWall 01'),
(36955, 4, 5556.436, 2099.827, 731.827, 0,'WP5 - Spell Channel'),
(36955, 5, 5543.498, 2071.234, 731.702, 0,'WP6'),
(36955, 6, 5528.969, 2036.121, 731.407, 0,'WP7'),
(36955, 7, 5512.045, 1996.702, 735.122, 0,'WP8'),
(36955, 8, 5504.490, 1988.789, 735.886, 0,'WP9 - Spell Channel'),
(36955, 9, 5489.645, 1966.389, 737.653, 0,'WP10'),
(36955, 10, 5475.517, 1943.176, 741.146, 0,'WP11'),
(36955, 11, 5466.930, 1926.049, 743.536, 0,'WP12'),
(36955, 12, 5445.157, 1894.955, 748.757, 0,'WP13 - Spell Channel'),
(36955, 13, 5425.907, 1869.708, 753.237, 0,'WP14'),
(36955, 14, 5405.118, 1833.937, 757.486, 0,'WP15'),
(36955, 15, 5370.324, 1799.375, 761.007, 0,'WP16'),
(36955, 16, 5335.422, 1766.951, 767.635, 0,'WP17 - Spell Channel'),
(36955, 17, 5311.438, 1739.390, 774.165, 0,'WP18'),
(36955, 18, 5283.589, 1703.755, 784.176, 0,'WP19'),
(36955, 19, 5260.400, 1677.775, 784.301, 3000,'WP20'),
(36955, 20, 5262.439, 1680.410, 784.294, 0,'WP21'),
(36955, 21, 5260.400, 1677.775, 784.301, 0,'WP22'),
-- Sylvana
(37554, 0, 5587.682, 2228.586, 733.011, 0,'WP1'),
(37554, 1, 5600.715, 2209.058, 731.618, 0,'WP2'),
(37554, 2, 5606.417, 2193.029, 731.129, 0,'WP3'),
(37554, 3, 5598.562, 2167.806, 730.918, 0,'WP4 - Summon IceWall 01'),
(37554, 4, 5556.436, 2099.827, 731.827, 0,'WP5 - Spell Channel'),
(37554, 5, 5543.498, 2071.234, 731.702, 0,'WP6'),
(37554, 6, 5528.969, 2036.121, 731.407, 0,'WP7'),
(37554, 7, 5512.045, 1996.702, 735.122, 0,'WP8'),
(37554, 8, 5504.490, 1988.789, 735.886, 0,'WP9 - Spell Channel'),
(37554, 9, 5489.645, 1966.389, 737.653, 0,'WP10'),
(37554, 10, 5475.517, 1943.176, 741.146, 0,'WP11'),
(37554, 11, 5466.930, 1926.049, 743.536, 0,'WP12'),
(37554, 12, 5445.157, 1894.955, 748.757, 0,'WP13 - Spell Channel'),
(37554, 13, 5425.907, 1869.708, 753.237, 0,'WP14'),
(37554, 14, 5405.118, 1833.937, 757.486, 0,'WP15'),
(37554, 15, 5370.324, 1799.375, 761.007, 0,'WP16'),
(37554, 16, 5335.422, 1766.951, 767.635, 0,'WP17 - Spell Channel'),
(37554, 17, 5311.438, 1739.390, 774.165, 0,'WP18'),
(37554, 18, 5283.589, 1703.755, 784.176, 0,'WP19'),
(37554, 19, 5260.400, 1677.775, 784.301, 3000,'WP20'),
(37554, 20, 5262.439, 1680.410, 784.294, 0,'WP21'),
(37554, 21, 5260.400, 1677.775, 784.301, 0,'WP22'),
-- Lich King
(37226, 0, 5577.187, 2236.003, 733.012, 0,'WP1'),
(37226, 1, 5587.682, 2228.586, 733.011, 0,'WP2'),
(37226, 2, 5600.715, 2209.058, 731.618, 0,'WP3'),
(37226, 3, 5606.417, 2193.029, 731.129, 0,'WP4'),
(37226, 4, 5598.562, 2167.806, 730.918, 0,'WP5'),
(37226, 5, 5559.218, 2106.802, 731.229, 0,'WP6'),
(37226, 6, 5543.498, 2071.234, 731.702, 0,'WP7'),
(37226, 7, 5528.969, 2036.121, 731.407, 0,'WP8'),
(37226, 8, 5512.045, 1996.702, 735.122, 0,'WP9'),
(37226, 9, 5504.490, 1988.789, 735.886, 0,'WP10'),
(37226, 10, 5489.645, 1966.389, 737.653, 0,'WP10'),
(37226, 11, 5475.517, 1943.176, 741.146, 0,'WP11'),
(37226, 12, 5466.930, 1926.049, 743.536, 0,'WP12'),
(37226, 13, 5445.157, 1894.955, 748.757, 0,'WP13'),
(37226, 14, 5425.907, 1869.708, 753.237, 0,'WP14'),
(37226, 15, 5405.118, 1833.937, 757.486, 0,'WP15'),
(37226, 16, 5370.324, 1799.375, 761.007, 0,'WP16'),
(37226, 17, 5335.422, 1766.951, 767.635, 0,'WP17'),
(37226, 18, 5311.438, 1739.390, 774.165, 0,'WP18'),
(37226, 19, 5283.589, 1703.755, 784.176, 0,'WP19'),
(37226, 20, 5278.694, 1697.912, 785.692, 0,'WP20'),
(37226, 21, 5283.589, 1703.755, 784.176, 0,'WP19');

DELETE FROM `gameobject_template` WHERE `entry` = 500001;
INSERT INTO `gameobject_template` VALUES (500001, 0, 9214,'Ice Wall','','','', 1375, 0, 2.5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'','', 1);
DELETE FROM `creature` WHERE `id` IN (38112, 37223, 37221, 36723, 36955, 37158, 38113, 37554, 37226) AND `map` = 668;
INSERT INTO `creature` (`guid`, `id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
-- Falric & Marwyn
(135341, 38112, 668, 3, 1, 0, 0, 5276.81, 2037.45, 709.32, 5.58779, 604800, 0, 0, 377468, 0, 0, 0, 0, 0, 0),
(135342, 38113, 668, 3, 1, 0, 0, 5341.72, 1975.74, 709.32, 2.40694, 604800, 0, 0, 539240, 0, 0, 0, 0, 0, 0),
-- Lady Jaina Proudmoore & Lady Sylvanas Windrunner <Banshee Queen>
(117106, 37221, 668, 3, 128, 0, 0, 5266.78, 1953.42, 707.697, 0.740877, 7200, 0, 0, 5040000, 881400, 0, 0, 0, 0, 0),
(117460, 37223, 668, 3, 64, 0, 0, 5266.78, 1953.42, 707.697, 0.740877, 7200, 0, 0, 6972500, 85160, 0, 0, 0, 0, 0),
-- Frostsworn General
(135343, 36723, 668, 3, 1, 0, 0, 5413.84, 2116.44, 707.695, 3.88117, 7200, 0, 0, 315000, 0, 0, 0, 0, 0, 0),
-- Quel'Delar
(78183, 37158, 668, 3, 2, 0, 0, 5304.5, 2001.35, 709.341, 4.15073, 7200, 0, 0, 214200, 0, 0, 0, 0, 0, 0),
-- Lady Jaina Proudmoore & Lady Sylvanas Windrunner    (final way)
(NULL, 36955, 668, 3, 128, 0, 0, 5547.27, 2256.95, 733.011, 0.835987, 7200, 0, 0, 252000, 881400, 0, 0, 0, 0, 0),
(NULL, 37554, 668, 3, 64, 0, 0, 5547.27, 2256.95, 733.011, 0.835987, 7200, 0, 0, 252000, 881400, 0, 0, 0, 0, 0),
-- The Lich King
(NULL, 37226, 668, 3, 1, 0, 0, 5551.29, 2261.33, 733.012, 4.0452, 604800, 0, 0, 27890000, 0, 0, 0, 0, 0, 0);

DELETE FROM `gameobject` WHERE `id` IN (202302, 202236, 201596, 500001, 196391, 196392, 202396, 201885, 197341, 201976, 197342, 197343, 201385, 202212, 201710, 202337, 202336, 202079) AND `map` = 668;
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(202302, 668, 3, 1, 5309.51, 2006.64, 709.341, 5.50041, 0, 0, 0.381473, -0.92438, 604800, 100, 1),
(202236, 668, 3, 1, 5309.51, 2006.64, 709.341, 5.53575, 0, 0, 0.365077, -0.930977, 604800, 100, 1),
(201596, 668, 3, 1, 5275.28, 1694.23, 786.147, 0.981225, 0, 0, 0.471166, 0.882044, 25, 0, 1),
(500001, 668, 3, 1, 5323.61, 1755.85, 770.305, 0.784186, 0, 0, 0.382124, 0.924111, 604800, 100, 1),
(196391, 668, 3, 1, 5232.31, 1925.57, 707.695, 0.815481, 0, 0, 0.396536, 0.918019, 300, 0, 1),
(196392, 668, 3, 1, 5232.31, 1925.57, 707.695, 0.815481, 0, 0, 0.396536, 0.918019, 300, 0, 1),
(202396, 668, 3, 1, 5434.27, 1881.12, 751.303, 0.923328, 0, 0, 0.445439, 0.895312, 604800, 100, 1),
(201885, 668, 3, 1, 5494.3, 1978.27, 736.689, 1.0885, 0, 0, 0.517777, 0.855516, 604800, 100, 1),
(197341, 668, 3, 1, 5359.24, 2058.35, 707.695, 3.96022, 0, 0, 0.917394, -0.397981, 300, 100, 1),
(201976, 668, 3, 1, 5264.6, 1959.55, 707.695, 0.736951, 0, 0, 0.360194, 0.932877, 300, 100, 0),
(197342, 668, 3, 1, 5520.72, 2228.89, 733.011, 0.778581, 0, 0, 0.379532, 0.925179, 300, 100, 1),
(197343, 668, 3, 1, 5582.96, 2230.59, 733.011, 5.49098, 0, 0, 0.385827, -0.922571, 300, 100, 1),
(201385, 668, 3, 1, 5540.39, 2086.48, 731.066, 1.00057, 0, 0, 0.479677, 0.877445, 604800, 100, 1),
(202212, 668, 1, 65535, 5241.05, 1663.44, 784.295, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(201710, 668, 1, 65535, 5241.05, 1663.44, 784.295, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(202337, 668, 2, 65535, 5241.05, 1663.44, 784.295, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(202336, 668, 2, 65535, 5241.05, 1663.44, 784.295, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(202079, 668, 3, 1, 5250.96, 1639.36, 784.302, 0, 0, 0, 0, 0, -604800, 100, 1);

UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0, `ReqCreatureOrGOCount1` = 0, `Method` = 2 WHERE `entry` IN (24500, 24802);
DELETE FROM `gameobject` WHERE `guid` = 5479;
DELETE FROM `creature` WHERE `id` IN (37069, 37704, 37225, 36940, 36941);
DELETE FROM `creature` WHERE `guid` = 135344;

DELETE FROM `gameobject_template` WHERE `entry` IN (1000000, 1000001);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(1000000, 14, 9001,'Horde Gunship','','','', 0, 40, 1, 0, 0, 0, 0, 0, 0, 1252, 20, 10, 0, 0, 0, 642, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 11403),
(1000001, 14, 9002,'Alliance Gunship','','','', 0, 40, 1, 0, 0, 0, 0, 0, 0, 1248, 20, 10, 0, 0, 0, 641, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 11723);
-- -------------------------------------------------------------------------}
-- ------------------------------ Wintergrasp ------------------------------
-- -------------------------------------------------------------------------{
DELETE FROM `trinity_string` WHERE `entry` IN (756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 780, 781, 782, 783);
INSERT INTO `trinity_string` VALUES
(756,'Battle begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(757,'%s has successfully defended the fortress!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(758,'%s has taken over the fortress!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(759,'The %s siege workshop has been damaged by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(760,'The %s siege workshop has been destroyed by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(761,'The %s tower has been damaged!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(762,'The %s tower has been destroyed!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(763,'Wintergrasp fortress is under attack!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(764,'Wintergrasp is now under the control of the %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(765,'Wintergrasp timer SET to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(766,'Wintergrasp battle started.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(767,'Wintergrasp battle finished.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(768,'Wintergrasp info: %s controlled. Timer: %s. Wartime: %s. Number of Players: (Horde: %u, Alliance: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(769,'Wintergrasp outdoorPvP is disabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(770,'Wintergrasp outdoorPvP is enabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(771,'You have reached Rank 1: Corporal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(772,'You have reached Rank 2: First Lieutenant', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(780,'30 Minutes before the battle for Wintergrasp begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(781,'10 Minutes before the battle for Wintergrasp begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(782,'The battle for Wintergrasp has stopped! Not enough defenders. Wintergrasp Fortress remains Attackers.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(783,'The battle for Wintergrasp has stopped! Not enough attackers. Wintergrasp Fortress remains Defenders.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM `command` WHERE NAME IN ('wg','wg enable','wg start','wg status','wg stop','wg switch','wg timer');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('wg', 3,'Syntax: .wg $subcommand.'),
('wg enable', 3,'Syntax: .wg enable [on/off] Enable/Disable Wintergrasp outdoorPvP.'),
('wg start', 3,'Syntax: .wg start\r\nForce Wintergrasp battle start.'),
('wg status', 3,'Syntax: .wg status\r\nWintergrasp info, defender, timer, wartime.'),
('wg stop', 3,'Syntax: .wg stop\r\nForce Wintergrasp battle stop (No rewards).'),
('wg switch', 3,'Syntax: .wg switch\r\nSwitchs Wintergrasp defender team.'),
('wg timer', 3,'Syntax: .wg timer $minutes\r\nChange the current timer. Min value = 1, Max value 60 (Wartime), 1440 (Not Wartime)');

-- WG ScriptName
DELETE FROM `outdoorpvp_template` WHERE `TypeId` = 7;
INSERT INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `comment`) VALUES
(7,'outdoorpvp_wg','Wintergrasp');
UPDATE `creature_template` SET `ScriptName` = 'npc_demolisher_engineerer' WHERE `entry` IN (30400, 30499);

-- Teleport WG SPELLs
DELETE FROM `spell_target_position` WHERE `id` IN (59096, 58632, 58633);
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(59096, 571, 5325.06, 2843.36, 409.285, 3.20278),
(58632, 571, 5097.79, 2180.29, 365.61, 2.41),
(58633, 571, 5026.80, 3676.69, 362.58, 3.94);

-- Defender's Portal Activate Proper Spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (54640, 58729);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(54640, 54643, 0,'Defender`s Portal Activate Proper Spell'),
(58729, -33786, 2,'Spiritual Immunity: Protect From Cyclone (now Immune always)');

-- Temp removed gameobject stopping you getting to the relic
-- 194323 - [Wintergrasp Keep Collision Wall X:5396.209961 Y:2840.010010 Z:432.268005 MapId:571
-- 194162 - [Doodad_WG_Keep_Door01_collision01 X:5397.109863 Y:2841.540039 Z:425.901001 MapId:571]
DELETE FROM `gameobject` WHERE `id` IN (194323, 192829, 194162);
-- Towers
UPDATE `gameobject_template` SET `faction` = 0, `flags` = 6553632 WHERE `entry` IN (190356, 190357, 190358);
-- Spirit Healer
UPDATE `creature_template` SET `npcflag` = npcflag|32768 WHERE `entry` IN (31841, 31842);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (31841, 31842);
-- Creature template
UPDATE `creature_template` SET faction_A = 1802, faction_H = 1802 WHERE `entry` IN (30499, 28312, 28319);
UPDATE `creature_template` SET faction_A = 1801, faction_H = 1801 WHERE `entry` IN (30400, 32629, 32627);
-- spell target for build vehicles
DELETE FROM `conditions` WHERE ConditionValue2 = 27852;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 49899, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 56575, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 56661, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 56663, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 56665, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 56667, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 56669, 0, 18, 1, 27852, 0, 0,'', NULL),
(13, 0, 61408, 0, 18, 1, 27852, 0, 0,'', NULL);
-- Workshop
UPDATE `gameobject_template` SET `faction` = 35 WHERE `entry` IN (192028, 192029, 192030, 192031, 192032, 192033);
-- WG Spell area Data
DELETE FROM `spell_area` WHERE spell IN (58730, 57940, 58045);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES
(58730, 4197, 0, 0, 0, 0, 0, 2, 1),
(58730, 4584, 0, 0, 0, 0, 0, 2, 1),
(58730, 4581, 0, 0, 0, 0, 0, 2, 1),
(58730, 4585, 0, 0, 0, 0, 0, 2, 1),
(58730, 4612, 0, 0, 0, 0, 0, 2, 1),
(58730, 4582, 0, 0, 0, 0, 0, 2, 1),
(58730, 4611, 0, 0, 0, 0, 0, 2, 1),
(58730, 4578, 0, 0, 0, 0, 0, 2, 1),
(58730, 4576, 0, 0, 0, 0, 0, 2, 1),
(58730, 4538, 0, 0, 0, 0, 0, 2, 1),
(57940, 65, 0, 0, 0, 0, 0, 2, 1),
(57940, 66, 0, 0, 0, 0, 0, 2, 1),
(57940, 67, 0, 0, 0, 0, 0, 2, 1),
(57940, 206, 0, 0, 0, 0, 0, 2, 1),
(57940, 210, 0, 0, 0, 0, 0, 2, 1),
(57940, 394, 0, 0, 0, 0, 0, 2, 1),
(57940, 395, 0, 0, 0, 0, 0, 2, 1),
(57940, 1196, 0, 0, 0, 0, 0, 2, 1),
(57940, 2817, 0, 0, 0, 0, 0, 2, 1),
(57940, 3456, 0, 0, 0, 0, 0, 2, 1),
(57940, 3477, 0, 0, 0, 0, 0, 2, 1),
(57940, 3537, 0, 0, 0, 0, 0, 2, 1),
(57940, 3711, 0, 0, 0, 0, 0, 2, 1),
(57940, 4100, 0, 0, 0, 0, 0, 2, 1),
(57940, 4196, 0, 0, 0, 0, 0, 2, 1),
(57940, 4228, 0, 0, 0, 0, 0, 2, 1),
(57940, 4264, 0, 0, 0, 0, 0, 2, 1),
(57940, 4265, 0, 0, 0, 0, 0, 2, 1),
(57940, 4272, 0, 0, 0, 0, 0, 2, 1),
(57940, 4273, 0, 0, 0, 0, 0, 2, 1),
(57940, 4395, 0, 0, 0, 0, 0, 2, 1),
(57940, 4415, 0, 0, 0, 0, 0, 2, 1),
(57940, 4416, 0, 0, 0, 0, 0, 2, 1),
(57940, 4493, 0, 0, 0, 0, 0, 2, 1),
(57940, 4494, 0, 0, 0, 0, 0, 2, 1),
(57940, 4603, 0, 0, 0, 0, 0, 2, 1),
(58045, 4197, 0, 0, 0, 0, 0, 2, 1);

/* Portal Dalaran->WG */
DELETE FROM `gameobject` WHERE `id` = 193772;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(NULL, 193772, 571, 1, 64, 5924.11, 573.387, 661.087, 4.43208, 0, 0, 0.798953, -0.601393, 300, 0, 1),
(NULL, 193772, 571, 1, 65535, 5686.57, 772.921, 647.754, 5.62225, 0, 0, 0.324484, -0.945891, 600, 0, 1),
(NULL, 193772, 571, 1, 65535, 5930.82, 548.961, 640.632, 1.88506, 0, 0, 0.809047, 0.587744, 300, 0, 1);

/* Wintergrasp Battle-Mage */
DELETE FROM `creature` WHERE `id` = 32170;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(NULL, 32170, 571, 1, 65535, 27801, 0, 5925.34, 573.71, 661.087, 4.06662, 300, 0, 0, 504000, 440700, 0, 0, 0, 0, 0),
(NULL, 32170, 571, 1, 64, 0, 918, 5932.96, 549.906, 641.595, 2.09189, 300, 0, 0, 504000, 440700, 0, 0, 0, 0, 0);

UPDATE `creature_template` SET `ScriptName` = 'npc_wg_ally_battle_mage' WHERE `entry` = 32169;
UPDATE `creature_template` SET `ScriptName` = 'npc_wg_horde_battle_mage' WHERE `entry` = 32170;
UPDATE `gameobject_template` SET `type` = 6, `faction` = 0, `data2` = 10, `data3` = 54643, `ScriptName` = 'go_wg_veh_teleporter' WHERE `entry` = 192951;

DELETE FROM `gameobject` WHERE `id` IN (
192317, 192335, 192313, 192316, 192332, 192331, 192330, 192329, 192487, 192310, 192314, 192308, 192309, 192324,
192326, 192312, 192325, 192304, 187433, 193984, 193983, 192377, 192321, 192318, 192322, 192320, 192269, 192273,
192274, 192277, 192278, 192280, 192283, 192284, 192285, 192289, 192290, 192336, 192338, 192339, 192349, 192350,
192351, 192352, 192353, 192354, 192355, 192356, 192357, 192358, 192359, 192360, 192361, 192362, 192363, 192364,
192366, 192367, 192368, 192369, 192370, 192371, 192372, 192373, 192374, 192375, 192378, 192379, 192406, 192407,
192414, 192416, 192417, 192418, 192429, 192433, 192434, 192435, 192458, 192459, 192460, 192461, 192488, 192501,
192254, 192255, 192688, 192686, 180398, 193764, 193762, 192319, 192287, 192323, 192305, 192286, 192334, 192307,
192306, 192328, 192252, 192253, 192292, 192299, 192327, 192267, 192449, 192450) AND `map` = 571;

INSERT INTO `gameobject` VALUES
(NULL, 192317, 571, 1, 385, 5363.39, 2781.28, 435.634, 1.58825, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192335, 571, 1, 385, 5363.72, 2763.25, 445.023, -1.54462, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192313, 571, 1, 1, 5392.65, 3037.11, 433.713, -1.52716, 0, 0, -0.691512, 0.722365, 300, 0, 1),
(NULL, 192316, 571, 1, 385, 5322.01, 2781.13, 435.673, 1.57952, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192332, 571, 1, 1, 5289.46, 2704.68, 435.875, -0.017451, 0, 0, -0.00872539, 0.999962, 300, 0, 1),
(NULL, 192331, 571, 1, 1, 5350.95, 2640.36, 435.408, 1.5708, 0, 0, 0.707108, 0.707106, 300, 0, 1),
(NULL, 192330, 571, 1, 1, 5392.27, 2639.74, 435.331, 1.50971, 0, 0, 0.685183, 0.728371, 300, 0, 1),
(NULL, 192329, 571, 1, 1, 5350.88, 2622.72, 444.686, -1.5708, 0, 0, -0.707108, 0.707106, 300, 0, 1),
(NULL, 192487, 571, 1, 1, 5278.38, 2613.83, 432.721, -1.58825, 0, 0, -0.713251, 0.700909, 300, 0, 1),
(NULL, 192487, 571, 1, 1, 5260.82, 2631.8, 433.324, 3.05433, 0, 0, 0.999048, 0.0436174, 300, 0, 1),
(NULL, 192310, 571, 1, 1, 5271.8, 2704.87, 445.183, -3.13286, 0, 0, -0.99999, 0.00436634, 300, 0, 1),
(NULL, 192314, 571, 1, 1, 5236.27, 2739.46, 444.992, -1.59698, 0, 0, -0.716303, 0.697789, 300, 0, 1),
(NULL, 192487, 571, 1, 1, 5163.78, 2729.68, 432.009, -1.58825, 0, 0, -0.713251, 0.700909, 300, 0, 1),
(NULL, 192308, 571, 1, 1, 5237.07, 2757.03, 435.796, 1.51844, 0, 0, 0.688356, 0.725373, 300, 0, 1),
(NULL, 192309, 571, 1, 1, 5235.34, 2924.34, 435.04, -1.5708, 0, 0, -0.707108, 0.707106, 300, 0, 1),
(NULL, 192487, 571, 1, 1, 5262.54, 3047.95, 430.979, 3.10665, 0, 0, 0.999847, 0.0174704, 300, 0, 1),
(NULL, 192487, 571, 1, 1, 5163.13, 2952.59, 433.503, 1.53589, 0, 0, 0.694658, 0.71934, 300, 0, 1),
(NULL, 192324, 571, 1, 1, 5235.19, 2942, 443.948, 1.58825, 0, 0, 0.713251, 0.700909, 300, 0, 1),
(NULL, 192326, 571, 1, 1, 5272.73, 2976.55, 443.81, 3.12412, 0, 0, 0.999962, 0.00873622, 300, 0, 1),
(NULL, 192312, 571, 1, 1, 5352.37, 3037.09, 435.252, -1.5708, 0, 0, -0.707108, 0.707106, 300, 0, 1),
(NULL, 192325, 571, 1, 1, 5290.35, 2976.56, 435.221, 0.017452, 0, 0, 0.00872589, 0.999962, 300, 0, 1),
(NULL, 192304, 571, 1, 385, 5397.76, 2873.08, 455.321, 3.10665, 0, 0, 0.999847, 0.0174704, 300, 0, 1),
(NULL, 187433, 571, 1, 1, 2832.84, 6184.45, 84.6827, -2.58308, 0, 0, 0, 0, 300, 100, 1),
(NULL, 187433, 571, 1, 1, 2835.96, 6180.37, 84.6827, 1.50098, 0, 0, 0, 0, 180, 100, 1),
(NULL, 187433, 571, 1, 1, 2830.12, 6188.96, 84.6827, -0.855211, 0, 0, 0, 0, 300, 100, 1),
(NULL, 187433, 571, 1, 1, 2831.88, 6188.72, 84.6827, -1.65806, 0, 0, 0, 0, 300, 100, 1),
(NULL, 193984, 571, 1, 1, 7647.47, 2055.55, 599.399, -0.279252, 0, 0, 0, 0, 300, 0, 1),
(NULL, 193984, 571, 1, 1, 7647.42, 2065.23, 599.308, 0.279252, 0, 0, 0, 0, 300, 0, 1),
(NULL, 193984, 571, 1, 1, 7609.86, 2055.53, 599.494, -2.86234, 0, 0, 0, 0, 300, 0, 1),
(NULL, 193984, 571, 1, 1, 7610.18, 2065.31, 599.426, 2.87979, 0, 0, 0, 0, 300, 0, 1),
(NULL, 193983, 571, 1, 1, 7906.95, 2053.04, 599.626, -0.296705, 0, 0, 0, 0, 300, 0, 1),
(NULL, 193983, 571, 1, 1, 7907.01, 2063.02, 599.587, 0.261798, 0, 0, 0, 0, 300, 0, 1),
(NULL, 193983, 571, 1, 1, 7870.43, 2053.35, 599.669, -2.87979, 0, 0, 0, 0, 180, 0, 1),
(NULL, 193983, 571, 1, 1, 7870.36, 2063.25, 599.628, 2.86234, 0, 0, 0, 0, 300, 0, 1),
(NULL, 192377, 571, 1, 1, 5414.19, 3069.8, 415.187, 1.64061, 0, 0, 0, 0, 5, 100, 1),
(NULL, 192321, 571, 1, 385, 5288.85, 2861.82, 435.591, 0.026179, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192318, 571, 1, 385, 5322.25, 2898.95, 435.643, -1.57952, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192322, 571, 1, 385, 5322.89, 2917.14, 445.154, 1.56207, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192320, 571, 1, 385, 5289.05, 2820.23, 435.674, 0, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192269, 571, 1, 1, 4526.46, 2810.18, 391.2, -2.99322, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192273, 571, 1, 1, 4417.94, 2324.81, 371.577, 3.08051, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192274, 571, 1, 1, 4424.15, 3286.54, 371.546, 3.12412, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192277, 571, 1, 1, 4572.93, 3475.52, 363.009, 1.42244, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192278, 571, 1, 1, 4433.9, 3534.14, 360.275, -1.85005, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192280, 571, 1, 1, 4857.97, 3335.44, 368.881, -2.94959, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192283, 571, 1, 1, 5006.34, 3280.4, 371.163, 2.22529, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192284, 571, 1, 65, 5372.48, 2862.5, 409.049, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192285, 571, 1, 65, 5371.49, 2820.8, 409.177, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192289, 571, 1, 1, 4778.19, 2438.06, 345.644, -2.94088, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192290, 571, 1, 1, 5024.57, 2532.75, 344.023, -1.93732, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192336, 571, 1, 1, 5154.49, 2862.15, 445.012, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192338, 571, 1, 65, 5397.76, 2873.08, 455.461, 3.10665, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192339, 571, 1, 65, 5397.39, 2809.33, 455.344, 3.10665, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192349, 571, 1, 1, 5155.31, 2820.74, 444.979, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192350, 571, 1, 1, 5270.69, 2861.78, 445.058, -3.11539, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192351, 571, 1, 1, 5271.28, 2820.16, 445.201, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192352, 571, 1, 1, 5173.02, 2820.93, 435.72, 0.017452, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192353, 571, 1, 1, 5172.11, 2862.57, 435.721, 0.017452, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192354, 571, 1, 1, 5288.41, 2861.79, 435.721, 0.017452, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192355, 571, 1, 1, 5288.92, 2820.22, 435.721, 0.017452, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192356, 571, 1, 1, 5237.07, 2757.03, 435.796, 1.51844, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192357, 571, 1, 1, 5235.34, 2924.34, 435.04, -1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192358, 571, 1, 65, 5322.23, 2899.43, 435.808, -1.58825, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192359, 571, 1, 65, 5364.35, 2899.4, 435.839, -1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192360, 571, 1, 65, 5352.37, 3037.09, 435.252, -1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192361, 571, 1, 65, 5392.65, 3037.11, 433.713, -1.52716, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192362, 571, 1, 65, 5322.12, 2763.61, 444.974, -1.55334, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192363, 571, 1, 65, 5363.61, 2763.39, 445.024, -1.54462, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192364, 571, 1, 1, 5350.88, 2622.72, 444.686, -1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192366, 571, 1, 1, 5236.27, 2739.46, 444.992, -1.59698, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192367, 571, 1, 1, 5271.8, 2704.87, 445.183, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192368, 571, 1, 65, 5289.46, 2704.68, 435.875, -0.017451, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192369, 571, 1, 1, 5350.95, 2640.36, 435.408, 1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192370, 571, 1, 1, 5392.27, 2639.74, 435.331, 1.50971, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192371, 571, 1, 65, 5364.29, 2916.94, 445.331, 1.57952, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192372, 571, 1, 65, 5322.86, 2916.95, 445.154, 1.56207, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192373, 571, 1, 1, 5290.35, 2976.56, 435.221, 0.017452, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192374, 571, 1, 1, 5272.94, 2976.55, 444.492, 3.12412, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192375, 571, 1, 1, 5235.19, 2941.9, 444.278, 1.58825, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192378, 571, 1, 65, 5322.02, 2781.13, 435.811, 1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192379, 571, 1, 65, 5363.42, 2781.03, 435.763, 1.5708, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192406, 571, 1, 1, 4438.3, 3361.08, 371.568, -0.017451, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192407, 571, 1, 1, 4448.17, 3235.63, 370.412, -1.56207, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192414, 571, 1, 1, 4387.62, 2719.57, 389.935, -1.54462, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192416, 571, 1, 1, 4408.57, 2422.61, 377.179, 1.58825, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192417, 571, 1, 1, 4416.59, 2414.08, 377.196, 0, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192418, 571, 1, 1, 4417.25, 2301.14, 377.214, 0.026179, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192429, 571, 1, 1, 4464.12, 2855.45, 406.111, 0.829032, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192433, 571, 1, 1, 4401.63, 3377.46, 363.365, 1.55334, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192434, 571, 1, 1, 5041.61, 3294.4, 382.15, -1.63188, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192435, 571, 1, 1, 4855.63, 3297.62, 376.739, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192458, 571, 1, 1, 4811.4, 2441.9, 358.207, -2.0333, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192459, 571, 1, 1, 4805.67, 2407.48, 358.191, 1.78023, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192460, 571, 1, 1, 5004.35, 2486.36, 358.449, 2.17294, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192461, 571, 1, 1, 4983.28, 2503.09, 358.177, -0.427603, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5160.34, 2798.61, 430.769, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5158.81, 2883.13, 431.618, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5278.38, 2613.83, 433.409, -1.58825, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5260.82, 2631.8, 433.324, 3.05433, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5163.13, 2952.59, 433.503, 1.53589, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5145.11, 2935, 433.386, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5262.54, 3047.95, 432.055, 3.10665, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5146.04, 2747.21, 433.584, 3.07177, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192488, 571, 1, 1, 5163.78, 2729.68, 433.394, -1.58825, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4398.82, 2804.7, 429.792, -1.58825, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4416, 2822.67, 429.851, -0.017452, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4559.11, 3606.22, 419.999, -1.48353, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4539.42, 3622.49, 420.034, -3.07177, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4555.26, 3641.65, 419.974, 1.67551, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4574.87, 3625.91, 420.079, 0.087266, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4466.79, 1960.42, 459.144, 1.15192, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4475.35, 1937.03, 459.07, -0.436332, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4451.76, 1928.1, 459.076, -2.00713, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192501, 571, 1, 1, 4442.99, 1951.9, 459.093, 2.74016, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192254, 571, 1, 1, 5154.46, 2828.94, 409.189, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192255, 571, 1, 1, 5154.52, 2853.31, 409.183, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(NULL, 192688, 571, 1, 1, 5916.1, 566.209, 639.625, -2.72271, 0, 0, 0, 1, 180, 100, 1),
(NULL, 192686, 571, 1, 1, 5664.81, 791.002, 653.698, -0.663223, 0, 0, 0, 1, 180, 100, 1),
(NULL, 180398, 571, 1, 1, 5665.02, 790.2, 653.698, -0.610864, 0, 0, 0, 1, 180, 100, 1),
(NULL, 192487, 571, 1, 256, 4855.63, 3297.62, 376.281, -3.13286, 0, 0, -0.99999, 0.00436634, 300, 0, 1),
(NULL, 192290, 571, 1, 256, 4526.46, 2810.18, 391.2, -2.99322, 0, 0, -0.997249, 0.0741182, 300, 0, 1),
(NULL, 192487, 571, 1, 256, 4517.75, 2717.23, 387.812, -1.53589, 0, 0, -0.694658, 0.71934, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4475.35, 1937.03, 459.07, -0.436332, 0, 0, -0.216439, 0.976296, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4451.76, 1928.1, 459.076, -2.00713, 0, 0, -0.843392, 0.537299, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4442.99, 1951.9, 459.093, 2.74016, 0, 0, 0.979924, 0.199371, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4466.8, 1960.44, 459.841, 1.15192, 0, 0, 0.54464, 0.83867, 300, 0, 1),
(NULL, 192487, 571, 1, 256, 5041.61, 3294.4, 382.15, -1.63188, 0, 0, -0.72837, 0.685184, 300, 0, 1),
(NULL, 192278, 571, 1, 256, 5006.34, 3280.4, 371.163, 2.22529, 0, 0, 0.896872, 0.442291, 300, 0, 1),
(NULL, 192278, 571, 1, 256, 4857.97, 3335.44, 368.881, -2.94959, 0, 0, -0.995395, 0.0958539, 300, 0, 1),
(NULL, 192290, 571, 1, 256, 4433.9, 3534.14, 360.275, -1.85005, 0, 0, -0.798636, 0.601815, 300, 0, 1),
(NULL, 192290, 571, 1, 256, 4572.93, 3475.52, 363.009, 1.42244, 0, 0, 0.652758, 0.757566, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4555.26, 3641.65, 419.974, 1.67551, 0, 0, 0.743143, 0.669133, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4574.87, 3625.91, 420.079, 0.087266, 0, 0, 0.0436192, 0.999048, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4559.11, 3606.22, 419.999, -1.48353, 0, 0, -0.67559, 0.737277, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4539.42, 3622.49, 420.034, -3.07177, 0, 0, -0.999391, 0.0349043, 300, 0, 1),
(NULL, 192290, 571, 1, 256, 4401.63, 3377.46, 363.365, 1.55334, 0, 0, 0.700908, 0.713252, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4448.17, 3235.63, 370.412, -1.56207, 0, 0, -0.704015, 0.710185, 300, 0, 1),
(NULL, 192488, 571, 1, 256, 4438.3, 3361.08, 371.299, -0.017451, 0, 0, -0.00872539, 0.999962, 300, 0, 1),
(NULL, 192290, 571, 1, 256, 4424.15, 3286.54, 371.546, 3.12412, 0, 0, 0.999962, 0.00873622, 300, 0, 1),
(NULL, 192461, 571, 1, 1, 4416.03, 2822.68, 430.475, -0.017452, 0, 0, -0.00872589, 0.999962, 300, 0, 1),
(NULL, 192461, 571, 1, 1, 4464.12, 2855.45, 406.111, 0.829032, 0, 0, 0.402747, 0.915311, 300, 0, 1),
(NULL, 192461, 571, 1, 1, 4398.82, 2804.7, 429.792, -1.58825, 0, 0, -0.713251, 0.700909, 300, 0, 1),
(NULL, 192461, 571, 1, 1, 4408.57, 2422.61, 377.179, 1.58825, 0, 0, 0.713251, 0.700909, 300, 0, 1),
(NULL, 192461, 571, 1, 1, 4416.59, 2414.08, 377.13, 0, 0, 0, 0, 1, 300, 0, 1),
(NULL, 192461, 571, 1, 1, 4417.25, 2301.14, 377.214, 0.026179, 0, 0, 0.0130891, 0.999914, 300, 0, 1),
(NULL, 192418, 571, 1, 1, 4805.67, 2407.48, 358.191, 1.78023, 0, 0, 0.777144, 0.629323, 300, 0, 1),
(NULL, 192418, 571, 1, 1, 4811.4, 2441.9, 358.207, -2.0333, 0, 0, -0.85035, 0.526218, 300, 0, 1),
(NULL, 192273, 571, 1, 1, 4778.19, 2438.06, 345.644, -2.94088, 0, 0, -0.994969, 0.100188, 300, 0, 1),
(NULL, 192273, 571, 1, 1, 5024.57, 2532.75, 344.023, -1.93732, 0, 0, -0.824127, 0.566404, 300, 0, 1),
(NULL, 192418, 571, 1, 1, 5004.35, 2486.36, 358.449, 2.17294, 0, 0, 0.884989, 0.465612, 300, 0, 1),
(NULL, 192418, 571, 1, 1, 4983.28, 2503.09, 358.177, -0.427603, 0, 0, -0.212176, 0.977231, 300, 0, 1),
(NULL, 192290, 571, 1, 1, 4417.94, 2324.81, 371.577, 3.08051, 0, 0, 0.999534, 0.0305366, 300, 0, 1),
(NULL, 193764, 571, 1, 1, 7625.87, 2060.05, 604.27, 0.07854, 0, 0, 0.99999, 0.004363, 180, 255, 1),
(NULL, 193762, 571, 1, 1, 7625.66, 2060.04, 604.195, -3.05428, 0, 0, 0.99999, 0.004363, 180, 255, 1),
(NULL, 192319, 571, 1, 385, 5364.3, 2899.22, 435.691, -1.55334, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192287, 571, 1, 385, 5372.42, 2862.48, 409.366, 3.14159, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192323, 571, 1, 385, 5364.28, 2917.26, 445.332, 1.58825, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192305, 571, 1, 385, 5397.31, 2809.26, 455.102, 3.13286, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192286, 571, 1, 385, 5371.45, 2820.79, 409.427, 3.12412, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192334, 571, 1, 385, 5322.17, 2763.2, 444.974, -1.56207, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192307, 571, 1, 385, 5271.16, 2820.11, 445.109, -3.13286, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192306, 571, 1, 385, 5270.56, 2861.68, 444.917, -3.12412, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192487, 571, 1, 385, 5160.28, 2798.6, 430.604, -3.12412, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192487, 571, 1, 385, 5146.04, 2747.3, 433.527, 3.12412, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192328, 571, 1, 385, 5173.13, 2820.96, 435.658, 0.026179, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192252, 571, 1, 385, 5154.37, 2853.23, 409.183, 3.14159, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192253, 571, 1, 385, 5154.42, 2828.93, 409.189, 3.14159, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192292, 571, 1, 385, 5154.35, 2862.08, 445.01, 3.14159, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192299, 571, 1, 385, 5155.22, 2820.63, 444.979, -3.11539, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192327, 571, 1, 385, 5172.34, 2862.57, 435.658, 0, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192487, 571, 1, 385, 5158.71, 2882.9, 431.274, 3.14159, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192487, 571, 1, 385, 5145.11, 2934.95, 433.255, -3.10665, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192267, 571, 1, 385, 4452.76, 2639.14, 358.444, 1.67552, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192449, 571, 1, 385, 4517.75, 2717.23, 387.812, -1.53589, 0, 0, 0, 1, 300, 255, 1),
(NULL, 192450, 571, 1, 385, 4387.59, 2719.9, 390.201, -1.51843, 0, 0, 0, 1, 300, 255, 1);
-- -------------------------------------------------------------------------}
-- ------------------------------- Ulduar ----------------------------------
-- -------------------------------------------------------------------------{
-- /*
DELETE FROM `spell_script_names` WHERE `spell_id` IN (64164, 64168, 64059, 63025, 64233, 62038, 62039, 63382);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62038,'spell_gen_biting_cold'),
(62039,'spell_gen_biting_cold_dot'),
(63382,'spell_gen_rapid_burst'),
(63025,'spell_xt002_gravity_bomb'),
(64233,'spell_xt002_gravity_bomb'),
(64164,'spell_yoggsaron_lunatic_gaze'),
(64168,'spell_yoggsaron_lunatic_gaze'),
(64059,'spell_yoggsaron_induce_madness');

-- GameObjects
DELETE FROM `gameobject_template` WHERE `entry` = 194264;
UPDATE `gameobject_template` SET `faction` = 114 WHERE `entry` = 194316;
UPDATE `gameobject_template` SET `flags` = 34, faction = 0 WHERE `entry` = 194255;
UPDATE `gameobject_template` SET `flags` = 32, faction = 114 WHERE `entry` IN (194416, 194905, 194631, 194554, 194556, 194553, 194441, 194634, 194442, 194559, 194774, 194775, 194776, 194750, 194773, 194557, 194558, 194560);
-- Ignis
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 9, `vehicleId` = 342 WHERE `entry` = 33118;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 9 WHERE `entry` = 33190;
DELETE FROM creature WHERE id = 33121;
DELETE FROM conditions WHERE SourceEntry = 62343;
INSERT INTO `conditions` VALUES
(13, 0, 62343, 0, 18, 1, 33121, 0, 0,'',NULL);
-- Ignis constructors
UPDATE `creature_template` SET `unit_flags` = 33554434, `flags_extra` = 0 WHERE `entry` IN (33121, 33191);
-- Razorscale
UPDATE `creature_template` SET `speed_run` = 0.00001 WHERE `entry` IN (34188, 34189);
-- XT-002
UPDATE `creature_template` SET `VehicleId` = 335 WHERE `entry` = 33293;
-- Assembly of Iron
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` IN (32867, 32927, 33693, 33692);
UPDATE `creature_template` SET `mechanic_immune_mask` = 617297499 WHERE `entry` IN (32857, 33694);
UPDATE `creature_template` SET `ScriptName` = 'npc_rune_of_power' WHERE `entry` = 33705;
UPDATE `creature_template` SET `difficulty_entry_1` = 33691, `ScriptName` = 'npc_rune_of_summoning' WHERE `entry` = 33051;
UPDATE `creature_template` SET `ScriptName` = 'npc_lightning_elemental' WHERE `entry` = 32958;
-- Runemaster Molgeim
UPDATE `creature_model_info` SET `bounding_radius` = 0.45, `combat_reach` = 4 WHERE `modelid` = 28381;
-- Steelbreaker
UPDATE `creature_model_info` SET `bounding_radius` = 0.45, `combat_reach` = 8 WHERE `modelid` = 28344;
-- Kologarn
UPDATE `creature_template` SET `baseattacktime` = 1800, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` IN (32930, 33909);
UPDATE `creature_model_info` SET `bounding_radius` = 1, `combat_reach` = 15 WHERE `modelid` = 28638;
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28821;
-- Left Arm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_left_arm' WHERE `entry` = 32933;
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28821;
-- Right Arm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_right_arm' WHERE `entry` = 32934;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` IN (33910, 33911);
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28822;
-- Focused Eyebeam
UPDATE `creature_template` SET `ScriptName` = 'npc_focused_eyebeam' WHERE `entry` IN (33632, 33802);
DELETE FROM conditions WHERE SourceEntry IN (63676, 63702);
INSERT INTO `conditions` VALUES
(13, 0, 63676, 0, 18, 1, 32930, 0, 0,'',"Focused Eyebeam (Kologarn)"),
(13, 0, 63702, 0, 18, 1, 32930, 0, 0,'',"Focused Eyebeam (Kologarn)");
-- Cleanup
DELETE FROM `creature` WHERE `id` IN (33632, 33802, 34297, 32933, 32934, 33809, 33661, 33742);
-- DELETE FROM vehicle_accessory WHERE entry = 32930;
-- Auriaya
DELETE FROM `creature` WHERE `id` IN (33515, 34014);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(94378, 33515, 603, 3, 65535, 0, 0, 1938.97, 43.0634, 411.356, 4.17477, 604800, 0, 0, 3137625, 234190, 0, 2, 0, 0, 0);
UPDATE `creature_template` SET `baseattacktime` = 1500, `equipment_id` = 2422, `mechanic_immune_mask` = 617299807, `flags_extra` = 1 WHERE `entry` = 33515;
UPDATE `creature_template` SET `baseattacktime` = 1500, `equipment_id` = 2422, `mechanic_immune_mask` = 617299807, `flags_extra` = 1 WHERE `entry` = 34175;
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 5 WHERE `modelid` = 28651;
-- Sanctum Sentry
UPDATE `creature_template` SET `speed_walk` = 1.66667, `mechanic_immune_mask` = 536870912, `flags_extra` = 1, `ScriptName` = 'npc_sanctum_sentry' WHERE `entry` = 34014;
UPDATE `creature_template` SET `baseattacktime` = 1500, `speed_walk` = 1.66667, `mechanic_immune_mask` = 536870912, `flags_extra` = 1 WHERE `entry` = 34166;
-- Feral Defender
UPDATE `creature_template` SET `speed_walk` = 2, `dmg_multiplier` = 3.5, `flags_extra` = 1, `ScriptName` = 'npc_feral_defender' WHERE `entry` = 34035;
UPDATE `creature_template` SET `speed_walk` = 2, `dmg_multiplier` = 5, `flags_extra` = 1, `baseattacktime` = 1500 WHERE `entry` = 34171;
UPDATE `creature_template` SET `unit_flags` = 33554432, `ScriptName` = 'npc_seeping_trigger' WHERE `entry` = 34098;
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 34174;
UPDATE `creature_template` SET `dmg_multiplier` = 1.5, `baseattacktime` = 1500 WHERE `entry` = 34169;
UPDATE `creature_template` SET `ScriptName` = 'npc_feral_defender_trigger' WHERE `entry` = 34096;
-- Mace equip
DELETE FROM `creature_equip_template` WHERE entry = 2422;
INSERT INTO `creature_equip_template` VALUES (2422, 45315, 0, 0);
-- Cleanup
DELETE FROM `creature` WHERE `id` = 34014;
-- Auriaya movement path
DELETE FROM `creature_addon` WHERE guid = 94378;
INSERT INTO `creature_addon` VALUES (94378, 1033515, 0, 0, 0, 0,NULL);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 137496;
DELETE FROM `waypoint_data` WHERE id = 1033515;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(1033515, 1, 1968.46, 51.75, 417.72, 0, 0, 0, 100, 0),
(1033515, 2, 1956.75, 49.22, 411.35, 0, 0, 0, 100, 0),
(1033515, 3, 1938.90, 42.09, 411.35, 3000, 0, 0, 100, 0),
(1033515, 4, 1956.75, 49.22, 411.35, 0, 0, 0, 100, 0),
(1033515, 5, 1968.46, 51.75, 417.72, 0, 0, 0, 100, 0),
(1033515, 6, 2011.43, 44.91, 417.72, 0, 0, 0, 100, 0),
(1033515, 7, 2022.65, 37.74, 411.36, 0, 0, 0, 100, 0),
(1033515, 8, 2046.65, 9.61, 411.36, 0, 0, 0, 100, 0),
(1033515, 9, 2053.4, -8.65, 421.68, 0, 0, 0, 100, 0),
(1033515, 10, 2053.14, -39.8, 421.66, 0, 0, 0, 100, 0),
(1033515, 11, 2046.26, -57.96, 411.35, 0, 0, 0, 100, 0),
(1033515, 12, 2022.42, -86.39, 411.35, 0, 0, 0, 100, 0),
(1033515, 13, 2011.26, -92.95, 417.71, 0, 0, 0, 100, 0),
(1033515, 14, 1969.43, -100.02, 417.72, 0, 0, 0, 100, 0),
(1033515, 15, 1956.66, -97.4, 411.35, 0, 0, 0, 100, 0),
(1033515, 16, 1939.18, -90.90, 411.35, 3000, 0, 0, 100, 0),
(1033515, 17, 1956.66, -97.4, 411.35, 0, 0, 0, 100, 0),
(1033515, 18, 1969.43, -100.02, 417.72, 0, 0, 0, 100, 0),
(1033515, 19, 2011.26, -92.95, 417.71, 0, 0, 0, 100, 0),
(1033515, 20, 2022.42, -86.39, 411.35, 0, 0, 0, 100, 0),
(1033515, 21, 2046.26, -57.96, 411.35, 0, 0, 0, 100, 0),
(1033515, 22, 2053.14, -39.8, 421.66, 0, 0, 0, 100, 0),
(1033515, 23, 2053.4, -8.65, 421.68, 0, 0, 0, 100, 0),
(1033515, 24, 2046.65, 9.61, 411.36, 0, 0, 0, 100, 0),
(1033515, 25, 2022.65, 37.74, 411.36, 0, 0, 0, 100, 0),
(1033515, 26, 2011.43, 44.91, 417.72, 0, 0, 0, 100, 0);
-- Hodir
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'boss_hodir' WHERE `entry` = 32845;
UPDATE `creature_template` SET `equipment_id` = 1843, `mechanic_immune_mask` = 650854239, `flags_extra` = 1 WHERE `entry` = 32846;
-- Hodir npcs
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_priest' WHERE `entry` IN (32897, 33326, 32948, 33330);
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_shaman' WHERE `entry` IN (33328, 32901, 33332, 32950);
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_druid' WHERE `entry` IN (33325, 32900, 32941, 33333);
UPDATE `creature_template` SET `ScriptName` = 'npc_hodir_mage' WHERE `entry` IN (32893, 33327, 33331, 32946);
UPDATE `creature_template` SET `ScriptName` = 'npc_toasty_fire' WHERE `entry` = 33342;
UPDATE `creature_template` SET `ScriptName` = 'npc_icicle' WHERE `entry` = 33169;
UPDATE `creature_template` SET `ScriptName` = 'npc_icicle_snowdrift' WHERE `entry` = 33173;
UPDATE `creature_template` SET `ScriptName` = 'npc_snowpacked_icicle' WHERE `entry` = 33174;
UPDATE `creature_template` SET `difficulty_entry_1` = 33352, `mechanic_immune_mask` = 612597599, `ScriptName` = 'npc_flash_freeze' WHERE `entry` = 32926;
UPDATE `creature_template` SET `difficulty_entry_1` = 33353, `mechanic_immune_mask` = 612597599, `ScriptName` = 'npc_flash_freeze' WHERE `entry` = 32938;
UPDATE `creature_template` SET `mechanic_immune_mask` = 612597599 WHERE `entry` IN (33352, 33353);
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 194173;
-- Cleanup
DELETE FROM `creature` WHERE `id` IN (32950, 32941, 32948, 32946, 32938);
-- Mimiron Tram
UPDATE `gameobject_template` SET `flags` = 32, `data2` = 3000, `ScriptName` = 'go_call_tram' WHERE `entry` IN (194914, 194912, 194437);
DELETE FROM gameobject WHERE id = 194437;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194437, 603, 1, 1, 2306.87, 274.237, 424.288, 1.52255, 0, 0, 0.689847, 0.723956, 300, 0, 1);
DELETE FROM gameobject_template WHERE entry = 194438;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(194438, 1, 8504,'Activate Tram','','','', 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'go_call_tram', 11159);
DELETE FROM gameobject WHERE id = 194438;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194438, 603, 1, 1, 2306.99, 2589.35, 424.382, 4.71676, 0, 0, 0.705559, -0.708651, 300, 0, 1);
-- Mimiron
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_mimiron' WHERE `entry` = 33350;
-- Leviathan MKII
UPDATE `creature_template` SET `vehicleid` = 370, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_leviathan_mk' WHERE `entry` = 33432;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34106;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_leviathan_mk_turret' WHERE `entry` = 34071;
DELETE FROM vehicle_template_accessory WHERE entry = 33432;
INSERT INTO vehicle_template_accessory VALUE (33432, 34071, 3, 1,'Leviathan Mk II turret', 8, 0);
UPDATE `creature_template` SET `ScriptName` = 'npc_proximity_mine' WHERE entry = 34362;
DELETE FROM `creature_model_info` WHERE `modelid` = 28831;
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(28831, 0.5, 7, 2, 0);
-- VX-001
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `vehicleid` = 371, `ScriptName` = 'boss_vx_001' WHERE `entry` = 33651;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34108;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 34050;
UPDATE `creature_template` SET `unit_flags` = 33686020, `flags_extra` = 2 WHERE `entry` = 34211;
UPDATE `creature_template` SET `ScriptName` = 'npc_rocket_strike' WHERE `entry` = 34047;
-- Aerial Command Unit
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'boss_aerial_unit' WHERE `entry` = 33670;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34109;
UPDATE `creature_template` SET `ScriptName` = 'npc_magnetic_core' WHERE `entry` = 34068;
UPDATE `creature_template` SET `ScriptName` = 'npc_assault_bot' WHERE `entry` = 34057;
UPDATE `creature_template` SET `difficulty_entry_1` = 34148, `ScriptName` = 'npc_emergency_bot' WHERE `entry` = 34147;
-- HardMode
UPDATE `gameobject_template` SET `flags` = 32, `ScriptName` = 'go_not_push_button' WHERE `entry` = 194739;
UPDATE `creature_template` SET `difficulty_entry_1` = 34361, `ScriptName` = 'npc_frost_bomb' WHERE `entry` = 34149;
UPDATE `creature_template` SET `speed_walk` = 0.15, `speed_run` = 0.15, `ScriptName` = 'npc_mimiron_flame_trigger' WHERE `entry` = 34363;
UPDATE `creature_template` SET `ScriptName` = 'npc_mimiron_flame_spread' WHERE `entry` = 34121;
-- CleanUp
DELETE FROM creature WHERE `id` IN (34071, 33856);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 34143;
-- Freya
UPDATE `creature_template` SET `baseattacktime` = 1500, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_freya' WHERE `entry` = 32906;
UPDATE `creature_template` SET `speed_walk` = 1.6, `baseattacktime` = 1500, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 33360;
-- Elders
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_elder_brightleaf' WHERE `entry` = 32915;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_elder_ironbranch' WHERE `entry` = 32913;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_elder_stonebark' WHERE `entry` = 32914;
UPDATE `creature_template` SET `speed_walk` = 1.66666, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` IN (33393, 33392, 33391);
-- Iron roots
UPDATE `creature_template` SET `difficulty_entry_1` = 33397, `mechanic_immune_mask` = 650854239, `ScriptName` = 'npc_iron_roots' WHERE `entry` = 33168;
UPDATE `creature_template` SET `difficulty_entry_1` = 33396, `mechanic_immune_mask` = 650854239, `ScriptName` = 'npc_iron_roots' WHERE `entry` = 33088;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239 WHERE `entry` IN (33396, 33397);
-- Eonar Gift
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'npc_eonars_gift' WHERE `entry` = 33228;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 33385;
-- Unstable Sun Beam
UPDATE `creature_template` SET `ScriptName` = 'npc_unstable_sun_beam' WHERE `entry` = 33050;
-- Sun Beam
UPDATE `creature_template` SET `ScriptName` = 'npc_sun_beam' WHERE `entry` = 33170;
-- Nature Bomb
UPDATE `creature_template` SET `ScriptName` = 'npc_nature_bomb' WHERE `entry` = 34129;
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 194902;
-- Detonating Lasher
UPDATE `creature_template` SET `flags_extra` = 256, `ScriptName` = 'npc_detonating_lasher' WHERE `entry` = 32918;
UPDATE `creature_template` SET `flags_extra` = 256 WHERE `entry` = 33399;
-- Ancient Conservator
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853979, `ScriptName` = 'npc_ancient_conservator' WHERE `entry` = 33203;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853979 WHERE `entry` = 33376;
-- Healthy Spore
UPDATE `creature_template` SET `ScriptName` = 'npc_healthy_spore' WHERE `entry` = 33215;
-- Storm Lasher
UPDATE `creature_template` SET `ScriptName` = 'npc_storm_lasher' WHERE `entry` = 32919;
-- Snaplasher
UPDATE `creature_template` SET `ScriptName` = 'npc_snaplasher' WHERE `entry` = 32916;
-- Ancient Water Spirit
UPDATE `creature_template` SET `ScriptName` = 'npc_ancient_water_spirit' WHERE `entry` = 33202;
-- Cleanup
DELETE FROM `creature` WHERE `guid` = 136607 OR id = 33575;
-- Thorim
UPDATE `creature_template` SET `speed_walk` = 1.66667, `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'boss_thorim' WHERE `entry` = 32865;
UPDATE `creature_template` SET `speed_walk` = 1.66667, `baseattacktime` = 1500, `equipment_id` = 1844, `mechanic_immune_mask` = 650854239 WHERE `entry` = 33147;
DELETE FROM `creature` WHERE `id` = 32865;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(32865, 603, 3, 1, 28977, 0, 2134.967, -298.962, 438.331, 1.57, 604800, 0, 0, 4183500, 425800, 0, 0);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 62042;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(62042, 62470, 1,'Thorim: Deafening Thunder');
-- Charge Orb
DELETE FROM conditions WHERE SourceEntry = 62016;
INSERT INTO `conditions` VALUES
(13, 0, 62016, 0, 18, 1, 33378, 0, 0,'',NULL);
UPDATE `creature_template` SET `unit_flags` = 33685508 WHERE `entry` = 33378;
-- Gate
DELETE FROM `gameobject` WHERE `id` = 194265;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(1000000, 194265, 603, 3, 1, 2173.24, -252.985, 420.146, 5.27078, 0, 0, 1, 0, 7200, 100, 1);
DELETE FROM `gameobject_scripts` WHERE `id` = 1000000;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES 
(1000000, 0, 11, 8151, 15, 0, 0, 0, 0, 0);
DELETE FROM `gameobject_template` WHERE `entry` = 194265;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(194265, 1, 295,'Lever','','','', 0, 16, 3, 0, 0, 0, 0, 0, 0, 0, 0, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0);
UPDATE `gameobject` SET `rotation2` = 1, `rotation3` = 0, `spawntimesecs` = 7200, `animprogress` = 100 WHERE `id` = 194265;
-- Cleanup
DELETE FROM `creature` WHERE `id` IN (32885, 32883, 32908, 32907, 32882, 33110, 32886, 32879, 32892, 33140, 33141, 33378, 32874, 32875);
-- Pre adds
UPDATE `creature_template` SET `equipment_id` = 1849, `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32885;
UPDATE `creature_template` SET `equipment_id` = 1849 WHERE `entry` = 33153;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32883;
UPDATE `creature_template` SET `equipment_id` = 1847 WHERE `entry` = 33152;
UPDATE `creature_template` SET `equipment_id` = 1850, `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32908;
UPDATE `creature_template` SET `equipment_id` = 1850 WHERE `entry` = 33151;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32907;
UPDATE `creature_template` SET `equipment_id` = 1852 WHERE `entry` = 33150;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32882;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32886;
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0 WHERE `entry`IN (33378, 32892);
-- Thorim Mini bosses
UPDATE `creature` SET `phaseMask` = 1 WHERE `id` IN (32872, 32873, 33196);
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_runic_colossus' WHERE `entry` = 32872;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_ancient_rune_giant' WHERE `entry` = 32873;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_sif' WHERE `entry` = 33196;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_arena_phase' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875, 33110);
DELETE FROM `creature_addon` WHERE `guid`IN (136059, 136816);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(136059, 0, 0, 0, 1, 0, 40775),
(136816, 0, 0, 0, 1, 0, 40775);
-- General Vezax
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299803, `flags_extra` = 257, `ScriptName` = 'boss_general_vezax' WHERE `entry` = 33271;
UPDATE `creature_template` SET `baseattacktime` = 1500, `mechanic_immune_mask` = 617299803, `flags_extra` = 257 WHERE `entry` = 33449;
UPDATE `creature_model_info` SET `bounding_radius` = 0.62, `combat_reach` = 12 WHERE `modelid` = 28548;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_saronite_vapors' WHERE `entry` = 33488;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_saronite_animus' WHERE `entry` = 33524;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mechanic_immune_mask` = 650854235 WHERE `entry` IN (33789, 34152);
UPDATE `creature_model_info` SET `bounding_radius` = 0.62, `combat_reach` = 10 WHERE `modelid` = 28992;
-- CleanUp
DELETE FROM creature WHERE id = 33500;
-- Creatures and Gameobjects 25 man spawn
UPDATE `creature` SET `spawnMask` = 3 WHERE `map` = 603;
UPDATE `gameobject` SET `spawnMask` = 3 WHERE `map` = 603;
-- Sara
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'boss_sara' WHERE `entry` IN (33134);
UPDATE creature_model_info SET bounding_radius = 0.465, combat_reach = 45 WHERE modelid = 29117;
UPDATE `creature` SET `spawndist` = 0 WHERE `id` = 33134;
-- Ominous cloud
DELETE FROM `creature` WHERE `id` = 33292;
UPDATE `creature_template` SET `ScriptName` = 'npc_ominous_cloud' WHERE `entry` = 33292;
-- Guardian of Yogg-Saron
UPDATE `creature_template` SET `difficulty_entry_1` = 33968, `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'npc_guardian_yoggsaron' WHERE `entry` = 33136;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 33968;
UPDATE creature_model_info SET bounding_radius = 0.62, combat_reach = 1.5 WHERE modelid = 28465;
-- Yogg-Saron
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_yoggsaron' WHERE `entry` = 33288;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 33955;
UPDATE creature_model_info SET bounding_radius = 0.755, combat_reach = 18 WHERE modelid = 28817;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `speed_walk` = 2, `ScriptName` = 'npc_death_orb' WHERE `entry` = 33882;
-- Brain of Yogg-Saron
UPDATE `creature_template` SET `difficulty_entry_1` = 33954, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_brain_yoggsaron' WHERE `entry` = 33890;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235 WHERE `entry` = 33954;
UPDATE creature_model_info SET bounding_radius = 0.755, combat_reach = 30 WHERE modelid = 28951;
-- Illusions
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'npc_laughing_skull' WHERE `entry` = 33990;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 7, `faction_H` = 7, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_illusion' WHERE `entry` IN (33433, 33716, 33717, 33719, 33720, 33567);
UPDATE creature_model_info SET bounding_radius = 0.306, combat_reach = 1.5 WHERE modelid = 28621;
UPDATE creature_model_info SET bounding_radius = 1, combat_reach = 10 WHERE modelid IN (2718, 1687, 2717, 12869);
-- Influence Tentacle
UPDATE `creature_template` SET `difficulty_entry_1` = 33959, `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 33943;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 33959;
UPDATE creature_model_info SET bounding_radius = 0.306, combat_reach = 1.5 WHERE modelid = 28813;
-- Fake npcs
UPDATE `creature_template` SET ScriptName = "npc_passive_illusion" WHERE `entry` IN (33436, 33437, 33536, 33535, 33495, 33523, 33441, 33442);
-- Whispers
UPDATE `script_texts` SET `type` = 4 WHERE `entry` IN (-1603317, -1603340, -1603339);
-- Descend into madness portal
UPDATE `creature_template` SET `npcflag` = 16777216, `unit_flags` = 2, `type_flags` = 0, `ScriptName` = 'npc_descend_into_madness' WHERE `entry` = 34072;
DELETE FROM `creature_template` WHERE `entry` IN (34122, 34123);
INSERT INTO `creature_template` VALUES
(34122, 0, 0, 0, 0, 0, 29074, 0, 0, 0,'Descend Into Madness','','Interact', 0, 81, 81, 0, 35, 35, 16777216, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,'npc_descend_into_madness', 11159),
(34123, 0, 0, 0, 0, 0, 29074, 0, 0, 0,'Descend Into Madness','','Interact', 0, 81, 81, 0, 35, 35, 16777216, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,'npc_descend_into_madness', 11159);
-- Flee to the Surface
UPDATE `gameobject_template` SET `data10` = 63992 WHERE `entry` = 194625;
DELETE FROM `gameobject` WHERE `id` = 194625;
INSERT INTO `gameobject` VALUES
(NULL, 194625, 603, 3, 1, 1996.41, -0.070, 240.59, 0, 0, 0, 1, 0, 300, 0, 1),
(NULL, 194625, 603, 3, 1, 1949.63, -26.07, 241.25, 0, 0, 0, 1, 0, 300, 0, 1),
(NULL, 194625, 603, 3, 1, 1995.03, -52.98, 241.02, 0, 0, 0, 1, 0, 300, 0, 1);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (34072, 34122, 34123, 33113, 33114, 33118, 33293, 33432, 33651);
INSERT INTO `npc_spellclick_spells` VALUES
(34072, 63989, 0, 0, 0, 3, 0, 0, 0), -- Stormwind
(34122, 63997, 0, 0, 0, 3, 0, 0, 0), -- Chamber
(34123, 63998, 0, 0, 0, 3, 0, 0, 0), -- Icecrown
(33113, 46598, 0, 0, 0, 0, 0, 0, 0), -- Flame Leviathan
(33114, 46598, 0, 0, 0, 0, 0, 0, 0), -- Flame Leviathan Seat
(33118, 46598, 0, 0, 0, 0, 0, 0, 0), -- Ignis
(33293, 46598, 0, 0, 0, 0, 0, 0, 0), -- XT-002
(33432, 46598, 0, 0, 0, 0, 0, 0, 0), -- Leviathan MK II
(33651, 46598, 0, 0, 0, 0, 0, 0, 0); -- VX-001
-- Cancel Illusion Room Aura
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 63992;
INSERT INTO `spell_linked_spell` VALUES
(63992, -63988, 0, "Cancel Illusion Room Aura");
-- Dragon blood
DELETE FROM gameobject WHERE id = 194462;
INSERT INTO gameobject VALUES (NULL, 194462, 603, 3, 1, 2104.35, -25.3753, 242.647, 0, 0, 0, 0, -1, 300, 0, 1);
-- Portals coordinates
DELETE FROM `spell_target_position` WHERE `id` IN (63989, 63992, 63997, 63998);
INSERT INTO `spell_target_position` VALUES
(63989, 603, 1953.91, 21.91, 239.71, 2.08),
(63992, 603, 1980.28, -25.59, 329.40, 3.14),
(63997, 603, 2042.02, -25.54, 239.72, 0),
(63998, 603, 1948.44, -82.04, 239.99, 4.18);
-- Tentacles
UPDATE `creature_template` SET `difficulty_entry_1` = 33984, `faction_A` = 14, `faction_H` = 14, `ScriptName` = "npc_constrictor_tentacle" WHERE `entry` = 33983;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14, `VehicleId` = 385 WHERE `entry` = 33984;
UPDATE creature_model_info SET bounding_radius = 0.306, combat_reach = 1.5 WHERE modelid = 28815;
-- Constrictor vehicle
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 33983;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(33983, 46598, 0, 0, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `difficulty_entry_1` = 33967, `faction_A` = 14, `faction_H` = 14, `baseattacktime` = 1800, `ScriptName` = 'npc_crusher_tentacle' WHERE `entry` = 33966;
UPDATE `creature_template` SET `minlevel` = 81, `maxlevel` = 81, `faction_A` = 14, `faction_H` = 14, `baseattacktime` = 1800 WHERE `entry` = 33967;
UPDATE creature_model_info SET bounding_radius = 0.985, combat_reach = 5 WHERE modelid = 28814;
UPDATE `creature_template` SET `difficulty_entry_1` = 33986, `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'npc_corruptor_tentacle' WHERE `entry` = 33985;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 33986;
-- Immortal Guardian
UPDATE `creature_template` SET `difficulty_entry_1` = 33989, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, `ScriptName` = 'npc_immortal_guardian' WHERE `entry` = 33988;
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235 WHERE `entry` = 33989;
UPDATE creature_model_info SET bounding_radius = 0.92, combat_reach = 4 WHERE modelid = 29024;
-- Remove area stun
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (64059, 65238);
INSERT INTO `spell_linked_spell` VALUES
(64059, 65238, 0, "Shattered illusion remove"),
(65238, -64173, 1, "Shattered illusion remove");
-- Yogg-Saron emotes
DELETE FROM script_texts WHERE `entry` IN (-1603342, -1603343, -1603344);
INSERT INTO script_texts VALUES
(33288, -1603342, "Portals open into Yogg-Saron's mind!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5, 0, 0, "YoggSaron EMOTE_PORTALS"),
(33288, -1603343, "The Illusion shatters and a path to the central chamber opens!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5, 0, 0, "YoggSaron EMOTE_OPEN_CHAMBER"),
(33288, -1603344, "Yogg-Saron prepares to unleash Empowering Shadows!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5, 0, 0, "YoggSaron EMOTE_EMPOWERING");
-- Ulduar Keepers Images
DELETE FROM `creature` WHERE `id` IN (33213, 33241, 33242, 33244);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33241, 603, 3, 1, 0, 0, 2057.81, -24.0768, 421.532, 3.12904, 604800, 0, 0, 14433075, 0, 0, 0),
(33242, 603, 3, 1, 0, 0, 2036.81, -73.7053, 411.353, 2.43575, 604800, 0, 0, 14433075, 0, 0, 0),
(33244, 603, 3, 1, 0, 0, 2036.74, 25.4642, 411.357, 3.81412, 604800, 0, 0, 14433075, 0, 0, 0),
(33213, 603, 3, 1, 0, 0, 1939.29, -90.6994, 411.357, 1.02595, 604800, 0, 0, 14433075, 0, 0, 0);

UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `npcflag` = 1, `flags_extra` = 2, `ScriptName` = 'npc_keeper_image' WHERE `entry` IN (33213, 33241, 33242, 33244);

-- Keepers (Yogg Saron Encounter)
DELETE FROM `creature` WHERE `id` IN (33410, 33411, 33412, 33413);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33410, 603, 3, 1, 0, 0, 2036.739, 25.464, 338.296, 3.814, 604800, 0, 0, 14433075, 0, 0, 0),
(33411, 603, 3, 1, 0, 0, 1939.094, -90.699, 338.296, 1.026, 604800, 0, 0, 14433075, 0, 0, 0),
(33412, 603, 3, 1, 0, 0, 1939.094, 42.534, 338.296, 5.321, 604800, 0, 0, 14433075, 0, 0, 0),
(33413, 603, 3, 1, 0, 0, 2036.739, -73.705, 338.296, 2.435, 604800, 0, 0, 14433075, 0, 0, 0);

UPDATE `creature_template` SET `ScriptName` = 'npc_ys_freya' WHERE `entry` = 33410;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_hodir' WHERE `entry` = 33411;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_mimiron' WHERE `entry` = 33412;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_thorim' WHERE `entry` = 33413;
UPDATE `creature_template` SET `ScriptName` = 'npc_sanity_well' WHERE `entry` = 33991;

-- Death Ray Target
DELETE FROM `conditions` WHERE SourceEntry IN (64172, 64468, 62714, 65209, 64173, 63882, 63886, 62911, 62909, 62533, 62906);
INSERT INTO `conditions` VALUES
(13, 0, 64172, 0, 18, 1, 33988, 0, 0,'','Thorim''s Titanic Storm (Yogg-Saron)'),
(13, 0, 64468, 0, 18, 1, 33288, 0, 0,'','Empowering Shadows (Yogg-Saron)'),
(13, 0, 64468, 0, 18, 1, 33988, 0, 0,'','Empowering Shadows (Yogg-Saron)'),
(13, 0, 64173, 0, 18, 1, 33966, 0, 0,'','Shattered Illusion (Yogg-Saron)'),
(13, 0, 64173, 0, 18, 1, 33983, 0, 0,'','Shattered Illusion (Yogg-Saron)'),
(13, 0, 64173, 0, 18, 1, 33985, 0, 0,'','Shattered Illusion (Yogg-Saron)'),
(13, 0, 63882, 0, 18, 1, 33134, 0, 0,'','Death Ray Warning (Yogg-Saron)'),
(13, 0, 63886, 0, 18, 1, 33134, 0, 0,'','Death Ray Damage (Yogg-Saron)'),
(13, 0, 62714, 0, 18, 1, 33134, 0, 0,'','Shadow Nova (Yogg-Saron)'),
(13, 0, 65209, 0, 18, 1, 33134, 0, 0,'','Shadow Nova (Yogg-Saron)'),
(13, 0, 62911, 0, 18, 1, 33365, 0, 0,'','Thorim Hammer'),
(13, 0, 62909, 0, 18, 1, 33370, 0, 0,'','Mimiron Inferno'),
(13, 0, 62533, 0, 18, 1, 33212, 0, 0,'','Hodirs Fury'),
(13, 0, 62906, 0, 18, 1, 33367, 0, 0,'','Freya Ward');

-- DELETE DOUBLE CACHE SPAWN, THEY ARE SPAWN BY CORE.
DELETE FROM `gameobject` WHERE `id` IN (
194307,  -- Normal
194308,  -- Heroic 10
194200,  -- Normal 25
194201,  -- Heroic 10
195047,  -- Heroic 10
195046); -- Heroic 25
-- Algalon
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1603125 AND -1603106;
INSERT INTO `script_texts` (entry,content_default,sound,TYPE,LANGUAGE,emote,COMMENT) VALUES
(-1603106,'Trans-location complete. Commencing planetary analysis of Azeroth.', 15405, 1, 0, 0,'algalon SAY_INTRO_1'),
(-1603107,'Stand back, mortals. I am not here to fight you.', 15406, 1, 0, 0,'algalon SAY_INTRO_2'),
(-1603108,'It is in the universe\'s best interest to re-originate this planet should my analysis find systemic corruption. Do not interfere.', 15407, 1, 0, 0,'algalon SAY_INTRO_3'),
(-1603109,'See your world through my eyes. A universe so vast as to be immeasurable. Incomprehensible even to your greatest minds.', 15390, 1, 0, 0,'algalon SAY_ENGAGE'),
(-1603110,'Your actions are illogical. All possible results for this encounter have been calculated. The pantheon will receive the observer\'s message regardless outcome.', 15386, 1, 0, 0,'algalon SAY_AGGRO'),
(-1603111,'Loss of life, unavoidable.', 15387, 1, 0, 0,'algalon SAY_SLAY_1'),
(-1603112,'I do what I must.', 15388, 1, 0, 0,'algalon SAY_SLAY_2'),
(-1603113,'The stars come to my aid.', 15392, 1, 0, 0,'algalon SAY_SUMMON_STAR'),
(-1603114,'Witness the fury of cosmos!', 15396, 1, 0, 0,'algalon SAY_BIG_BANG_1'),
(-1603115,'Behold the tools of creation!', 15397, 1, 0, 0,'algalon SAY_BIG_BANG_2'),
(-1603116,'Beware!', 15391, 1, 0, 0,'algalon SAY_PHASE_2'),
(-1603117,'You are... out of time.', 15394, 1, 0, 0,'algalon SAY_BERSERK'),
(-1603118,'Analysis complete. There is partial corruption in the plane\'s life-support systems as well as complete corruption in most of the planet\'s defense mechanisms.', 15398, 1, 0, 0,'algalon SAY_DESPAWN_1'),
(-1603119,'Begin uplink: Reply Code: \'Omega\'. Planetary re-origination requested.', 15399, 1, 0, 0,'algalon SAY_DESPAWN_2'),
(-1603120,'Farewell, mortals. Your bravery is admirable, for such flawed creatures.', 15400, 1, 0, 0,'algalon SAY_DESPAWN_3'),
(-1603121,'I have seen worlds bathed in the Makers\' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?', 15393, 1, 0, 0,'algalon SAY_OUTRO_1'),
(-1603122,'Perhaps it is your imperfection that which grants you free will. That allows you to persevere against cosmically calculated odds. You prevailed where the Titans\' own perfect creations have failed.', 15401, 1, 0, 0,'algalon SAY_OUTRO_2'),
(-1603123,'I\'ve rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore.', 15402, 1, 0, 0,'algalon SAY_OUTRO_3'),
(-1603124,'I lack the strength to transmit this signal. You must hurry. Find a place of power, close to the skies.', 15403, 1, 0, 0,'algalon SAY_OUTRO_4'),
(-1603125,'Do not worry about my fate $n. If the signal is not transmitted in time re-origination will proceed regardless. Save. Your. World.', 15404, 1, 0, 0,'algalon SAY_OUTRO_5');

UPDATE `creature_template` SET `ScriptName` = 'boss_algalon' WHERE entry = 32871;
UPDATE `creature_template` SET `ScriptName` = 'mob_collapsing_star' WHERE entry = 32955;
UPDATE `creature_template` SET `ScriptName` = 'mob_living_constellation' WHERE entry = 33052;
UPDATE `creature_template` SET `ScriptName` = 'mob_black_hole' WHERE entry = 32953;
UPDATE `creature_template` SET `ScriptName` = 'mob_cosmic_smash_target' WHERE `entry` IN (33105, 33104);
UPDATE `gameobject_template` SET `flags` = 6553632, ScriptName= 'go_celestial_acces' WHERE `entry` IN (194628, 194752);

DELETE FROM creature WHERE id = 33167;
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0 WHERE `entry` IN (33364, 33369, 33108, 33366);

UPDATE creature_model_info SET bounding_radius = 15, combat_reach = 10 WHERE modelid IN (29158, 29159, 29160);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 33264; -- TODO
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_flame_leviathan_defense_cannon' WHERE `entry` = 33139;

-- Mimiron modelids
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 7 WHERE `modelid` = 28831;
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 5 WHERE `modelid` = 28841;
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 4 WHERE `modelid` = 28979;

-- Boom Bot
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 33836);
INSERT INTO `smart_scripts` VALUES
(33836, 0, 0, 1, 9, 0, 100, 1, 0, 2, 0, 0, 11, 63801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Boom Bot - Explode'),
(33836, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Boom Bot - despawn');
-- Leviathan Doors
DELETE FROM `gameobject` WHERE `id` = 194905;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194905, 603, 1, 1, 401.308, -13.8236, 409.524, 3.14159, 0, 0, 0, 1, 180, 255, 0);
-- Thorim\'s Hammer

UPDATE `creature_template` SET `speed_walk` = 2 WHERE `entry` IN (33370, 33212);
DELETE FROM creature WHERE guid IN (137479, 137480);
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 34114;
-- XT-002 correct vehicle id
UPDATE `creature_template` SET `VehicleId` = 353 WHERE `entry` = 33293;
-- Gravity Bomb
-- Salvaged Chopper has faction dependent modelid
UPDATE `creature_template` SET `modelid2` = 0 WHERE `entry` = 33062;
-- Sanctum Sentry 25 damage nerf
UPDATE `creature_template` SET `dmg_multiplier` = 35 WHERE `entry` = 34166;
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (33293, 30000, 33113, 32930);
INSERT INTO `vehicle_template_accessory` VALUES
(33293, 33329, 0, 1,'XT-002 Hearth', 6, 30000),
(33113, 33114, 0, 1,'Flame Leviathan', 6, 30000),
(33113, 33114, 1, 1,'Flame Leviathan', 6, 30000),
(33113, 33114, 2, 1,'Flame Leviathan', 6, 30000),
(33113, 33114, 3, 1,'Flame Leviathan', 6, 30000),
(33113, 33139, 7, 1,'Flame Leviathan', 6, 30000),
(32930, 32933, 0, 1,'Kologarn - Left Arm', 6, 30000),
(32930, 32934, 1, 1,'Kologarn - Right Arm', 6, 30000);
-- For Achievement Champion/Conqueror of Ulduar
DELETE FROM `achievement_criteria_data` WHERE `type` = 18 AND `criteria_id` IN (
10042, 10342, 10340, 10341, 10598, 10348, 10351, 10439, 10403, 10582, 10347, 10349, 10350,
10352, 10355, 10353, 10354, 10599, 10357, 10363, 10719, 10404, 10583, 10361, 10362, 10364,
10321, 10322, 10323, 10324, 10325, 10326, 10568, 10570);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(10042, 18, 0, 0,''), (10342, 18, 0, 0,''),
(10340, 18, 0, 0,''), (10341, 18, 0, 0,''),
(10598, 18, 0, 0,''), (10348, 18, 0, 0,''),
(10351, 18, 0, 0,''), (10439, 18, 0, 0,''),
(10403, 18, 0, 0,''), (10582, 18, 0, 0,''),
(10347, 18, 0, 0,''), (10349, 18, 0, 0,''),
(10350, 18, 0, 0,''), (10352, 18, 0, 0,''),
(10355, 18, 0, 0,''), (10353, 18, 0, 0,''),
(10354, 18, 0, 0,''), (10599, 18, 0, 0,''),
(10357, 18, 0, 0,''), (10363, 18, 0, 0,''),
(10719, 18, 0, 0,''), (10404, 18, 0, 0,''),
(10583, 18, 0, 0,''), (10361, 18, 0, 0,''),
(10362, 18, 0, 0,''), (10364, 18, 0, 0,''),
(10321, 18, 0, 0,''), (10322, 18, 0, 0,''),
(10323, 18, 0, 0,''), (10324, 18, 0, 0,''),
(10325, 18, 0, 0,''), (10326, 18, 0, 0,''),
(10568, 18, 0, 0,''), (10570, 18, 0, 0,'');
-- delete from disables, now is working
DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` IN (
10042, 10342, 10340, 10341, 10598, 10348, 10351, 10439, 10403, 10582, 10347, 10349, 10350,
10352, 10355, 10353, 10354, 10599, 10357, 10363, 10719, 10404, 10583, 10361, 10362, 10364,
10321, 10322, 10323, 10324, 10325, 10326, 10568, 10570);
-- */
-- Provisional SmarAI, later will be add in Full DataBase.
-- Runeforged Sentry
UPDATE `creature_template` SET `spell1` = 64852, `spell2` = 64870, `spell3` = 64847, `AIName` = 'SmartAI' WHERE `entry` = 34234;
UPDATE `creature_template` SET `spell1` = 64852, `spell2` = 64870, `spell3` = 64847 WHERE `entry` = 34235;
-- Steelforged Defender
UPDATE `creature_template` SET `spell1` = 62845, `spell2` = 57780, `spell3` = 50370, `AIName` = 'SmartAI' WHERE `entry` = 33236;
UPDATE `creature_template` SET `spell1` = 62845, `spell2` = 57780, `spell3` = 50370 WHERE `entry` = 34113;
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id` IN (33236, 33838);
-- Mechagnome Battletank
UPDATE `creature_template` SET `spell1` = 64693, `spell2` = 64953, `AIName` = 'SmartAI' WHERE `entry` = 34164;
UPDATE `creature_template` SET `spell1` = 64693, `spell2` = 64953 WHERE `entry` = 34165;
-- Ulduar Colossus
UPDATE `creature_template` SET `spell1` = 62625, `AIName` = 'SmartAI' WHERE `entry` = 33237;
UPDATE `creature_template` SET `spell1` = 62625 WHERE `entry` = 34105;
-- Invisible triggers
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (33377, 33742, 34286, 33500, 33406, 33575);
-- Molten Colossus
UPDATE `creature_template` SET `spell1` = 64697, `spell2` = 64698, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34069;
UPDATE `creature_template` SET `spell1` = 64697, `spell2` = 64698, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34185;
-- Magma Rager
UPDATE `creature_template` SET `spell1` = 64773, `spell2` = 64746, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34086;
UPDATE `creature_template` SET `spell1` = 64773, `spell2` = 64746, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34201;
UPDATE `creature_template` SET `unit_flags` = 33718790, modelid1 = 11686, modelid2 = 0, `spell1` = 64724, `AIName` = 'SmartAI' WHERE `entry` = 34194;
-- Forge Construct
UPDATE `creature_template` SET `spell1` = 64719, `spell2` = 64720, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34085;
UPDATE `creature_template` SET `spell1` = 64719, `spell2` = 64721, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34186;
-- XB-488 Disposalbot
UPDATE `creature_template` SET `spell1` = 65080, `spell2` = 65084, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34273;
UPDATE `creature_template` SET `spell1` = 65104, `spell2` = 65084, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34274;
-- Parts Recovery Technician
UPDATE `creature_template` SET `spell1` = 65071, `spell2` = 65070, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554432, `AIName` = 'SmartAI' WHERE `entry` = 34267;
UPDATE `creature_template` SET `spell1` = 65071, `spell2` = 65070, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554432 WHERE `entry` = 34268;
-- XD-175 Compactobot
UPDATE `creature_template` SET `spell1` = 65073, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34271;
UPDATE `creature_template` SET `spell1` = 65106, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34272;
UPDATE `creature_template` SET `mingold` = 7100, `maxgold` = 7600 WHERE `entry` = 34269;
-- Lightning Charged Iron Dwarf
UPDATE `creature_template` SET `spell1` = 64889, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34199;
UPDATE `creature_template` SET `spell1` = 64975, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34237;
-- Hardened Iron Golem
UPDATE `creature_template` SET `spell1` = 64877, `spell2` = 64874, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 34190;
UPDATE `creature_template` SET `spell1` = 64877, `spell2` = 64967, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 34229;
-- Iron Mender
UPDATE `creature_template` SET `spell1` = 64918, `spell2` = 64903, `spell3` = 64897, `mechanic_immune_mask` = 33554496, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34198;
UPDATE `creature_template` SET `spell1` = 64971, `spell2` = 64970, `spell3` = 64968, `mechanic_immune_mask` = 33554496, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34236;
-- Rune Etched Sentry
UPDATE `creature_template` SET `spell1` = 64852, `spell2` = 64870, `spell3` = 64847, `mechanic_immune_mask` = 33554496, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34196;
UPDATE `creature_template` SET `spell1` = 64852, `spell2` = 64870, `spell3` = 64847, `mechanic_immune_mask` = 33554496, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34245;
-- Chamber Overseer
UPDATE `creature_template` SET `spell1` = 64820, `spell2` = 64825, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 34197;
UPDATE `creature_template` SET `spell1` = 64943, `spell2` = 64944, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 34226;
-- Storm Tempered Keeper
UPDATE `creature_template` SET `spell1` = 63541, `spell2` = 63630, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` IN (33722, 33699);
UPDATE `creature_template` SET `spell1` = 63541, `spell2` = 63630, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` IN (33723, 33700);
-- Champion of Hodir
UPDATE `creature_template` SET `spell1` = 64639, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34133;
UPDATE `creature_template` SET `spell1` = 64652, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34139;
-- Winter Jormungar
UPDATE `creature_template` SET `spell1` = 64638, `AIName` = 'SmartAI' WHERE `entry` = 34137;
UPDATE `creature_template` SET `spell1` = 64638 WHERE `entry` = 34140;
-- Winter Revenant
UPDATE `creature_template` SET `spell1` = 64642, `spell2` = 64643, `spell3` = 64644, `mechanic_immune_mask` = 33554496, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 34134;
UPDATE `creature_template` SET `spell1` = 64653, `spell2` = 64643, `spell3` = 64644, `mechanic_immune_mask` = 33554496, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 34141;
-- Winter Rumbler
UPDATE `creature_template` SET `spell1` = 64645, `spell2` = 64647, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 34135;
UPDATE `creature_template` SET `spell1` = 64645, `spell2` = 64654, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 34142;
-- Guardian Lasher
UPDATE `creature_template` SET `spell1` = 63007, `spell2` = 63047, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 33430;
UPDATE `creature_template` SET `spell1` = 63007, `spell2` = 63550, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 33732;
-- Forest Swarmer
UPDATE `creature_template` SET `spell1` = 63059, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33431;
UPDATE `creature_template` SET `spell1` = 63059, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33731;
DELETE FROM `conditions` WHERE `SourceEntry` = 63059;
-- Guardian of Life
UPDATE `creature_template` SET `spell1` = 63226, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33528;
UPDATE `creature_template` SET `spell1` = 63551, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33733;
-- Nature's Blade
UPDATE `creature_template` SET `spell1` = 63247, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33527;
UPDATE `creature_template` SET `spell1` = 63568, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33741;
-- Ironroot Lasher
UPDATE `creature_template` SET `spell1` = 63240, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33526;
UPDATE `creature_template` SET `spell1` = 63553, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33734;
-- Mangrove Ent
UPDATE `creature_template` SET `spell1` = 63272, `spell2` = 63242, `spell3` = 63241, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33525;
UPDATE `creature_template` SET `spell1` = 63272, `spell2` = 63556, `spell3` = 63554, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33735;
-- Misguided Nymph
UPDATE `creature_template` SET `spell1` = 63082, `spell2` = 63111, `spell3` = 63136, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33355;
UPDATE `creature_template` SET `spell1` = 63559, `spell2` = 63562, `spell3` = 63564, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33737;
-- Corrupted Servitor
UPDATE `creature_template` SET `spell1` = 63169, `spell2` = 63149, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 33354;
UPDATE `creature_template` SET `spell1` = 63549, `spell2` = 63149, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 33729;
-- Arachnopod Destroyer
UPDATE `creature_template` SET `spell1` = 64717, `spell2` = 64776, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 34183;
UPDATE `creature_template` SET `spell1` = 64717, `spell2` = 64776, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 34214;
-- Boomer XP-500
UPDATE `creature_template` SET `spell1` = 55714, `AIName` = 'SmartAI' WHERE `entry` = 34192;
UPDATE `creature_template` SET `spell1` = 55714 WHERE `entry` = 34216;
-- Clockwork Sapper
UPDATE `creature_template` SET `spell1` = 64740, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'SmartAI' WHERE `entry` = 34193;
UPDATE `creature_template` SET `spell1` = 64740, `mingold` = 14200, `maxgold` = 15600, `mechanic_immune_mask` = 33554496 WHERE `entry` = 34220;
-- Twilight Adherent
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63760, `spell3` = 13704, `equipment_id` = 1848, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33818;
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63760, `spell3` = 13704, `equipment_id` = 1848, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33827;
-- Twilight Guardian
UPDATE `creature_template` SET `spell1` = 52719, `spell2` = 62317, `spell3` = 63757, `mechanic_immune_mask` = 33554513, `equipment_id` = 1852, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33822;
UPDATE `creature_template` SET `spell1` = 52719, `spell2` = 62317, `spell3` = 63757, `mechanic_immune_mask` = 33554513, `equipment_id` = 1852, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33828;
-- Twilight Shadowblade
UPDATE `creature_template` SET `spell1` = 63753, `mechanic_immune_mask` = 33554513, `equipment_id` = 1862, `baseattacktime` = 1000, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33824;
UPDATE `creature_template` SET `spell1` = 63753, `mechanic_immune_mask` = 33554513, `equipment_id` = 1862, `baseattacktime` = 1000, `mingold` = 7100, `maxgold` = 7600 WHERE `entry` = 33831;
-- Twilight Slayer
UPDATE `creature_template` SET `spell1` = 63784, `spell2` = 35054, `mechanic_immune_mask` = 33554513, `equipment_id` = 1847, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33823;
UPDATE `creature_template` SET `spell1` = 63784, `spell2` = 35054, `mechanic_immune_mask` = 33554513, `equipment_id` = 1847, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33832;
UPDATE `creature_template` SET `equipment_id` = 1849 WHERE `entry` = 32885;
UPDATE `creature_template` SET `equipment_id` = 1850 WHERE `entry` = 32908;
-- Faceless Horror
UPDATE `creature_template` SET `spell1` = 64429, `spell2` = 63722, `spell3` = 63710, `spell4` = 63703, `mechanic_immune_mask` = 33554513, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33772;
UPDATE `creature_template` SET `spell1` = 64429, `spell2` = 63722, `spell3` = 63710, `spell4` = 63703, `mechanic_immune_mask` = 33554513, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33773;
-- Twilight Pyromancer
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63789, `spell3` = 63775, `equipment_id` = 1848, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33820;
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63789, `spell3` = 63775, `equipment_id` = 1848, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33830;
-- Enslaved Fire Elemental
UPDATE `creature_template` SET `spell1` = 38064, `spell2` = 63778, `mechanic_immune_mask` = 33554513, `AIName` = 'SmartAI' WHERE `entry` = 33838;
-- Boom Bot
UPDATE `creature_template` SET `spell1` = 63801, `AIName` = 'SmartAI' WHERE `entry` = 33836;
UPDATE `creature_template` SET `spell1` = 63801 WHERE `entry` = 34218;
-- Twilight Frost Mage
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63758, `spell3` = 63912, `spell4` = 63913, `equipment_id` = 1849, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'SmartAI' WHERE `entry` = 33819;
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63758, `spell3` = 63912, `spell4` = 63913, `equipment_id` = 1849, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `mingold` = 14200, `maxgold` = 15600 WHERE `entry` = 33829;
-- Rubble
UPDATE `creature_template` SET `spell1` = 38064, `AIName` = 'SmartAI' WHERE `entry` = 33768;
UPDATE `creature_template` SET `spell1` = 63978 WHERE `entry` = 33908;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (
33526, 33525, 33354, 34183, 33819, 33820, 33768, 33836, 33527, 33838, 33772, 33431, 33823, 33824, 33822,
33818, 34197, 34193, 34192, 33355, 34198, 33528, 33430, 34135, 34134, 34137, 34133, 33699, 33722, 34196,
34190, 34267, 34271, 34199, 34273, 34085, 34194, 34086, 34069, 33237, 34164, 33236, 34234);
INSERT INTO `smart_scripts` VALUES
(34234, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 10000, 10000, 11, 64852, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Runeforged Sentry - Cast Flaming Rune'),
(34234, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 11, 64870, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Runeforged Sentry - Cast Lava Burst'),
(34234, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 12000, 12000, 11, 64847, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Runeforged Sentry - Cast Runed Flame Jets'),
(33236, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 15000, 20000, 11, 62845, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Steelforged Defender - Cast Hamstring'),
(33236, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 6000, 8000, 11, 57780, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Steelforged Defender - Cast Lightning Bolt'),
(33236, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 4000, 6000, 11, 50370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Steelforged Defender - Cast Sunder Armor'),
(34164, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 6000, 8000, 11, 64693, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Mechagnome Battletank - Cast Flame Cannon'),
(34164, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 15000, 20000, 11, 64953, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,'Mechagnome Battletank - Cast Jump Attack'),
(33237, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 62625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Ulduar Colossus - Cast Ground Slam'),
(34069, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 10000, 12000, 11, 64697, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Molten Colossus - Cast Earthquake'),
(34069, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 15000, 20000, 11, 64698, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Molten Colossus - Cast Pyroblast'),
(34086, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 6000, 8000, 11, 64773, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Magma Rager - Cast Fire Blast'),
(34086, 0, 1, 0, 0, 0, 100, 0, 8000, 16000, 15000, 25000, 11, 64746, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Magma Rager - Cast Superheated winds'),
(34194, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 10000, 10000, 11, 64724, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Superheated Winds'),
(34085, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 10000, 16000, 11, 64719, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,'Forge Construct - Cast Charge'),
(34085, 0, 1, 0, 0, 0, 100, 2, 2000, 6000, 6000, 8000, 11, 64720, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Forge Construct - Cast Flame Emission 10'),
(34085, 0, 2, 0, 0, 0, 100, 4, 2000, 6000, 6000, 8000, 11, 64721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Forge Construct - Cast Flame Emission 25'),
-- (34273, 0, 0, 0, 2, 0, 100, 0, 30, 20, 0, 0, 11, 65084, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'XB-488 Disposalbot - Cast Self Destruct'),
(34273, 0, 1, 0, 0, 0, 100, 2, 2000, 6000, 10000, 15000, 11, 65080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'XB-488 Disposalbot - Cast Cut Scrap Metal 10'),
(34273, 0, 2, 0, 0, 0, 100, 4, 2000, 6000, 10000, 15000, 11, 65104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'XB-488 Disposalbot - Cast Cut Scrap Metal 25'),
(34267, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 10000, 15000, 11, 65071, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,'Parts Recovery Technician - Cast Mechano Kick'),
(34267, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 20000, 25000, 11, 65070, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Parts Recovery Technician - Cast Defense Matrix'),
(34271, 0, 0, 0, 0, 0, 100, 2, 8000, 12000, 15000, 20000, 11, 65073, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,'XD-175 Compactobot - Cast Trash Compactor 10'),
(34271, 0, 1, 0, 0, 0, 100, 4, 8000, 12000, 15000, 20000, 11, 65106, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,'XD-175 Compactobot - Cast Trash Compactor 25'),
(34199, 0, 0, 0, 0, 0, 100, 2, 1000, 2000, 10000, 15000, 11, 64889, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Lightning Charged Iron Dwarf - Cast Lightning Charged 10'),
(34199, 0, 1, 0, 0, 0, 100, 4, 1000, 2000, 10000, 15000, 11, 64975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Lightning Charged Iron Dwarf - Cast Lightning Charged 25'),
(34190, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 25000, 30000, 11, 64877, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Hardened Iron Golem - Cast Harden Fists'),
(34190, 0, 1, 0, 0, 0, 100, 2, 5000, 7000, 20000, 30000, 11, 64874, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Hardened Iron Golem - Cast Rune Punch 10'),
(34190, 0, 2, 0, 0, 0, 100, 4, 5000, 7000, 20000, 30000, 11, 64967, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Hardened Iron Golem - Cast Rune Punch 25'),
(34198, 0, 0, 0, 0, 0, 100, 2, 2000, 4000, 4000, 6000, 11, 64918, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Iron Mender - Cast Electro Shock 10'),
(34198, 0, 1, 0, 0, 0, 100, 4, 2000, 4000, 4000, 6000, 11, 64971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Iron Mender - Cast Electro Shock 25'),
(34198, 0, 2, 0, 0, 0, 100, 2, 3000, 6000, 10000, 15000, 11, 64903, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Iron Mender - Cast Fuse Lightning 10'),
(34198, 0, 3, 0, 0, 0, 100, 4, 3000, 6000, 10000, 15000, 11, 64970, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Iron Mender - Cast Fuse Lightning 25'),
(34198, 0, 4, 0, 0, 0, 100, 2, 10000, 25000, 30000, 45000, 11, 64897, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Iron Mender - Cast Fuse Metal 10'),
(34198, 0, 5, 0, 0, 0, 100, 4, 10000, 25000, 30000, 45000, 11, 64968, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Iron Mender - Cast Fuse Metal 25'),
(34196, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 10000, 10000, 11, 64852, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Rune Etched Sentry - Cast Flaming Rune'),
(34196, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 11, 64870, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Rune Etched Sentry - Cast Lava Burst'),
(34196, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 12000, 15000, 11, 64847, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Rune Etched Sentry - Cast Runed Flame Jets'),
(34197, 0, 0, 0, 0, 0, 100, 2, 4000, 8000, 6000, 8000, 11, 64820, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Chamber Overseer - Cast Devastating Leap 10'),
(34197, 0, 1, 0, 0, 0, 100, 4, 4000, 8000, 6000, 8000, 11, 64943, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Chamber Overseer - Cast Devastating Leap 25'),
(34197, 0, 2, 0, 0, 0, 100, 2, 10000, 12000, 8000, 12000, 11, 64825, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Chamber Overseer - Cast Staggering Roar 10'),
(34197, 0, 3, 0, 0, 0, 100, 4, 10000, 12000, 8000, 12000, 11, 64944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Chamber Overseer - Cast Staggering Roar 25'),
(33722, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 75, 63630, 33699, 0, 0, 0, 0, 11, 33699, 50, 0, 0, 0, 0, 0,'Storm Tempered Keeper - Cast Vengeful Surge on death'),
(33722, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 10000, 15000, 11, 63541, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Storm Tempered Keeper - Cast Forked Lightning'),
(33722, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 11, 63539, 0, 0, 0, 0, 0, 9, 33699, 15, 50, 0, 0, 0, 0,'Storm Tempered Keeper - Cast Separation Anxiety if separated'),
(33699, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 75, 63630, 33722, 0, 0, 0, 0, 11, 33722, 50, 0, 0, 0, 0, 0,'Storm Tempered Keeper - Cast Vengeful Surge on death'),
(33699, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 10000, 15000, 11, 63541, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Storm Tempered Keeper - Cast Forked Lightning'),
(33699, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 11, 63539, 0, 0, 0, 0, 0, 9, 33722, 15, 50, 0, 0, 0, 0,'Storm Tempered Keeper - Cast Separation Anxiety if separated'),
(34133, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 12000, 16000, 11, 64639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Champion of Hodir - Cast Stomp 10'),
(34133, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 12000, 16000, 11, 64652, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Champion of Hodir - Cast Stomp 25'),
(34137, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 9000, 11, 64638, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Winter Jormungar - Cast Acidic Bite'),
(34134, 0, 0, 0, 0, 0, 100, 2, 8000, 12000, 15000, 20000, 11, 64642, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Winter Revenant - Cast Blizzard 10'),
(34134, 0, 1, 0, 0, 0, 100, 4, 8000, 12000, 15000, 20000, 11, 64653, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Winter Revenant - Cast Blizzard 25'),
(34134, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 10000, 12000, 11, 64643, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Winter Revenant - Cast Whirling Strike'),
(34134, 0, 3, 0, 0, 0, 100, 0, 15000, 20000, 60000, 75000, 11, 64644, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Winter Revenant - Cast Shield of the Winter Revenant'),
(34135, 0, 0, 0, 0, 0, 100, 0, 6000, 12000, 10000, 16000, 11, 64645, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Winter Rumbler - Cast Cone of Cold'),
(34135, 0, 1, 0, 0, 0, 100, 2, 3000, 6000, 8000, 12000, 11, 64647, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Winter Rumbler - Cast Snow Blindness 10'),
(34135, 0, 2, 0, 0, 0, 100, 4, 3000, 6000, 8000, 12000, 11, 64654, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Winter Rumbler - Cast Snow Blindness 25'),
(33430, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 75, 63007, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Guardian Lasher - Cast Guardian Pheromones on aggro'),
(33430, 0, 1, 0, 0, 0, 100, 2, 3000, 6000, 8000, 12000, 11, 63047, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Guardian Lasher - Cast Guardian''s Lash 10'),
(33430, 0, 2, 0, 0, 0, 100, 4, 3000, 6000, 8000, 12000, 11, 63550, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Guardian Lasher - Cast Guardian''s Lash 25'),
(33431, 0, 0, 0, 0, 0, 100, 0, 3000, 9000, 10000, 20000, 11, 63059, 0, 0, 0, 0, 0, 11, 33430, 40, 0, 0, 0, 0, 0,'Forest Swarmer - Cast Pollinate'),
(33528, 0, 0, 0, 0, 0, 100, 2, 3000, 9000, 15000, 20000, 11, 63226, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Guardian of Life - Cast Poison Breath 10'),
(33528, 0, 1, 0, 0, 0, 100, 4, 3000, 9000, 15000, 20000, 11, 63551, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Guardian of Life - Cast Poison Breath 25'),
(33527, 0, 0, 0, 0, 0, 100, 2, 3000, 9000, 18000, 24000, 11, 63247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nature Blade - Cast Living Tsunami 10'),
(33527, 0, 1, 0, 0, 0, 100, 4, 3000, 9000, 18000, 24000, 11, 63568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nature Blade - Cast Living Tsunami 25'),
(33526, 0, 0, 0, 0, 0, 100, 2, 3000, 8000, 12000, 16000, 11, 63240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Ironroot Lasher - Cast Ironroot Thorns 10'),
(33526, 0, 1, 0, 0, 0, 100, 4, 3000, 8000, 12000, 16000, 11, 63553, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Ironroot Lasher - Cast Ironroot Thorns 25'),
(33525, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 16000, 20000, 11, 63272, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Mangrove Ent - Cast Hurricane'),
(33525, 0, 1, 0, 0, 0, 100, 2, 4000, 6000, 12000, 16000, 11, 63242, 0, 0, 0, 0, 0, 11, 0, 30, 0, 0, 0, 0, 0,'Mangrove Ent - Cast Nourish 10'),
(33525, 0, 2, 0, 0, 0, 100, 4, 4000, 6000, 12000, 16000, 11, 63556, 0, 0, 0, 0, 0, 11, 0, 30, 0, 0, 0, 0, 0,'Mangrove Ent - Cast Nourish 25'),
(33525, 0, 3, 0, 0, 0, 100, 2, 20000, 25000, 20000, 25000, 11, 63241, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Mangrove Ent - Cast Tranquility 10'),
(33525, 0, 4, 0, 0, 0, 100, 4, 20000, 25000, 20000, 25000, 11, 63554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Mangrove Ent - Cast Tranquility 25'),
(33355, 0, 0, 0, 0, 0, 100, 2, 8000, 12000, 16000, 20000, 11, 63082, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Misguided Nymph - Cast Bind Life 10'),
(33355, 0, 1, 0, 0, 0, 100, 4, 8000, 12000, 16000, 20000, 11, 63559, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Misguided Nymph - Cast Bind Life 25'),
(33355, 0, 2, 0, 0, 0, 100, 2, 4000, 6000, 12000, 16000, 11, 63111, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Misguided Nymph - Cast Frost Spear 10'),
(33355, 0, 3, 0, 0, 0, 100, 4, 4000, 6000, 12000, 16000, 11, 63562, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Misguided Nymph - Cast Frost Spear 25'),
(33355, 0, 4, 0, 0, 0, 100, 2, 15000, 20000, 15000, 20000, 11, 63136, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Misguided Nymph - Cast Winter''s Embrace 10'),
(33355, 0, 5, 0, 0, 0, 100, 4, 15000, 20000, 15000, 20000, 11, 63564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Misguided Nymph - Cast Winter''s Embrace 25'),
(33354, 0, 0, 0, 0, 0, 100, 2, 2000, 4000, 16000, 20000, 11, 63169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Corrupted Servitor - Cast Petrify Joints 10'),
(33354, 0, 1, 0, 0, 0, 100, 4, 2000, 4000, 16000, 20000, 11, 63549, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Corrupted Servitor - Cast Petrify Joints 25'),
(33354, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 12000, 16000, 11, 63149, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Corrupted Servitor - Cast Violent Earth'),
(34183, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 12000, 16000, 11, 64717, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Arachnopod Destroyer - Cast Flame Spray'),
(34183, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 12000, 16000, 11, 64776, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Arachnopod Destroyer - Cast Machine Gun'),
(34192, 0, 0, 0, 9, 0, 100, 0, 0, 2, 1000, 1000, 11, 55714, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Boomer XP-500 - Explode'),
(34193, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 12000, 16000, 11, 64740, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Clockwork Sapper - Cast Energy Sap'),
(33818, 0, 0, 0, 0, 0, 100, 0, 10000, 16000, 16000, 20000, 11, 64663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Adherent - Cast Arcane Burst'),
(33818, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 16000, 20000, 11, 63760, 0, 0, 0, 0, 0, 11, 0, 30, 0, 0, 0, 0, 0,'Twilight Adherent - Cast Greater Heal'),
(33818, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 15000, 18000, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Adherent - Cast Psychic Scream'),
(33822, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 8000, 10000, 11, 52719, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Twilight Guardian - Cast Concussion Blow'),
(33822, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 3000, 6000, 11, 62317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Twilight Guardian - Cast Devastate'),
(33822, 0, 2, 0, 0, 0, 100, 0, 8000, 10000, 14000, 16000, 11, 63757, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Guardian - Cast Thunderclap'),
(33824, 0, 0, 0, 0, 0, 100, 0, 6000, 8000, 12000, 16000, 11, 63753, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Shadowblade - Cast Fan of Knives'),
(33823, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 12000, 16000, 11, 35054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Twilight Slayer - Cast Mortal Strike'),
(33823, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 20000, 25000, 11, 63784, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Slayer - Cast Bladestorm'),
(33772, 0, 0, 0, 0, 0, 100, 0, 18000, 20000, 16000, 20000, 11, 64429, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,'Faceless Horror - Cast Death Grip'),
(33772, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 10000, 12000, 11, 63722, 0, 0, 0, 0, 0, 17, 10, 40, 0, 0, 0, 0, 0,'Faceless Horror - Cast Shadow Crash'),
(33772, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 75, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Faceless Horror - add aura Void Wave on aggro'),
(33819, 0, 0, 0, 0, 0, 100, 0, 10000, 16000, 16000, 20000, 11, 64663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Frost Mage - Cast Arcane Burst'),
(33819, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 6000, 8000, 11, 63913, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Twilight Frost Mage - Cast Frostbolt'),
(33819, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 10000, 16000, 11, 63758, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Frost Mage - Cast Frost Bolt Volley'),
(33819, 0, 3, 0, 0, 0, 100, 0, 8000, 10000, 12000, 16000, 11, 63912, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Frost Mage - Cast Frost Nova'),
(33820, 0, 0, 0, 0, 0, 100, 0, 10000, 16000, 16000, 20000, 11, 64663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Twilight Pyromancer - Cast Arcane Burst'),
(33820, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 6000, 8000, 11, 63789, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Twilight Pyromancer - Cast Fireball'),
(33820, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 10000, 16000, 11, 63775, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0,'Twilight Pyromancer - Cast Flamestrike'),
(33838, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 10000, 14000, 11, 38064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Enslaved Fire Elemental - Cast Blast Wave'),
(33838, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 75, 63778, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Enslaved Fire Elemental - Cast Fire Shield on aggro'),
(33836, 0, 0, 0, 9, 0, 100, 0, 0, 2, 1000, 1000, 11, 63801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Boom Bot - Explode'),
(33836, 0, 0, 1, 9, 0, 100, 1, 0, 2, 0, 0, 11, 63801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Boom Bot - Explode'),
(33836, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Boom Bot - despawn'),
(33768, 0, 0, 0, 0, 0, 100, 2, 4000, 8000, 10000, 12000, 11, 38064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Rubble - Cast Stone Nova 10'),
(33768, 0, 1, 0, 0, 0, 100, 4, 4000, 8000, 10000, 12000, 11, 63978, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Rubble - Cast Stone Nova 25');
-- -------------------------------------------------------------------------}
-- ----------------------------- Ruby Sanctum ------------------------------
-- -------------------------------------------------------------------------{
DELETE FROM `spell_script_names` WHERE `spell_id` IN (74562, 74792, 74768);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(74562,'spell_halion_fiery_combustion'),
(74792,'spell_halion_soul_consumption'),
(74768,'spell_twilight_cutter');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 74455;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(13, 0, 74455, 0, 18, 1, 39747, 0, 0,'','Ragefire - Conflagration');

UPDATE `instance_template` SET `Script` = 'instance_ruby_sanctum' WHERE `map` = 724;
UPDATE `creature_template` SET `ScriptName` = 'mob_orb_rotation_focus', `AIName` = '' WHERE `entry` = 40091;
UPDATE `creature_template` SET `ScriptName` = 'mob_fiery_combustion', `AIName` = '' WHERE `entry` = 40001;
UPDATE `creature_template` SET `ScriptName` = 'mob_soul_consumption', `AIName` = '' WHERE `entry` = 40135;
UPDATE `creature_template` SET `ScriptName` = 'mob_flamecaller_ruby', `AIName` = '' WHERE `entry` = 39814;
UPDATE `creature_template` SET `ScriptName` = 'boss_halion_twilight', `AIName` = '' WHERE `entry` = 40142;
UPDATE `creature_template` SET `ScriptName` = 'mob_halion_control', `AIName` = '' WHERE `entry` = 40146;
UPDATE `creature_template` SET `ScriptName` = 'mob_halion_meteor', `AIName` = '' WHERE `entry` = 40029;
UPDATE `creature_template` SET `ScriptName` = 'boss_halion_real', `AIName` = '' WHERE `entry` = 39863;
UPDATE `creature_template` SET `ScriptName` = 'mob_halion_flame', `AIName` = '' WHERE `entry` = 40041;
UPDATE `creature_template` SET `ScriptName` = 'mob_halion_orb', `AIName` = '' WHERE `entry` IN (40083, 40100);
UPDATE `creature_template` SET `ScriptName` = 'mob_orb_carrier', `AIName` = '' WHERE `entry` = 40081;
UPDATE `creature_template` SET `ScriptName` = 'boss_zarithrian', `AIName` = '' WHERE `entry` = 39746;
UPDATE `creature_template` SET `ScriptName` = 'mob_xerestrasza', `AIName` = '' WHERE `entry` = 40429;
UPDATE `creature_template` SET `ScriptName` = 'boss_ragefire', `AIName` = '' WHERE `entry` = 39747;
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus', `AIName` = '', `dmg_multiplier` = 80  WHERE `entry` = 39751;
UPDATE `creature_template` SET `ScriptName` = 'mob_baltharus_clone', `AIName` = '', `dmg_multiplier` = 80  WHERE `entry` = 39899;
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = '' WHERE `entry` IN (40143, 40144, 40145);

UPDATE `gameobject_template` SET `data10` = 74807, `faction` = 0, `ScriptName` = 'go_halion_portal_twilight' WHERE `gameobject_template`.`entry` IN (202794, 202795);
UPDATE `gameobject_template` SET `faction` = 0, `ScriptName` = 'go_halion_portal_real' WHERE `gameobject_template`.`entry` IN (202796);

UPDATE `creature` SET `position_x` = 3008.552734,`position_y` = 530.471680,`position_z` = 89.195290,`orientation` = 6.16 WHERE `id` = 39746;
DELETE FROM `creature` WHERE `id` = 39863;

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1666008 AND -1666000 OR `entry` BETWEEN -1666113 AND -1666100 OR `entry` BETWEEN -1666204 AND -1666200 OR `entry` BETWEEN -1666305 AND -1666300 OR `entry` BETWEEN -1666405 AND -1666400;
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(40429, -1666000,'Help! I am trapped within this tree! I require aid!', 17490, 6, 0, 0,'SAY_XERESTRASZA_YELL_1'),
(40429, -1666001,'Thank you! I could have not held out for much longer. A terrible thing has happened here.', 17491, 0, 0, 0,'SAY_XERESTRASZA_YELL_2'),
(40429, -1666002,'We believed that the Sanctum was well fortified, but we were not prepareted for the nature of this assault.', 17492, 0, 0, 0,'SAY_XERESTRASZA_SAY_1'),
(40429, -1666003,'The Black Dragonkin materialized from thin air, and SET upon us before we could react.', 17493, 0, 0, 0,'SAY_XERESTRASZA_SAY_2'),
(40429, -1666004,'We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.', 17494, 0, 0, 0,'SAY_XERESTRASZA_SAY_3'),
(40429, -1666005,'They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the sanctum.', 17495, 0, 0, 0,'SAY_XERESTRASZA_SAY_4'),
(40429, -1666006,'The commander of the forces on the ground here is a cruel brute named Zarithrian. But I fear there are greater powers at work.', 17496, 0, 0, 0,'SAY_XERESTRASZA_SAY_5'),
(40429, -1666007,'In their initial assault I caught a glimpse of their true leader, a fearsome full-grown Twilight Dragon.', 17497, 0, 0, 0,'SAY_XERESTRASZA_SAY_6'),
(40429, -1666008,'I know not the extent of their plans heroes, but I know this: they cannot be allowed to succeed!', 17498, 0, 0, 0,'SAY_XERESTRASZA_SAY_7'),
(39863, -1666100,'Meddlesome insects, you`re too late! The Ruby Sanctum is lost.', 17499, 6, 0, 0,'SAY_HALION_SPAWN'),
(39863, -1666101,'Your world teeters on the brink of annihilation. You will all bear witness to the coming of a new age of destruction!', 17500, 6, 0, 0,'SAY_HALION_AGGRO'),
(39863, -1666102,'Another hero falls.', 17501, 6, 0, 0,'SAY_HALION_SLAY_1'),
(39863, -1666103,'Ha Ha Ha!', 17502, 6, 0, 0,'SAY_HALION_SLAY_2'),
(39863, -1666104,'Relish this victory mortals, for it will be your last. This world will burn with the Master`s return!', 17503, 6, 0, 0,'SAY_HALION_DEATH'),
(39863, -1666105,'Not good enough!', 17504, 6, 0, 0,'SAY_HALION_BERSERK'),
(39863, -1666106,'The heavens burn!', 17505, 6, 0, 0,'SAY_HALION_SPECIAL_1'),
(39863, -1666107,'Beware the shadow!', 17506, 6, 0, 0,'SAY_HALION_SPECIAL_2'),
(39863, -1666108,'You will find only suffering within the realm of Twilight. Enter if you dare.', 17507, 6, 0, 0,'SAY_HALION_PHASE_2'),
(39863, -1666109,'I am the light AND the darkness! Cower mortals before the Herald of Deathwing!', 17508, 6, 0, 0,'SAY_HALION_PHASE_3'),
(39863, -1666110,'In rotating spheres pulsating with dark energy!', 0, 3, 0, 0,''),
(39863, -1666111,'Your allies pushed Halion further into the physical world!', 0, 3, 0, 0,''),
(39863, -1666112,'Your allies pushed Halion further into the real world!', 0, 3, 0, 0,''),
(39863, -1666113,'Being alone in one of the worlds, Halion restores vitality', 0, 3, 0, 0,''),
(39746, -1666200,'Alexstrasza has chosen capable allies. A pity that I must end you!', 17512, 6, 0, 0,'SAY_ZARITHRIAN_AGGRO'),
(39746, -1666201,'You thought you stood a chance?', 17513, 6, 0, 0,'SAY_ZARITHRIAN_SLAY_1'),
(39746, -1666202,'It`s for the best.', 17514, 6, 0, 0,'SAY_ZARITHRIAN_SLAY_2'),
(39746, -1666203,'Halion! I`m...aah!', 17515, 6, 0, 0,'SAY_ZARITHRIAN_DEATH'),
(39746, -1666204,'Turn them to ash, minions!', 17516, 6, 0, 0,'SAY_ZARITHRIAN_SPECIAL_1'),
(39751, -1666300,'Ah, the entertainment has arrived...', 17520, 6, 0, 0,'SAY_BALTHARUS_AGGRO'),
(39751, -1666301,'Baltharus leaves no survivors!', 17521, 6, 0, 0,'SAY_BALTHARUS_SLAY_1'),
(39751, -1666302,'This world has enough heroes!', 17522, 6, 0, 0,'SAY_BALTHARUS_SLAY_2'),
(39751, -1666303,'I...didn`t see that coming...', 17523, 1, 0, 0,'SAY_BALTHARUS_DEATH'),
(39751, -1666304,'Twice the pain and half the fun!', 17524, 6, 0, 0,'SAY_BALTHARUS_SPECIAL_1'),
(39751, -1666305,'Your power wanes, ancient one! Soon, you will join your friends!', 17525, 6, 0, 0,'SAY_BALTHARUS_YELL'),
(39747, -1666400,'You will suffer for this intrusion...', 17528, 6, 0, 0,'SAY_SAVIANA_AGGRO'),
(39747, -1666401,'As it should be!', 17529, 6, 0, 0,'SAY_SAVIANA_SLAY_1'),
(39747, -1666402,'Halion will be pleased...', 17530, 6, 0, 0,'SAY_SAVIANA_SLAY_2'),
(39747, -1666403,'<screaming>', 17531, 6, 0, 0,'SAY_SAVIANA_DEATH'),
(39747, -1666404,'Burn in the master`s flame!', 17532, 6, 0, 0,'SAY_SAVIANA_SPECIAL_1'),
(39747, -1666405,'RAGE!!!', 0, 3, 0, 0,'');
-- -------------------------------------------------------------------------}
-- --- Myth Project "Quests && NPC && Game Objects && Achievements" Update --
-- -------------------------------------------------------------------------{
-- Achievement: Higher Learning, http://old.wowhead.com/achievement=1956
UPDATE `gameobject` SET `phaseMask` = 64 WHERE `id` IN (192708,192865,192866,192711,192710,192867,192713);
-- -------------------------------------------------------------------------
-- Quest: Making Peace, http://old.wowhead.com/quest=12573
-- Quest: Make the Bad Snake Go Away, http://old.wowhead.com/quest=12571
UPDATE `quest_template` SET `ExclusiveGroup` = 0 WHERE `entry` = 12571;  
-- Quest: Towers of Certain Doom, http://old.wowhead.com/quest=11259
UPDATE `quest_template` SET `ReqSpellCast1` = 49625, `ReqSpellCast2` = 49625, `ReqSpellCast3` = 49625, `ReqSpellCast4` = 49625 WHERE `entry` = 11259;
-- Quest: Zeth'Gor Must Burn!, http://old.wowhead.com/quest=10792
UPDATE `quest_template` SET `ReqSpellCast1` = 35724, `ReqSpellCast2` = 35724, `ReqSpellCast3` = 35724, `ReqSpellCast4` = 35724 WHERE `entry` = 10792;
-- Quest: Keeping the Enemy at Bay, http://old.wowhead.com/quest=11543
UPDATE `quest_template` SET `ReqSpellCast1` = 45115, `ReqSpellCast2` = 45115, `ReqSpellCast3` = 45115 WHERE `entry` = 11543;
-- Quest: Know Your Ley Lines, http://old.wowhead.com/quest=11547
UPDATE `quest_template` SET `ReqSpellCast1` = 45191, `ReqSpellCast2` = 45191, `ReqSpellCast3` = 45191 WHERE `entry` = 11547;
-- Quest: Mystery of the Infinite, http://old.wowhead.com/quest=12470
UPDATE `quest_template` SET `ReqSourceId1` = 0, `ReqSourceCount1` = 0 WHERE `entry` = 12470;
-- Quest: Into the Realm of Shadows, http://old.wowhead.com/quest=12687
UPDATE `npc_spellclick_spells` SET `cast_flags` = 1 WHERE `quest_start` = 12687;
-- Quest: The Aspirant's Challenge (Alliance), http://www.wowhead.com/quest=13679
-- Quest: The Aspirant's Challenge (Horde), http://www.wowhead.com/quest=13680
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 33448 WHERE `entry` IN (13680,13679); 
-- Quest: Junkboxes Needed,http://old.wowhead.com/quest=8249
UPDATE `quest_template` SET `ZoneOrSort` = 0 WHERE `entry` = 8249;
-- Quest: An Improper Burial, http://old.wowhead.com/quest=10913
UPDATE `quest_template` SET `ReqSpellCast1` = 39189, `ReqSpellCast2` = 39189 WHERE `entry` = 10913;
-- Quest: Massacre at Light's Hope
UPDATE `creature_template` SET `modelid1` = 25703, `modelid2` = 25703 WHERE `entry` = 28817;
-- Quest: Smoke 'Em Out, http://old.wowhead.com/quest=12324
DELETE FROM `conditions` WHERE `SourceEntry` = 49075;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13, 0, 49075, 0, 18, 1, 27570, 0, 0,'','Smoke `Em Out`');
-- Quest: Scrying Goggles? No Problem!, http://old.wowhead.com/quest=8578
DELETE FROM `creature_questrelation` WHERE `quest` = 8578; -- Delete existing incorrect start point
DELETE FROM `gameobject_questrelation` WHERE `quest` = 8578; -- Delete any existing values for this quest
INSERT INTO `gameobject_questrelation` (`id`,`quest`) VALUES (180642, 8578); -- Insert correct values for start point of quest
-- Quest: The Warm-Up, http://old.wowhead.com/quest=12996
DELETE FROM `creature_questrelation` WHERE `quest` = 12996;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 12996;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 12996;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 12996;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (29839, 12996);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (29839, 12996);
UPDATE `creature_template` SET `npcflag` =`npcflag`|2 WHERE `entry` = 29839;
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 12996;
UPDATE `quest_template` SET `Method` = 0 WHERE `entry` = 12996;
-- Quest: The Last of Her Kind, http://old.wowhead.com/quest=12983
DELETE FROM `creature_questrelation` WHERE `quest` = 12983;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 12983;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 12983;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 12983;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (29839, 12983);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (29839, 12983);
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 12983;
UPDATE `quest_template` SET `Method` = 0 WHERE `entry` = 12983;
UPDATE `npc_spellclick_spells` SET `cast_flags` = 1 WHERE `npc_entry` = 29563 AND `spell_id` = 56795;
-- Quest: Cold Hearted, http://old.wowhead.com/quest=12856
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 12856;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 12856;
DELETE FROM `creature_questrelation` WHERE `quest` = 12856;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (29592, 12856);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 12856;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (29592, 12856);
UPDATE `creature_template` SET `npcflag` = `npcflag`|2 WHERE `entry` = 29592;
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 12856;
UPDATE `quest_template` SET `Method` = 0 WHERE `entry` = 12856;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 29708;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(29708, 55028, 12856, 1, 12856, 1, 0, 0, 0);
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 29708;
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`) VALUES
(29708, 29805, 0, 1,'Captive Proto Drake and Beam Bunny');
-- Quest: Return to the Earth, http://wowhead.com/quest=12449
DELETE FROM `quest_start_scripts` WHERE `id` = 12449;
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES 
(12449, 1, 0, 0, 0, 2000001030, 0, 0, 0, 0);
UPDATE `quest_template` SET `ReqItemId1` = 37727, `ReqItemCount1` = 6, `ReqSourceId1` = 0, `ReqSourceCount1` = 0, `ReqCreatureOrGOId1` = 0, `ReqCreatureOrGOCount1` = 0, `ReqSpellCast1` = 0 WHERE `entry` = 12449;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 12449;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 12449;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 12449;
DELETE FROM `creature_questrelation` WHERE `quest` = 12449;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (27763, 12449);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (27763, 12449);
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 12449;
UPDATE `creature_template` SET `npcflag` = `npcflag`|2 WHERE `entry` = 27763;
-- Quest: Free Your Mind, http://wowhead.com/quest=12893
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 12893;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 12893;
DELETE FROM `creature_questrelation` WHERE `quest` = 12893;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (29804, 12893);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 12893;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (29804, 12893);
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 12893;
UPDATE `creature_template` SET `npcflag` =`npcflag`|2 WHERE `entry` = 29804;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 29769,`ReqCreatureOrGOId2` = 29770,`ReqCreatureOrGOId3` = 29840,`ReqSpellCast1` = 29070,`ReqSpellCast2` = 29070, `ReqSpellCast3` = 29070 WHERE `entry` = 12893; 
-- Quest: If He Cannot Be Turned (Horde), http://old.wowhead.com/quest=12897
UPDATE quest_template SET NextQuestInChain = 12899, NextQuestId = 0, ExclusiveGroup = 0, PrevQuestId = 0 WHERE entry = 12897;
-- Quest: If He Cannot Be Turned (Alliance), http://old.wowhead.com/quest=12896
UPDATE quest_template SET NextQuestInChain = 12898, NextQuestId = 0, ExclusiveGroup = 0, PrevQuestId = 0 WHERE entry = 12896;
-- NPC: General Lightsbane, http://old.wowhead.com/npc=29851
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 29851;
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
(1242,29851,0,0,100,1,4000,5000,3000,5000,11,60186,1,0,0,0,0,0,0,0,0,0,'General Lightsbane - Cast Plague Strike'),
(1243,29851,0,0,100,1,5000,7000,5000,8000,11,15284,1,0,0,0,0,0,0,0,0,0,'General Lightsbane - Cast Cleave'),
(1244,29851,0,0,100,1,7000,10000,10000,15000,11,60160,0,0,0,0,0,0,0,0,0,0,'General Lightsbane - Cast Death and Decay');
UPDATE `creature_template` SET  `AIName` = 'EventAI' WHERE `entry` = 29851;
DELETE FROM `creature` WHERE `id` = 29851;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL,29851,571,1,2,0,1032,8427.21,2692.35,759.958,2.94431,300,0,0,63000,3994,0,0,0,0,0);
-- Quest: The Shadow Vault (Alliance), http://old.wowhead.com/quest=12898
UPDATE `quest_template` SET `PrevQuestId` = 12896  WHERE `entry` = 12898;
-- Quest: The Shadow Vault (Horde), http://old.wowhead.com/quest=12899
UPDATE `quest_template` SET `PrevQuestId` = 12897  WHERE `entry` = 12899;
-- Quest: The Duke, http://old.wowhead.com/quest=12938
UPDATE `quest_template` SET `NextQuestInChain` = 12938, `NextQuestId` = 12938, `ExclusiveGroup` = 12898 WHERE `entry` IN (12898, 12899);
-- Quest: Up To The Challenge, http://old.wowhead.com/quest=13678
UPDATE `quest_template` SET `NextQuestInChain` = 13678, `NextQuestId` = 13678, `ExclusiveGroup` = -13829 WHERE `entry` IN (13829, 13838, 13839);
-- Quest: The Aspirant's Challenge, http://old.wowhead.com/quest=13680
UPDATE `quest_template` SET `NextQuestInChain` = 13680, `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `entry` = 13678;
-- Quest: The Celestial Planetarium, http://old.wowhead.com/quest=13607
UPDATE `quest_template` SET `PrevQuestId` = 13604 WHERE `entry` = 13607;
-- Quest: Algalon, http://old.wowhead.com/quest=13606
-- Quest: Freya's Sigil, http://old.wowhead.com/quest=13606
UPDATE `quest_template` SET `PrevQuestId` = 13607, `NextQuestId` = 13614, `ExclusiveGroup` =- 13606 WHERE `entry` = 13606;
-- Quest: Hodir's Sigil, http://old.wowhead.com/quest=13609
UPDATE `quest_template` SET `PrevQuestId` = 13607, `NextQuestId` = 13614, `ExclusiveGroup` =- 13606 WHERE `entry` = 13609;
-- Quest: Thorim's Sigil, http://old.wowhead.com/quest=13610
UPDATE `quest_template` SET `PrevQuestId` = 13607, `NextQuestId` = 13614, `ExclusiveGroup` =- 13606 WHERE `entry` = 13610;
-- Quest: Mimiron's Sigil, http://old.wowhead.com/quest=13611
UPDATE `quest_template` SET `PrevQuestId` = 13607, `NextQuestId` = 13614, `ExclusiveGroup` =- 13606 WHERE `entry` = 13611;
-- Quest: Heroic: The Celestial Planetarium, http://old.wowhead.com/quest=13816
UPDATE `quest_template` SET `PrevQuestId` = 13817 WHERE `entry` = 13816;
-- Quest: Heroic: Algalon, http://old.wowhead.com/quest=13818
-- Quest: Heroic: Freya's Sigil, http://old.wowhead.com/quest=13821
UPDATE `quest_template` SET `PrevQuestId` = 13816, `NextQuestId` = 13818, `ExclusiveGroup` =- 13821 WHERE `entry` = 13821;
-- Quest: Heroic: Hodir's Sigil, http://old.wowhead.com/quest=13822
UPDATE `quest_template` SET `PrevQuestId` = 13816, `NextQuestId` = 13818, `ExclusiveGroup` =- 13821 WHERE `entry` = 13822;
-- Quest: Heroic: Thorim's Sigil, http://old.wowhead.com/quest=13823
UPDATE `quest_template` SET `PrevQuestId` = 13816, `NextQuestId` = 13818, `ExclusiveGroup` =- 13821 WHERE `entry` = 13823;
-- Quest: Heroic: Mimiron's Sigil, http://old.wowhead.com/quest=13824
UPDATE `quest_template` SET `PrevQuestId` = 13816, `NextQuestId` = 13818, `ExclusiveGroup` =- 13821 WHERE `entry` = 13824;
-- Quest: Make the Bad Snake Go Away, http://old.wowhead.com/quest=12571
UPDATE `quest_template` SET `NextQuestId` = 12573, `ExclusiveGroup` = 0, `NextQuestInChain` = 0 WHERE `entry` = 12571;
-- Quest: Making Peace, http://old.wowhead.com/quest=12573
UPDATE `quest_template` SET `PrevQuestId` = 12571, `NextQuestId` = 0, NextQuestInChain = 0 WHERE `entry` = 12573;
-- Quest: Frankly, It Makes No Sense..., http://old.wowhead.com/quest=10672
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 21462, `ReqSpellCast1` = 37851 WHERE `entry` = 10672;  
-- Quest: Journey to Thrallmar (Horde), http://old.wowhead.com/quest=10289
-- Ouest: Journey to Honor Hold (Alliance), http://old.wowhead.com/quest=10140
UPDATE `npc_text` SET `text0_1` = '' WHERE `id` = 10053;
UPDATE `creature_template` SET `ScriptName` = '',`AIName` = 'SmartAI' WHERE `entry` IN (18930, 18931);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (18930, 18931);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- NPC: Vlagga Freyfeather, http://old.wowhead.com/npc=18930
(18930,0,0,0,62,0,100,0,7938,1,0,0,11,34924,2,0,0,0,0,7,0,0,0,0,0,0,0,'Vlagga Freyfeather - On gossip option 1 select - Cast Stair of Destiny to Thrallmar'),
-- NPC: Amish Wildhammer, http://old.wowhead.com/npc=18931
(18931,0,0,0,62,0,100,0,7470,1,0,0,11,34924,2,0,0,0,0,7,0,0,0,0,0,0,0,'Amish Wildhammer - On gossip option 1 select - Cast Stair of Destiny to Honor Hold');
-- Quest: Mystery of the Infinite, Redux, http://old.wowhead.com/quest=13343
UPDATE `quest_template` SET `SpecialFlags` = 0 WHERE `entry` = 13343;
-- Quest: The Cleansing, http://old.wowhead.com/quest=11317
DELETE FROM `gameobject` WHERE `id` IN (186649,186650);
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(186649,571,1,15,3036.77344,-5091.77539,722.4749,0.907570243,0,0,0,0,120,0,1),
(186650,571,1,15,3036.77539,-5091.593,722.370544,0.19198516,0,0,0,0,120,0,1);
-- NPC: Your Inner Turmoil, http://old.wowhead.com/npc=27959
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` = 27959;
UPDATE `smart_scripts` SET `action_param1` = 69828 WHERE `entryorguid` = 27959 AND `source_type` = 0 AND `id` = 0 AND `link` = 1;
-- Quest: Securing the Bait, http://old.wowhead.com/quest=12605
DELETE FROM `creature_loot_template` WHERE entry = 28378 AND item = 38600;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(28378, 38600, -100, 1, 0, 1, 1);
-- Quest: Salvaging Life's Strength, http://old.wowhead.com/quest=12805
-- Item: Lifeblood Gem, http://old.wowhead.com/item=40397
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceEntry` = 40397;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,40397,0,24,2,29124,0,63,'','Item 40397 Lifeblood Gem targets Lifeblood Elemental 29124 (dead)');
-- Quest: Convention at the Legerdemain, http://old.wowhead.com/?quest=13101
-- NPC: Arille Azuregaze, http://old.wowhead.com/npc=29049
UPDATE `creature` SET `phaseMask` = 1 WHERE `id` = 29049;
-- Quest: Master and Servant, http://old.wowhead.com/quest=11730
UPDATE `spell_area` SET `area` = 4035 WHERE `spell` = 46023;
-- Quest: Improved Land Mines, http://www.wowhead.com/quest=12820
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29475;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29475;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_flags`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`comment`) VALUES
(29475,0,0,0,9,1,1,5,11,54537,'Quest: 12820');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_flags`,`event_param4`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(29475,0,1,0,5,1,29619,33,29618,23,'Quest: 12820');
-- Quest: Springing the Trap, http://old.wowhead.com/quest=11969
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26237;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26237;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_flags`,`action_type`,`action_param1`,`target_type`,`target_param1`,`comment`) VALUES
(26237,0,0,0,54,1,33,26237,18,20,'Quest: 11969');
-- Quest: Sniffing Out the Perpetrator, http://old.wowhead.com/quest=12910
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29695;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29695;
INSERT INTO `smart_scripts` VALUES (29695, 0, 0, 0, 10, 0, 100, 1, 0, 40, 0, 0, 33, 29677, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0,'');
-- Quest: Rivenwood Captives, http://old.wowhead.com/quest=11296
-- NPC: Riven Widow Cocoon, http://www.wowhead.com/npc=24210
-- NPC: Freed Winterhoof Longrunner, http://www.wowhead.com/npc=24211
UPDATE `quest_template` SET `RequiredRaces` = 690 WHERE `entry` = 11296;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (24210, 24211);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (24210, 24211);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES 
(24210,0,0,0,6,60,11,43289,1,'Quest: 11296');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_flags`,`action_type`,`action_param1`,`target_type`,`target_param1`,`comment`) VALUES
(24211,0,0,0,54,1,33,24211,18,30,'Quest: 11296');
-- Quest: Leave Nothing to Chance, http://old.wowhead.com/quest=12277
UPDATE `creature_template` SET `ScriptName` = 'npc_wintergarde_mine_bomb' WHERE `entry` = 27435;
-- Quest: Thalorien Dawnseeker (Alliance), http://www.wowhead.com/quest=24535
-- Quest: Thalorien Dawnseeker (Horde), http://www.wowhead.com/quest=24563
UPDATE `creature_template` SET `npcflag` = 1, `ScriptName` = 'npc_thaloriendre' WHERE `entry` = 37552;
-- Quest: A Suitable Disguise (Alliance), http://www.wowhead.com/quest=20438
-- Quest: A Suitable Disguise (Horde), http://www.wowhead.com/quest=24556
UPDATE `creature_template` SET `ScriptName` = 'npc_arcanist_tybalin' WHERE `entry` = 36669;
UPDATE `creature_template` SET `ScriptName` = 'npc_magister_hathorel' WHERE `entry` = 36670;
-- Quest: Adding Injury to Insult, http://www.wowhead.com/quest=12481
-- Item: Vrykul Insult, http://www.wowhead.com/item=33581
DELETE FROM `conditions` WHERE `SourceEntry` = 33581;
UPDATE `item_template` SET `ScriptName` = 'item_vrykul_insult' WHERE `entry` = 33581;
-- Quest: Fel Reaver, No Thanks!, http://www.wowhead.com/quest=10855 
DELETE FROM `quest_end_scripts` WHERE `id` =10850;
INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES (10850, 2, 8, 22293, 0, 0, 0, 0, 0, 0);
-- Quest: Put on Your Best Face for Loken, http://old.wowhead.com/quest=12185 
DELETE FROM `event_scripts` WHERE `id` = '188596';
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `data2` = 0 WHERE `entry` = 188596;
DELETE FROM `smart_scripts` WHERE `entryorguid`IN (188596,18859600);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(188596,1,0,0,64,0,100,0,0,0,0,0,80,18859600,2,0,0,0,0,1,0,0,0,0,0,0,0,'Lokens Pedistal - Start Script'),
(18859600,9,0,0,0,0,100,0,2000,2000,0,0,12,27212,1,32000,0,0,0,8,0,0,0,3404.76,-5394.60,270.19,1.2,'Summon Immage of Loken'),
(18859600,9,1,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,11,27212,10,0,0,0,0,0,'Immage of Loken - Speach 1'),
(18859600,9,2,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,11,27212,10,0,0,0,0,0,'Immage of Loken - Speach 2'),
(18859600,9,3,0,0,0,100,0,7000,7000,0,0,1,2,0,0,0,0,0,11,27212,10,0,0,0,0,0,'Immage of Loken - Speach 3'),
(18859600,9,4,0,0,0,100,0,6000,6000,0,0,1,3,0,0,0,0,0,11,27212,10,0,0,0,0,0,'Immage of Loken - Speach 4'),
(18859600,9,5,0,0,0,100,0,7000,7000,0,0,1,4,0,0,0,0,0,11,27212,10,0,0,0,0,0,'Immage of Loken - Speach 5'),
(18859600,9,6,0,0,0,100,0,0,0,0,0,33,27212,0,0,0,0,0,7,0,0,0,0,0,0,0,'Lokens Pedistal - Quest Credit');
DELETE FROM `creature_text` WHERE `entry` = 27212;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27212,0,0,'You are late, overseer.',0,0,100,25,0,0,'Image of Loken'),
(27212,1,0,'Destiny will not wait. Your craftsmen must increase their production of the war golems before the stone giant leader and his army reach Ulduar.',0,0,100,25,0,0,'Image of Loken'),
(27212,2,0,'Tell your rune-smiths to continue converting what stone giants you can. Those that will not submit must be destroyed.',0,0,100,25,0,0,'Image of Loken'),
(27212,3,0,'If the stone giants interfere with our work at Ulduar, I will hold you and your thane responsible. Mortal must not be allowed to come to the aid of the giants. ',0,0,100,25,0,0,'Image of Loken'),
(27212,4,0,'Return to your duties, overseer. Be certain to impress upon your workers the urgency of their tasks.',0,0,100,25,0,0,'Image of Loken');
/*-- Quest: Slaves of the Stormforged, http://old.wowhead.com/quest=12957
DELETE FROM `creature_ai_scripts` WHERE `id` = '77770848';
INSERT INTO `creature_ai_scripts`(`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
(77770848,29384,8,0,100,1,55875,-1,4000,4000,33,29384,6,0,41,0,0,0,0,0,0,0,'Quest: 12957');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE entry IN (29384);
DELETE FROM `gossip_scripts` WHERE `id` = 29384;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
VALUES (29384, 0, 15, 55875, 1, 0, 0, 0, 0, 0),(29384, 1, 8, 29962, 1, 0, 0, 0, 0, 0);
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 9871;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES
(9871, 1, 1,'Free me?', 1, 1, 0, 0, 29384, 0, 0, NULL);*/
-- -------------------------------------------------------------------------
-- NPC: Veteran Crusader Aliocha Segard, http://old.wowhead.com/npc=30431
DELETE FROM `creature` WHERE `id` = 30431;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL, 30431, 571, 1, 135, 27020, 0, 6266.74, -44.569, 421.498, 3.83972, 300, 0, 0, 23310, 11982, 0, 0, 0, 0, 0);
-- NPC: Silithid Swarm, http://old.wowhead.com/npc=4196
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|64 WHERE `entry` = 4196;
-- NPC: Scarlet Miner, http://old.wowhead.com/npc=28841
UPDATE `creature_template` SET `speed_run` = 1.22 WHERE `entry` = 28841;
-- NPC: Scarlet Infantryman, http://old.wowhead.com/npc=28609
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 28896;
-- NPC: Warden MoI`bff Jill, http://old.wowhead.com/npc=18408
UPDATE `creature_template` SET `faction_A` = 1802, `faction_H` = 1802 WHERE `entry` = 18408;
-- NPC: Unliving Initiate, http://old.wowhead.com/npc=21870
UPDATE `creature_template` SET `unit_flags` = 33554434 WHERE `entry` = 21870;
-- NPC: Slain Auchenai Warrior, http://old.wowhead.com/npc=21846
UPDATE `creature_template` SET `unit_flags` = 256 WHERE `entry` = 21846;
-- NPC: Lorelae Wintersong, http://old.wowhead.com/npc=12022
UPDATE npc_vendor SET incrtime = 900 WHERE `item` = 16243 AND `entry` = 12022; -- Formula: Runed Arcanite Rod
UPDATE npc_vendor SET incrtime = 2400 WHERE `item` = 14483 AND `entry` = 12022; -- Pattern: Felcloth Pants
UPDATE npc_vendor SET incrtime = 900 WHERE `item` = 16224 AND `entry` = 12022; -- Formula: Enchant Cloak - Superior Defense
-- NPC: Flesh Eating Worm, http://old.wowhead.com/npc=2462
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|64 WHERE `entry` = 2462;
-- NPC: Njorndar Proto-Drake, http://old.wowhead.com/npc=30272
UPDATE `npc_spellclick_spells` SET `cast_flags` = 1 WHERE `npc_entry` = 30272;
-- NPC: Paladin Trainers
UPDATE `creature_template` SET `gossip_menu_id` = 4471 WHERE `entry` IN (
925, 926, 927, 1232, 5147, 5148, 5149, 5491, 5492, 8140, 15280,
16501, 16679, 16680, 16881, 16761, 16275, 17483, 17509, 20406, 23128);
-- NPC: Harnessed Icemaw Matriarch, http://old.wowhead.com/npc=30468
UPDATE `creature_template` SET `Health_mod` = 95000 WHERE `entry` = 30468;
-- NPC: Jean Pierre Poulain, http://old.wowhead.com/npc=34244
UPDATE `gossip_scripts` SET `datalong2` = 1 WHERE `id` = 10478;
-- NPC: Amish Wildhammer, http://old.wowhead.com/npc=18931
UPDATE `creature_template` SET `gossip_menu_id` = 7470, `npcflag` = 8194 WHERE `entry` = 18931;
-- NPC: Deathforged Infernal, http://old.wowhead.com/npc=21316
UPDATE `creature_template` SET unit_flags = 0 WHERE entry = 21316;
-- NPC: Ravenous Mangal Crocolisk, http://old.wowhead.com/npc=28325
DELETE FROM `creature` WHERE `id` = 28325 AND `map` = 571;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL, 28325, 571, 1, 1, 15145, 0, 5461.9, 4523.03, -132.618, 4.73128, 300, 0, 0, 11379, 0, 0, 0, 0, 0, 0);
-- NPC: Infernal Oversoul, http://old.wowhead.com/npc=21735
UPDATE `creature_template` SET `flags_extra` =`flags_extra`|0x00000040 WHERE `entry` = 21735;
-- NPC: Kaliri Matriarch, http://old.wowhead.com/npc=17035
UPDATE `creature_template` SET `flags_extra` =`flags_extra`|0x00000040 WHERE `entry` = 17035;
-- NPC: Warlord Tartek, http://old.wowhead.com/npc=28105
DELETE FROM `creature` WHERE `id` = 28105 AND `map` = 571;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL, 28105, 571, 1, 1, 0, 0, 6714.48, 5128.16, -19.3922, 1.73652, 300, 0, 0, 11379, 0, 0, 0, 0, 0, 0);
-- NPC: Infesting Jormungar, http://old.wowhead.com/npc=30148
UPDATE creature_template SET `unit_flags` = `unit_flags`&~0x00000300 WHERE entry = 30148;
-- NPC: Dregmar Runebrand, http://old.wowhead.com/npc=27003
UPDATE `creature_template` SET `unit_flags` = 0 WHERE entry = 27003;
-- NPC: "Honest" Max, http://old.wowhead.com/npc=30464
UPDATE `gossip_scripts` SET `datalong2` = 1 WHERE `id` IN (50137, 50138);
DELETE FROM `spell_area` WHERE `spell` IN (64761,64681);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES 
(64761, 67, 0, 0, 0, 0, 0, 2, 0),   (64761, 210, 0, 0, 0, 0, 0, 2, 0),
(64761, 3711, 0, 0, 0, 0, 0, 2, 0), (64681, 67, 0, 0, 0, 0, 0, 2, 0),
(64681, 210, 0, 0, 0, 0, 0, 2, 0),  (64681, 3711, 0, 0, 0, 0, 0, 2, 0);
-- NPC: Tormented Drakkari, http://old.wowhead.com/npc=26965
UPDATE `creature_addon` SET `auras` = 31261 WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 26965);
-- -------------------------------------------------------------------------
-- Game Object: Escape to the Isle of Quel'Danas : 188173
UPDATE `gameobject_template` SET `type` = 1, `data0` = 0, `data2` = 5000, `ScriptName` = 0 WHERE `entry` = 188173;
DELETE FROM `gameobject_scripts` WHERE `id` = 43343;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES (43343, 1, 6, 530, 0, 0, 12888, -6876, 9, 0.3);
-- -------------------------------------------------------------------------}
-- ----------------- Myth Project "Game Mechanic" Update -------------------
-- -------------------------------------------------------------------------{
-- Game Mech.: Shadow Sight, http://old.wowhead.com/spell=34709
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 34709;
INSERT INTO `spell_linked_spell` VALUES
(34709, -1784, 1,'Shadow Sight - Stealth'), (34709, -5215, 1,'Shadow Sight - Prowl');
-- Game Mech.: Spells Stacking: Earth Shock and other attack speed decreasing effects. Also restored rule for druid's talent Infected Wounds
DELETE FROM `spell_group` WHERE `spell_id` IN (8042, -2009);
INSERT INTO `spell_group` VALUES (2009, 8042),(1064, -2009);
-- Item: Goblin Rocket Pack, http://old.wowhead.com/item=49278
UPDATE `item_template` SET `area` = 4812, `Map` = 631 WHERE `entry` = 49278;
-- Mount: Flying Carpet, http://old.wowhead.com/spell=60969
UPDATE `npc_trainer` SET `reqskillvalue` = 300 WHERE `spell` = 60969;
-- Mount: Reins of the Blue Proto-Drake, http://old.wowhead.com/item=44151
UPDATE `npc_spellclick_spells` SET `spell_id` = 54513 WHERE `npc_entry` = 29460;
-- Mount: Captive Proto-Drake, http://www.wowhead.com/npc=29708
UPDATE `npc_spellclick_spells` SET `spell_id` = 43671 WHERE `npc_entry` = 29708;
-- Spell: Fiery Aura, http://old.wowhead.com/spell=23266
-- Item: Essence of the Pure Flame, http://old.wowhead.com/item=18815
DELETE FROM `spell_bonus_data` WHERE `entry` = 23266;
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES (23266, 0, 0, 0, 0,'Fiery Aura');
-- Hunter: Explosive Shot, http://old.wowhead.com/spell=53301
UPDATE `spell_bonus_data` SET `direct_bonus` = 0,`dot_bonus` = 0,`ap_dot_bonus` = 0 WHERE `entry` = 53352;
-- Hunter: Misdirection (Char), http://old.wowhead.com/spell=34477
DELETE FROM `spell_proc_event` WHERE `entry` = 34477;
INSERT INTO `spell_proc_event` (`entry`,`cooldown`) VALUES (34477, 30);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -35079;
INSERT INTO `spell_linked_spell` VALUES (-35079, -34477, 0,'Misdirection');
-- Hunter: Misdirection (Pet), http://old.wowhead.com/spell=68361
DELETE FROM `spell_pet_auras` WHERE `aura` = 68361;
INSERT INTO `spell_pet_auras` VALUES (34453, 1, 0, 68361), (34454, 1, 0, 68361);
-- Druid: Berserk, http://old.wowhead.com/spell=50334
DELETE FROM `spell_script_names` WHERE `spell_id` = 50334;
INSERT INTO `spell_script_names` VALUES (50334,'spell_dru_berserk');
-- Druid: Naturalist, http://old.wowhead.com/spell=17069
DELETE FROM `spell_bonus_data` WHERE `entry` IN (779, 780, 769, 9754, 9908, 26997, 48561, 48562);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`,`ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(779, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 1'),    (780, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 2'),
(769, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 3'),    (9754, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 4'),
(9908, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 5'),   (26997, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 6'),
(48561, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 7'),  (48562, 0, 0, 0.063, 0,'Druid - Swipe (Bear) Rank 8');
-- Death Knight: Risen Ghoul & Gargoyle: Fear Immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 0x00000010 WHERE `entry` IN (27829, 26125);
-- Death Knight: Glyph of Raise Dead
UPDATE `item_template` SET `AllowableClass` = 32 WHERE `entry` = 44432;
-- Death Knight: Bloodworm AI (replace into correct)
UPDATE creature_template SET AIName='EventAI' WHERE entry=28017;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 28017;
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
(2801701, 28017, 4, 0, 100, 0, 0, 0, 0, 0, 11, 50453, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodworm - Health Leech');
-- Warrior: Taste for Blood, http://old.wowhead.com/spell=56638
UPDATE `spell_proc_event` SET `procEx` = 0x00040000 WHERE `entry` IN (56636, 56637, 56638);
-- Warrior: Safeguard, http://old.wowhead.com/spell=46945
UPDATE `spell_proc_event` SET `Cooldown` = 1 WHERE `entry` IN (46945, 46949);
-- Warrior: Vigilance, http://old.wowhead.com/spell=50720
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (59665, -50720);
INSERT INTO `spell_linked_spell` VALUES
(59665, 68066, 0,'Vigilance - apply damage reduction'),
(-50720, -68066, 0,'Vigilance - remove damage reduction');
-- Warlock: Shadow Bite, http://old.wowhead.com/spell=54049
DELETE FROM spell_script_names WHERE spell_id IN (-54049, 54049, 54050, 54051, 54052, 54053);
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES (-54049,'spell_warl_shadow_bite');
-- Warlock: Prevent summoning into BG
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 698;
INSERT INTO `disables` VALUES (0, 698, (1+16+32),'489, 529, 529, 566','4572, 4571, 3417, 3418, 3820','Ritual of Summoning spell on BG');
-- Warlock: Fear - Polymorph - Seduction Break.
DELETE FROM `spell_script_names` WHERE `spell_id` = -5138 AND `ScriptName` = 'spell_warl_drainmana_drainlife';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-5138,'spell_warl_drainmana_drainlife');
-- Warlock: Shadowflame, http://old.wowhead.com/spell=47897
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-47960, -61291);
INSERT INTO `spell_linked_spell` VALUES
(-47960, -63311, 0,'Glyph of Shadowflame Rank 1 (Dispel)'),
(-61291, -63311, 0,'Glyph of Shadowflame Rank 2 (Dispel)');
-- Warlock: Glyph of Shadowflame, http://old.wowhead.com/spell=63310
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-47960, -61291);
INSERT INTO `spell_linked_spell` VALUES
(-47960, -63311, 0,'Glyph of Shadowflame Rank 1 (Dispel)'),
(-61291, -63311, 0,'Glyph of Shadowflame Rank 2 (Dispel)');
-- Warlock: Improved Health Funnel, http://old.wowhead.com/spell=18704
DELETE FROM `spell_ranks` WHERE `first_spell_id` = 60955;
INSERT INTO `spell_ranks` VALUES (60955, 60955, 1), (60955, 60956, 2);
-- Priest: Mind Flay, http://old.wowhead.com/spell=15407
UPDATE `spell_proc_event` SET `SpellFamilyMask0` = 0|0x00008000,`SpellFamilyMask2` = `SpellFamilyMask2`|0x00000040 WHERE `entry` IN (33191, 33192, 33193);
-- Priest: Hymn of Hope and Divine Hymn, http://old.wowhead.com/spell=64844
DELETE FROM `spell_bonus_data` WHERE `entry` = 64844;
INSERT INTO `spell_bonus_data` VALUES 
(64844, 0.5483, -1, -1, -1,'Priest - Divine Hymn');
-- Priest: Glyph of Shadow: http://old.wowhead.com/spell=61792
DELETE FROM `conditions` WHERE `SourceEntry` = 61792;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`Comment`) VALUES
(17, 61792, 1, 15473,'Glyph of Shadow triggered - Shadowform');
-- Rogue: Killing Spree, http://old.wowhead.com/spell=51690
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 51690;
INSERT INTO `spell_linked_spell` VALUES (51690, 61851, 0,'Killing Spree');
-- Rogue T10 4p bonus
DELETE FROM spell_proc_event WHERE entry = 70803;
INSERT INTO `spell_proc_event` VALUES('70803', '0', '8', '4063232', '8', '0', '0', '0', '0', '0', '0');
-- Paladin: Improved Devotion Aura, http://old.wowhead.com/spell=63514
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-31869, -20138, -20139, -20140, -20254, -20255, -20256);
INSERT INTO `spell_linked_spell` VALUES
(-31869, -63531, 0,'Sanctified Retribution at talent reset'),
(-20138, -63514, 0,'Improved Devotion Aura at talent reset'),
(-20139, -63514, 0,'Improved Devotion Aura at talent reset'),
(-20140, -63514, 0,'Improved Devotion Aura at talent reset'),
(-20254, -63510, 0,'Improved Concentration Aura at talent reset'),
(-20255, -63510, 0,'Improved Concentration Aura at talent reset'),
(-20256, -63510, 0,'Improved Concentration Aura at talent reset');
UPDATE `spell_group` SET `spell_id` = 63514 WHERE `id` = 1095;
-- Paladin: Blessing of Sanctuary, http://old.wowhead.com/spell=67480
DELETE FROM `spell_dbc` WHERE `id` = 20912;
INSERT INTO `spell_dbc` (`Id`,`CastingTimeIndex`,`DurationIndex`,`RangeIndex`,`Effect1`,`EffectBasePoints1`,`EffectImplicitTargetA1`,`EffectApplyAuraName1`,`EffectMiscValue1`,`SpellFamilyName`,`Comment`) VALUES
(20912, 1, 21, 1, 6, -3, 1, 87, 127, 10,'Blessing of Sanctuary Helper (SERVERSIDE)');
UPDATE `spell_group` SET `spell_id` = 68066 WHERE `id` = 1091 AND `spell_id` = 47930;
UPDATE `spell_group` SET `spell_id` = 20912 WHERE `id` = 1092 AND `spell_id` = 20911;
-- Paladin: Devine Storm, http://old.wowhead.com/spell=53385
DELETE FROM `spell_dbc` WHERE `Id` = 99997;
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(99997, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Divine Storm Helper (SERVERSIDE)');
DELETE FROM `spell_proc_event` WHERE `entry` = 99997;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(99997, 0, 10, 0, 131072, 0, 16, 0, 0, 100, 0);
DELETE FROM `spell_bonus_data` WHERE `entry` = 54172;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(54172, 0, 0, 0, 0,'Paladin - Divine Storm');
-- Shaman: Spirit Wolves, http://old.wowhead.com/spell=58861
DELETE FROM `spell_script_names` WHERE `spell_id` = -58861;
INSERT INTO `spell_script_names` VALUES (-58861,'spell_sha_bash');
-- Shaman: Totem of Wrath, http://old.wowhead.com/spell=57658
UPDATE `creature_template` SET `spell2` = 30708 WHERE `spell1` IN (57658, 57660, 57662, 57663);
-- Shaman: Sentry Totem, http://old.wowhead.com/spell=6494    
DELETE FROM `spell_dbc` WHERE `id` IN (6494, 6496);
INSERT INTO `spell_dbc` (`Id`,`CastingTimeIndex`,`DurationIndex`,`RangeIndex`,`Effect1`,`EffectBasePoints1`,`EffectImplicitTargetA1`,`EffectImplicitTargetB1`,`EffectApplyAuraName1`,`SpellFamilyName`,`Comment`) VALUES
(6494, 1, 5, 1, 6, 1, 1, 27, 4, 11,'Sentry Totem Helper 1 (SERVERSIDE)'),
(6496, 1, 5, 1, 6, 1, 25, 0, 1, 11,'Sentry Totem Helper 2 (SERVERSIDE)');
UPDATE `creature_template` SET `spell1` = 6494 WHERE `entry` = 3968;
DELETE FROM `conditions` WHERE `SourceEntry` = 6196;
INSERT INTO `conditions` VALUES (17, 0, 6196, 0, 11, 6495, 1, 0, 24,'','Far Sight - Sentry Totem');
-- Mage: Frostbolt, http://old.wowhead.com/spell=116
DELETE FROM `spell_bonus_data` WHERE `entry` IN (116);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(116, 0.857, 0, 0, 0,'Mage - Frostbolt');
-- Mage: Brain Freeze, http://old.wowhead.com/spell=44546
DELETE FROM `spell_proc_event` WHERE `entry` IN (44546, 44548, 44549);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(44546, 0, 3, 544, 0, 0, 0, 0, 0, 0, 0), -- Brain Freeze (Rank 1)
(44548, 0, 3, 544, 0, 0, 0, 0, 0, 0, 0), -- Brain Freeze (Rank 2)
(44549, 0, 3, 544, 0, 0, 0, 0, 0, 0, 0); -- Brain Freeze (Rank 3)
-- Mage: Combustion, http://old.wowhead.com/spell=11129
UPDATE `spell_proc_event` SET `SpellFamilyMask1` = `SpellFamilyMask1` &~ 0x8 WHERE `entry` = 11129;
-- -------------------------------------------------------------------------}
-- ------------ Myth Project "World" Database "Lite" Cleaner ---------------
-- -------------------------------------------------------------------------{
 DROP TABLE IF EXISTS `db_version_ytdb`;         -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `npc_gossip`;              -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `game_event_npc_gossip`;   -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `lfg_dungeon_encounters`;  -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `gameobject_respawn`;      -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `creature_respawn`;        -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `reserved_name`;           -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `custom_texts`;            -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `locales_item_set_name`;   -- DEPRICATED TABLE
 DROP TABLE IF EXISTS `warden_data_result`;      -- DEPRICATED TABLE
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
-- EVENT AI
 DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (
SELECT `entry` FROM `creature_template` WHERE `AIName` NOT IN ("EventAI"));                                     -- Dinamic // "creature_ai_scripts" table  
-- -------------------------------------------------------------------------}
-- -------------- Myth Project "Runtime" Console errors FIX ----------------
-- -------------------------------------------------------------------------{
UPDATE `creature_template` SET `equipment_id` = 10108 WHERE `entry` = 25311;
DELETE FROM `creature_equip_template` WHERE `entry` IN (33698, 10000, 10108);
INSERT INTO `creature_equip_template` VALUES
(10000, 0, 0, 0),
(33698, 46106, 0, 0),
(10108, 17042, 0, 0);

UPDATE `creature_addon` SET `auras` = REPLACE(`auras`,' 0','');
UPDATE `creature_template_addon` SET `auras` = REPLACE(`auras`,' 0','');
UPDATE `creature_addon` SET `auras` = TRIM(`auras`);
UPDATE `creature_template_addon` SET `auras` = TRIM(`auras`);

DELETE FROM `conditions` WHERE `SourceEntry` IN (64468, 66665);
DELETE FROM `conditions` WHERE `SourceEntry` = 49590 AND `conditionValue1` = 0 AND `conditionValue2` = 27827;
DELETE FROM `command` WHERE `name` LIKE '%plimit%';
-- If you have problems with Teleports
-- UPDATE `spell_target_position` SET `target_position_z` = 1055.43 WHERE `id` = 70860;
-- UPDATE `spell_target_position` SET `target_position_z` = 38,3236 WHERE `id` = 70746;
-- -------------------------------------------------------------------------}
-- ----------------- Myth Project "Anti - Cheating" System -----------------
-- -------------------------------------------------------------------------{
DELETE FROM `trinity_string` WHERE `entry` = 11777;
DELETE FROM `command` WHERE `name` LIKE "%gameguard%";
INSERT INTO `trinity_string` VALUES (11777,'|cff00ffff[GameGuard]: |r Cheater detected. Nickname: %s. Cheat type: %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL/* '|cff00ffff[GameGuard]: |r Читер обнаружен. Имя: %s. Тип чита: %s. '*/);
INSERT INTO `command` VALUES ('reload gameguard', 3,'Syntax: .reload gameguard\r\nReload GameGuard config table(anticheat_config).');