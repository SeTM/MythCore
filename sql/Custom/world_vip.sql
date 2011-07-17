-- Custom feature, read syntax for explonation. 
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip debuff',1,'Syntax: .vip debuff - removes Resurrection Sickness and Deserter debuffs from owner');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip map', 1, 'Syntax: .vip map - reveals all maps to owner');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip bank', 1, 'Syntax: .vip bank - Show your bank inventory.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip repair', 1, 'Syntax: .vip repair - repair all your items.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip resettalents', 1, 'Syntax: .vip resettalents - reset talents to your character.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip whispers', 1, 'Syntax: .vip whispers - Enable/disable accepting whispers by VIP accounts from players.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip taxi', 1, 'Syntax: .vip taxi - reveals all taxipaths to owner');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip home', 1, 'Syntax: .vip home - teleport owner to home(ignoring CD on Hearthstone)');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip capital', 1, 'Syntax: .vip capital - teleport owner to capital(Orgrimmar/Stormwind) depending on faction of player');

INSERT INTO `trinity_string` VALUES (11778, 'You can\'t use command while being dead/stealthed or being in arena/bg or being in combat.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Вы не можете использовать комманду находясь на арене/БГ, в комбате/стелсе или будучи мертвым.');
INSERT INTO `trinity_string` VALUES (11779, 'You can\'t use command while being dead/stealthed or being in arena/bg or being in combat.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Вы не можете использовать комманду находясь на арене/БГ/подземелье, в комбате/стелсе или будучи мертвым.')

-- Not working on Myth-Core. Need full rewrite AuctionHouse system :(
-- REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('vip auction', 1, 'Syntax: .vip auction - opens auctionhouse window to character.');
