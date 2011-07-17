ALTER TABLE `character_stats` ADD `resilience` INT UNSIGNED NOT NULL DEFAULT 0;

-- Truncate Character`s/Pet`s active Buffs, to avoid crashes. Because Mech. && Spells Changed.
TRUNCATE character_aura;
TRUNCATE pet_aura;