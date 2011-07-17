-- Coverter works perfectly and transfer chars/accounts from Mangos[11702] to Myth 3.3.5a [8229:266c42745385]
-- After convertng use .reset all talents
-- All talents will be reseted, All Instance Saves will be resetd.  All other will be ok
/*
 -- PART 1
USE myth-characters -- (your MYTH CHARACTERS DB)
-- CHARACTERS TRANSFER QUERIES
INSERT INTO account_data SELECT * FROM mangos-characters.account_data;
-- addons -- TC specific table, will be filled by TC
INSERT INTO arena_team (arenaTeamid, name, captainGuid, type, backgroundColor, emblemStyle, emblemColor, borderStyle, borderColor) SELECT * FROM mangos-characters.arena_team;
UPDATE arena_team a SET rating = ( SELECT rating FROM mangos-characters.arena_team_stats WHERE arenateamid = a.arenateamid);
UPDATE arena_team a SET seasonGames = ( SELECT games_season FROM mangos-characters.arena_team_stats WHERE arenateamid = a.arenateamid);
UPDATE arena_team a SET seasonWins = ( SELECT wins_season FROM mangos-characters.arena_team_stats WHERE arenateamid = a.arenateamid);
UPDATE arena_team a SET weekGames = ( SELECT games_week FROM mangos-characters.arena_team_stats WHERE arenateamid = a.arenateamid);
UPDATE arena_team a SET weekWins = ( SELECT wins_week FROM mangos-characters.arena_team_stats WHERE arenateamid = a.arenateamid);
UPDATE arena_team a SET rank = ( SELECT rank FROM mangos-characters.arena_team_stats WHERE arenateamid = a.arenateamid);
INSERT INTO arena_team_member (arenateamid, guid, weekGames, weekWins, seasonGames, seasonWins, personalRating) SELECT arenateamid, guid, played_week, wons_week, played_season, wons_season, personal_rating FROM mangos-characters.arena_team_member;
INSERT INTO auctionhouse (id, auctioneerguid, itemguid, itemowner, buyoutprice, time, buyguid, lastbid, startbid, deposit) SELECT id, houseid, itemguid, itemowner, buyoutprice, time, buyguid, lastbid, startbid, deposit FROM mangos-characters.auction;
INSERT INTO character_account_data SELECT * FROM mangos-characters.character_account_data;
INSERT INTO character_achievement SELECT * FROM mangos-characters.character_achievement;
INSERT INTO character_achievement_progress SELECT * FROM mangos-characters.character_achievement_progress;
INSERT INTO character_action SELECT * FROM mangos-characters.character_action;
-- character_aura -- this table is filled with buffs and similar spells, it can be dropped
INSERT INTO character_battleground_data SELECT * FROM mangos-characters.character_battleground_data;
INSERT INTO character_declinedname SELECT * FROM mangos-characters.character_declinedname;

INSERT INTO character_equipmentsets SELECT guid, setguid, setindex, name, iconname, item0, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17, item18 FROM mangos-characters.character_equipmentsets;
INSERT INTO character_gifts SELECT * FROM mangos-characters.character_gifts;
INSERT INTO character_glyphs (guid, spec) SELECT  DISTINCT guid, spec FROM mangos-characters.character_glyphs;
UPDATE character_glyphs a SET glyph1 = (SELECT glyph FROM mangos-characters.character_glyphs WHERE guid = a.guid AND spec  = a.spec AND slot = 0);
UPDATE character_glyphs a SET glyph2 = (SELECT glyph FROM mangos-characters.character_glyphs WHERE guid = a.guid AND spec  = a.spec AND slot = 1);
UPDATE character_glyphs a SET glyph3 = (SELECT glyph FROM mangos-characters.character_glyphs WHERE guid = a.guid AND spec  = a.spec AND slot = 2);
UPDATE character_glyphs a SET glyph4 = (SELECT glyph FROM mangos-characters.character_glyphs WHERE guid = a.guid AND spec  = a.spec AND slot = 3);
UPDATE character_glyphs a SET glyph5 = (SELECT glyph FROM mangos-characters.character_glyphs WHERE guid = a.guid AND spec  = a.spec AND slot = 4);
UPDATE character_glyphs a SET glyph6 = (SELECT glyph FROM mangos-characters.character_glyphs WHERE guid = a.guid AND spec  = a.spec AND slot = 5);
INSERT INTO character_homebind SELECT * FROM mangos-characters.character_homebind;

-- INSERT INTO character_instance SELECT guid, instance, permanent FROM mangos-characters.character_instance;
REPLACE INTO character_inventory  SELECT  guid, bag, slot, item FROM mangos-characters.character_inventory;
INSERT INTO character_pet SELECT id, entry, owner, modelid, CreatedBySpell, PetType, level, exp, Reactstate, name, renamed, slot, curhealth, curmana, curhappiness, savetime, abdata FROM mangos-characters.character_pet;
INSERT INTO character_pet_declinedname SELECT * FROM mangos-characters.character_pet_declinedname;
INSERT INTO character_queststatus (guid, quest, status, explored, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3, itemcount4) SELECT guid, quest, status, rewarded, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3, itemcount4 FROM mangos-characters.character_queststatus WHERE mangos-characters.character_queststatus.rewarded <> '1';
INSERT INTO character_queststatus_daily (guid,quest) SELECT * FROM mangos-characters.character_queststatus_daily; -- ?
INSERT INTO character_queststatus_weekly SELECT * FROM mangos-characters.character_queststatus_weekly;
INSERT INTO character_queststatus_rewarded (guid, quest) SELECT guid, quest FROM mangos-characters.character_queststatus WHERE mangos-characters.character_queststatus.rewarded ='1';
INSERT INTO character_reputation SELECT * FROM mangos-characters.character_reputation;
INSERT INTO character_skills SELECT * FROM mangos-characters.character_skills;
INSERT INTO character_social SELECT * FROM mangos-characters.character_social;
INSERT INTO character_spell SELECT * FROM mangos-characters.character_spell;
INSERT INTO character_spell_cooldown SELECT * FROM mangos-characters.character_spell_cooldown;
INSERT INTO character_stats (guid, maxhealth, maxpower1, maxpower2, maxpower3, maxpower4, maxpower5, maxpower6, maxpower7, strength, agility, stamina, intellect, spirit, armor, resHoly, resFire, resNature, resFrost, resShadow, resArcane, blockPct, dodgePct, parryPct, critPct, rangedCritPct, spellCritPct, attackPower, rangedAttackPower, spellPower) SELECT * FROM mangos-characters.character_stats;
-- character_talent -- talents will be reseted, sry
-- character_ticket -- tickets will differ alot, new table is now gm_ticket
-- INSERT INTO character_tutorial SELECT * FROM mangos-characters.character_tutorial;

-- corpse -- skip
-- group_instance -- skip
-- group_member -- skip
-- group -- skip
INSERT INTO guild SELECT * FROM mangos-characters.guild; 
INSERT INTO guild_bank_eventlog SELECT * FROM mangos-characters.guild_bank_eventlog;
INSERT INTO guild_bank_item SELECT guildid, TabId, SlotId, item_guid FROM mangos-characters.guild_bank_item;
INSERT INTO guild_bank_right SELECT * FROM mangos-characters.guild_bank_right;
INSERT INTO guild_bank_tab SELECT * FROM mangos-characters.guild_bank_tab;
INSERT INTO guild_eventlog SELECT * FROM mangos-characters.guild_eventlog;
INSERT INTO guild_member SELECT * FROM mangos-characters.guild_member;
INSERT INTO guild_rank SELECT * FROM mangos-characters.guild_rank;
INSERT INTO instance SELECT * FROM mangos-characters.instance;
INSERT INTO instance_reset SELECT * FROM mangos-characters.instance_reset;

ALTER TABLE `item_instance`
 ADD `data` longtext;

INSERT INTO item_instance (guid, owner_guid, charges, enchantments) SELECT  DISTINCT guid, owner_guid, DATA, DATA FROM mangos-characters.item_instance;
UPDATE item_instance a SET `data` = (SELECT DATA FROM mangos-characters.item_instance WHERE guid = a.guid AND owner_guid = a.owner_guid);
-- Temporarily change delimiter to prevent SQL syntax errors
DELIMITER ||

-- Function to convert ints from unsigned to signed
DROP FUNCTION IF EXISTS `uint32toint32`||
CREATE FUNCTION `uint32toint32`(input INT(10) UNSIGNED) RETURNS INT(11) SIGNED DETERMINISTIC
BEGIN
  RETURN input;
END||

-- Restore original delimiter
DELIMITER ;

-- Move data to new fields
UPDATE `item_instance` SET
`creatorGuid` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',10))+2,
length(SUBSTRING_INDEX(`data`,' ',10+1))-length(SUBSTRING_INDEX(DATA,' ',10))-1),

`giftCreatorGuid` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',12))+2,
length(SUBSTRING_INDEX(`data`,' ',12+1))-length(SUBSTRING_INDEX(DATA,' ',12))-1),

`count` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',14))+2,
length(SUBSTRING_INDEX(`data`,' ',14+1))-length(SUBSTRING_INDEX(DATA,' ',14))-1),

`duration` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',15))+2,
length(SUBSTRING_INDEX(`data`,' ',15+1))-length(SUBSTRING_INDEX(DATA,' ',15))-1),

`charges` = CONCAT_WS(' ',
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',16))+2,
length(SUBSTRING_INDEX(`data`,' ',16+1))-length(SUBSTRING_INDEX(DATA,' ',16))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',17))+2,
length(SUBSTRING_INDEX(`data`,' ',17+1))-length(SUBSTRING_INDEX(DATA,' ',17))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',18))+2,
length(SUBSTRING_INDEX(`data`,' ',18+1))-length(SUBSTRING_INDEX(DATA,' ',18))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',19))+2,
length(SUBSTRING_INDEX(`data`,' ',19+1))-length(SUBSTRING_INDEX(DATA,' ',19))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',20))+2,
length(SUBSTRING_INDEX(`data`,' ',20+1))-length(SUBSTRING_INDEX(DATA,' ',20))-1))),

`flags` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',21))+2,
length(SUBSTRING_INDEX(`data`,' ',21+1))-length(SUBSTRING_INDEX(DATA,' ',21))-1),


`enchantments` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',22))+2,
length(SUBSTRING_INDEX(`data`,' ',57+1))-length(SUBSTRING_INDEX(DATA,' ',22))-1),

`randomPropertyId` = uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',59))+2,
length(SUBSTRING_INDEX(`data`,' ',59+1))-length(SUBSTRING_INDEX(DATA,' ',59))-1)),

`durability` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',60))+2,
length(SUBSTRING_INDEX(`data`,' ',60+1))-length(SUBSTRING_INDEX(DATA,' ',60))-1),

`playedTime` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',62))+2,
length(SUBSTRING_INDEX(`data`,' ',62+1))-length(SUBSTRING_INDEX(DATA,' ',62))-1);

-- Drop function
DROP FUNCTION IF EXISTS `uint32toint32`;

-- Fix heroic item flag
UPDATE `item_instance` SET `flags`=`flags`&~0x8 WHERE
SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',3))+2,
length(SUBSTRING_INDEX(`data`,' ',3+1))-length(SUBSTRING_INDEX(DATA,' ',3))-1)
NOT IN (5043,5044,17302,17305,17308,21831);

SET @allowedFlags := 0x00000001 | 0x00000008 | 0x00000200 | 0x00001000 | 0x00008000 | 0x00010000;

UPDATE `item_instance` SET `flags` = (`flags` & @allowedFlags);


INSERT INTO mail SELECT * FROM mangos-characters.mail;
REPLACE INTO mail_items SELECT mail_id, item_guid, receiver FROM mangos-characters.mail_items;

-- Set values for new column from corresponding columns in other tables
UPDATE item_instance ii, mangos-characters.auction ah
SET ii.itemEntry = ah.item_template
WHERE ii.guid = ah.itemguid;

UPDATE item_instance ii, mangos-characters.character_inventory ci
SET ii.itemEntry = ci.item_template
WHERE ii.guid = ci.item;

UPDATE item_instance ii, mangos-characters.guild_bank_item gbi
SET ii.itemEntry = gbi.item_entry
WHERE ii.guid = gbi.item_guid;

UPDATE item_instance ii, mangos-characters.mail_items mi
SET ii.itemEntry = mi.item_template
WHERE ii.guid = mi.item_guid;

DELETE FROM item_instance WHERE itemEntry = 0; 
-- pet_aura -- skip
REPLACE INTO pet_spell SELECT guid, spell, active FROM mangos-characters.pet_spell;
INSERT INTO pet_spell_cooldown SELECT * FROM mangos-characters.pet_spell_cooldown;
INSERT INTO petition SELECT * FROM mangos-characters.petition;
INSERT INTO petition_sign SELECT * FROM mangos-characters.petition_sign;
INSERT INTO characters (guid, account, name, race, class, gender, level, xp, money, playerBytes, playerBytes2, playerFlags, position_x, position_y, position_z, map, orientation, taximask, online, cinematic, totaltime, leveltime, logout_time, is_logout_resting, rest_bonus, resettalents_cost, resettalents_time, trans_x, trans_y, trans_z, trans_o, transguid, extra_flags, stable_slots, at_login, zone, death_expire_time, taxi_path, arenaPoints, totalHonorPoints, todayHonorPoints, yesterdayHonorPoints, totalKills, todayKills, yesterdayKills, chosenTitle, knownCurrencies, watchedFaction, drunk, health, power1, power2, power3, power4, power5, power6, power7, specCount, activeSpec, exploredZones, equipmentCache, ammoId, knownTitles, actionBars) SELECT guid, account, name, race, class, gender, level, xp, money, playerBytes, playerBytes2, playerFlags, position_x, position_y, position_z, map, orientation, taximask, online, cinematic, totaltime, leveltime, logout_time, is_logout_resting, rest_bonus, resettalents_cost, resettalents_time, trans_x, trans_y, trans_z, trans_o, transguid, extra_flags, stable_slots, at_login, zone, death_expire_time, taxi_path, arenaPoints, totalHonorPoints, todayHonorPoints, yesterdayHonorPoints, totalKills, todayKills, yesterdayKills, chosenTitle, knownCurrencies, watchedFaction, drunk, health, power1, power2, power3, power4, power5, power6, power7, specCount, activeSpec, exploredZones, equipmentCache, ammoId, knownTitles, actionBars FROM mangos-characters.characters;

-- PART 2

USE auth -- (YOUR MYTH AUTH DB)

-- REALM TRANSFER QUERIES
REPLACE INTO account (id,username,sha_pass_hash,email,joindate,last_ip,failed_logins,locked,last_login,expansion,mutetime,locale) SELECT id,username,sha_pass_hash,email,joindate,last_ip,failed_logins,locked,last_login,expansion,mutetime,locale FROM realmd.account;
INSERT INTO realmcharacters SELECT * FROM realmd.realmcharacters;
INSERT INTO account_access (id, gmlevel, RealmID) SELECT id,gmlevel, active_realm_id FROM realmd.account WHERE realmd.account.gmlevel > '0';
UPDATE account_access SET RealmID = -1;
INSERT INTO account_banned SELECT * FROM realmd.account_banned;
DELETE FROM realmlist;
INSERT INTO realmlist (id, name, address, port, icon, timezone, allowedSecurityLevel, population, gamebuild) SELECT id, name, address, port, icon, timezone, allowedSecurityLevel, population, realmbuilds FROM realmd.realmlist;
INSERT INTO ip_banned SELECT * FROM realmd.ip_banned;
INSERT INTO uptime (realmid, starttime, startstring, uptime, maxplayers) SELECT realmid, starttime, startstring, uptime, maxplayers FROM realmd.uptime;
*/