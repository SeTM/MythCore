/* For Dev Realm ONLY! */
/* DEVELOPMENT REALM: LOGON.MMOGATE.NET DEV REALM!*/
/* Registration: http://wow-legendary.net/registration.html 
   Realm-List: set realmlist logon.wow-legendary.net 
   Realm: WoW - Legendary.Net Development 
   GM Level: 0 + all command except this: */
UPDATE `command` SET `security` = 0;
UPDATE `command` SET `security` = 4 WHERE `name` LIKE '%account%';
UPDATE `command` SET `security` = 4 WHERE `name` LIKE '%ban%';
UPDATE `command` SET `security` = 4 WHERE `name` LIKE '%server%';
UPDATE `command` SET `security` = 4 WHERE `name` LIKE '%reload%';
UPDATE `command` SET `security` = 4 WHERE `name` LIKE '%character%';