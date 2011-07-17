ALTER TABLE `guild_rank` CHANGE `rname` `rname` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' NOT NULL;


-- Truncate Character`s/Pet`s active Buffs, to avoid crashes. Because Mech. && Spells Changed.
TRUNCATE character_aura;
TRUNCATE pet_aura;