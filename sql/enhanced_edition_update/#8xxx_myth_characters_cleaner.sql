-- DBs
-- USE `wow_characters`;
-- USE wow_login; REPLACE with your DB.

-- 1.1 Delete characters with permanent ban older than 90 days
DELETE FROM `wow_characters`.`characters` WHERE guid IN (SELECT guid FROM `wow_characters`.`character_banned` WHERE bandate = unbandate AND active = 1 AND UNIX_TIMESTAMP(NOW()) - bandate > 60 * 60 * 24 * 90);
-- 1.2. Delete characters without money and level less than 60
DELETE FROM `wow_characters`.`characters` WHERE money = 0 AND `level` < 60;
-- 1.3. Delete characters with level less than 11, who logged out more than 120 days ago
DELETE FROM `wow_characters`.`characters` WHERE `level` < 11 AND UNIX_TIMESTAMP(NOW()) - `logout_time` > 60 * 60 * 24 * 120;
-- 1.4. Delete low-level characters (level < 3)
DELETE FROM `wow_characters`.`characters` WHERE `level` < 3;

-- 1.1. Delete empty accounts (without characters)
DELETE FROM `wow_login`.`account` WHERE id NOT IN (SELECT DISTINCT account FROM `wow_characters`.`characters`);
-- 1.2. Delete accounts who last logged in more than 120 days ago
DELETE FROM `wow_login`.`account` WHERE DATEDIFF(CURDATE(), last_login) > 120;
-- 1.3. Delete accounts with permanent ban older than 90 days
DELETE FROM `wow_login`.`account` WHERE id IN (SELECT id FROM `wow_login`.`account_banned` WHERE bandate = unbandate AND active = 1 AND UNIX_TIMESTAMP(NOW()) - bandate > 60 * 60 * 24 * 90);

-- 2. Delete records from account_access for inexistent accounts
DELETE FROM `wow_login`.`account_access` WHERE id NOT IN (SELECT id FROM `wow_login`.`account`);

-- 3. Delete records from account_banned for inexistent accounts
DELETE FROM `wow_login`.`account_banned` WHERE id NOT IN (SELECT id FROM `wow_login`.`account`);

-- 4.1. Delete records from realmcharacters for inexistent realms
DELETE FROM `wow_login`.`realmcharacters` WHERE realmid NOT IN (SELECT id FROM `wow_login`.`realmlist`);
-- 4.2. Delete records from realmcharacters for inexistent accounts
DELETE FROM `wow_login`.`realmcharacters` WHERE acctid NOT IN (SELECT id FROM `wow_login`.`account`);

-- 1. Delete characters for inexistent accounts
DELETE FROM `wow_characters`.`characters` WHERE account NOT IN (SELECT id FROM `wow_login`.`account`) AND account <> 0;


-- 2. Cleanup tables referencing auth.account.id
DELETE FROM `wow_characters`.`account_data` WHERE accountId NOT IN (SELECT id FROM `wow_login`.`account`);
DELETE FROM `wow_characters`.`account_instance_times` WHERE accountId NOT IN (SELECT id FROM `wow_login`.`account`);
DELETE FROM `wow_characters`.`account_tutorial` WHERE accountId NOT IN (SELECT id FROM `wow_login`.`account`);

-- 3. Cleanup arena tables
-- 3.1. Remove arena teams with inexistent captain
-- DELETE FROM `wow_characters`.`arena_team` WHERE captainguid NOT IN (SELECT guid FROM `wow_characters`.`characters`)
-- 3.2. Remove inexistent arena team members
DELETE FROM `wow_characters`.`arena_team_member` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
-- 3.3. Remove arena team members for inexistent teams
DELETE FROM `wow_characters`.`arena_team_member` WHERE arenateamid NOT IN (SELECT arenateamid FROM `wow_characters`.`arena_team`);
-- 3.4. Remove empty arena teams
DELETE FROM `wow_characters`.`arena_team` WHERE arenateamid NOT IN (SELECT arenateamid FROM `wow_characters`.`arena_team_member`);

-- 4. Cleanup tabels referencing characters.guid
DELETE FROM `wow_characters`.`auctionhouse` WHERE itemowner NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_account_data` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_achievement` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_achievement_progress` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_action` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_arena_stats` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_aura` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_aura` WHERE caster_guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_banned` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_battleground_data` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_battleground_random` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_declinedname` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_equipmentsets` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_gifts` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_glyphs` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_homebind` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_instance` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_inventory` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_pet` WHERE owner NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_queststatus` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_queststatus_daily` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_queststatus_rewarded` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_queststatus_weekly` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_reputation` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_skills` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_social` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_social` WHERE friend NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_spell` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_spell_cooldown` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_stats` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`character_talent` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`corpse` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`gm_tickets` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
-- DELETE FROM `wow_characters`.`item_instance` WHERE owner_guid <> 0 AND owner_guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`item_refund_instance` WHERE player_guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`mail` WHERE sender NOT IN (SELECT guid FROM `wow_characters`.`characters`) AND messageType = 0;
DELETE FROM `wow_characters`.`mail` WHERE receiver NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`mail_items` WHERE receiver NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`petition` WHERE ownerguid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`petition_sign` WHERE ownerguid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
DELETE FROM `wow_characters`.`petition_sign` WHERE playerguid NOT IN (SELECT guid FROM `wow_characters`.`characters`);

-- 5. Cleanup group tables
-- 5.1. Delete groups with inexistent leader
-- DELETE FROM `wow_characters`.`groups` WHERE leaderGuid NOT IN (SELECT guid FROM `wow_characters`.`characters`)
-- 5.2. Delete inexistent group members
DELETE FROM `wow_characters`.`group_member` WHERE memberGuid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
-- 5.3. Delete members for inexistent groups
DELETE FROM `wow_characters`.`group_member` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`groups`);
-- 5.4. Delete empty groups
DELETE FROM `wow_characters`.`groups` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`group_member`);
-- 5.5. Delete referencing data for inexistent groups
DELETE FROM `wow_characters`.`group_instance` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`groups`);

-- 6. Cleanup guild tables
-- 6.1. Delete guilds with inexistent leader
-- DELETE FROM `wow_characters`.`guild` WHERE leaderGuid NOT IN (SELECT guid FROM `wow_characters`.`characters`)
-- 6.2. Delete inexistent guild members
DELETE FROM `wow_characters`.`guild_member` WHERE guid NOT IN (SELECT guid FROM `wow_characters`.`characters`);
-- 6.3. Delete members for inexistent guilds
DELETE FROM `wow_characters`.`guild_member` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);
-- 6.4. Delete empty guilds
DELETE FROM `wow_characters`.`guild` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild_member`);
-- 6.5. Delete referencing data for inexistent guilds
DELETE FROM `wow_characters`.`guild_bank_eventlog` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);
DELETE FROM `wow_characters`.`guild_bank_item` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);
DELETE FROM `wow_characters`.`guild_bank_right` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);
DELETE FROM `wow_characters`.`guild_bank_tab` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);
DELETE FROM `wow_characters`.`guild_eventlog` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);
DELETE FROM `wow_characters`.`guild_rank` WHERE guildid NOT IN (SELECT guildid FROM `wow_characters`.`guild`);

-- 7. Cleanup tables referencing character_pet.id
DELETE FROM `wow_characters`.`pet_aura` WHERE guid NOT IN (SELECT id FROM `wow_characters`.`character_pet`);
DELETE FROM `wow_characters`.`pet_spell` WHERE guid NOT IN (SELECT id FROM `wow_characters`.`character_pet`);
DELETE FROM `wow_characters`.`pet_spell_cooldown` WHERE guid NOT IN (SELECT id FROM `wow_characters`.`character_pet`);

-- 8. Cleanup mail tables
DELETE FROM `wow_characters`.`mail_items` WHERE mail_id NOT IN (SELECT id FROM `wow_characters`.`mail`);

-- 9. Cleanup tables referencing item_instance.guid
-- 9.1. Delete auction records for inexistent items
DELETE FROM `wow_characters`.`auctionhouse` WHERE itemguid NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);
-- 9.2. Delete gifts for inexistent items
DELETE FROM `wow_characters`.`character_gifts` WHERE item_guid NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);
-- 9.3. Delete inventory records for inexistent items
DELETE FROM `wow_characters`.`character_inventory` WHERE item NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);
-- 9.4. Delete guild bank records for inexistent items
DELETE FROM `wow_characters`.`guild_bank_item` WHERE item_guid NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);
-- 9.5. Delete item refund records for inexistent items
DELETE FROM `wow_characters`.`item_refund_instance` WHERE item_guid NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);
-- 9.6. Delete item refund records for inexistent items
DELETE FROM `wow_characters`.`item_soulbound_trade_data` WHERE itemGuid NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);
-- 9.7. Delete mail items records for inexistent items
DELETE FROM `wow_characters`.`mail_items` WHERE item_guid NOT IN (SELECT guid FROM `wow_characters`.`item_instance`);

USE `wow_characters`;
-- Cleanup items not bound to anything (auction, inventory, guild bank or mail)
CREATE TABLE items_temp (guid INT(10) UNSIGNED PRIMARY KEY);
REPLACE INTO items_temp SELECT itemguid FROM auctionhouse;
REPLACE INTO items_temp SELECT item FROM character_inventory;
REPLACE INTO items_temp SELECT item_guid FROM guild_bank_item;
REPLACE INTO items_temp SELECT item_guid FROM mail_items;
DELETE FROM item_instance WHERE guid NOT IN (SELECT guid FROM items_temp);
DROP TABLE items_temp;