/*
 * guildhouse_keeper.cpp
 *
 *  Created on: Sep 5, 2011
 *      Author: Filchenko Nikolay
 */

#include "Config.h"

//extern DatabaseMysql SD2Database;

//extern DatabaseType WorldDatabase;

#define MSG_GOSSIP_TELE_HOUSE    "Teleport to our GuildHouse"
#define MSG_GOSSIP_TELE_CITY     "Teleport to guild village"
#define MSG_GOSSIP_PREV          "Preview GuildHouse"
#define MSG_GOSSIP_BUY           "Buy GuildHouse (1000 gold)"
#define MSG_GOSSIP_SELL          "Sell GuildHouse (500 gold)"
#define MSG_GOSSIP_NEXTPAGE      "Next Page -->"
#define MSG_INCOMBAT             "You are in combat!"
#define MSG_NOGUILDHOUSE         "Your guild dont have any GuildHouse!"
#define MSG_NOFREEGH             "Unfortunately, all GuildHouses are in use."
#define MSG_ALREADYHAVEGH        "Sorry, but you already have GuildHouse (%s)."
#define MSG_NOTENOUGHMONEY       "Not enough money. You must have %u gold to buy a GuildHouses."
#define MSG_GHOCCUPIED           "Unfortunately, this GuildHouses already in use."
#define MSG_CONGRATULATIONS      "Congratulations! You bought this Guild House!"
#define MSG_SOLD                 "You sold your GuildHouse. Here is %u in gold."
#define MSG_NOTINGUILD           "You are not in a guild. Join or create one."

#define CODE_SELL                "SELL"
#define MSG_CODEBOX_SELL         "Enter \"" CODE_SELL "\" If you really want to sell your GuildHouse."

#define OFFSET_GH_ID_TO_ACTION   1500
#define OFFSET_GH_ID_TO_ACTION_P 3000
#define OFFSET_SHOWBUY_FROM      10000
#define OFFSET_SHOWPREV_FROM     20000

#define ACTION_TELE              1001
#define ACTION_SHOW_BUYLIST      1002  //deprecated. Use (OFFSET_SHOWBUY_FROM + 0) instead
#define ACTION_SELL_GUILDHOUSE   1003
#define ACTION_SHOW_PREVLIST     1004
#define ACTION_TELE_CITY         1005
#define ACTION_PHASE              1006

#define ICON_GOSSIP_BALOON       0
#define ICON_GOSSIP_WING         2
#define ICON_GOSSIP_BOOK         3
#define ICON_GOSSIP_WHEEL1       4
#define ICON_GOSSIP_WHEEL2       5
#define ICON_GOSSIP_GOLD         6
#define ICON_GOSSIP_BALOONDOTS   7
#define ICON_GOSSIP_TABARD       8
#define ICON_GOSSIP_XSWORDS      9

#define COST_GH_BUY              10000000  //1000 g.
#define COST_GH_SELL             5000000   //500 g.

#define GOSSIP_COUNT_MAX         10

bool isPlayerGuildLeader(Player *player)
{
    return (player->GetRank() == 0) && (player->GetGuildId() != 0);
}

void togglePhaseMask(Player *player, Creature *_creature)
{
    uint32 mask = player->GetPhaseMask();
    mask = mask ^ 2;
    player->SetPhaseMask(mask, true);
}

bool getGuildHouseCoords(uint32 guildId, float &x, float &y, float &z, uint32 &map)
{
    if (guildId == 0)
    {
        //if player has no guild
        return false;
    }

    QueryResult result;
    result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `map` FROM `guildhouses` WHERE `guildId` = %u", guildId);
    if(result)
    {
        Field *fields = result->Fetch();
        x = fields[0].GetFloat();
        y = fields[1].GetFloat();
        z = fields[2].GetFloat();
        map = fields[3].GetUInt32();
        return true;
    }
    return false;
}

bool getGuildHouseCoordsEx(uint32 ghId, float &x, float &y, float &z, uint32 &map)
{
    QueryResult result;
    result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `map` FROM `guildhouses` WHERE `id` = %u", ghId);
    if(result)
    {
        Field *fields = result->Fetch();
        x = fields[0].GetFloat();
        y = fields[1].GetFloat();
        z = fields[2].GetFloat();
        map = fields[3].GetUInt32();
        return true;
    }
    return false;
}

void teleportPlayerToGuildHouse(Player *player, Creature *_creature)
{
    if (player->GetGuildId() == 0)
    {
        //if player has no guild
        _creature->MonsterWhisper(MSG_NOTINGUILD, player->GetGUID());
        return;
    }

    if (!player->getAttackers().empty())
    {
        //if player in combat
        _creature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, player->GetGUID());
        return;
    }

    float x, y, z;
    uint32 map;

    if (getGuildHouseCoords(player->GetGuildId(), x, y, z, map))
    {
        //teleport player to the specified location
        player->TeleportTo(map, x, y, z, 0.0f);
    }
    else
        _creature->MonsterWhisper(MSG_NOGUILDHOUSE, player->GetGUID());

}

//.go -1650 -577 125 169
void teleportPlayerToGuildCity(Player *player, Creature *_creature)
{
    player->TeleportTo(169, -1340.568481, 1330.279419, 92.007797, 0.0f);
}

bool showBuyList(Player *player, Creature *_creature, uint32 showFromId = 0)
{
    //show not occupied guildhouses

    QueryResult result;
    result = WorldDatabase.PQuery("SELECT `id`, `comment` FROM `guildhouses` WHERE `guildId` = 0 AND `id` > %u ORDER BY `id` ASC LIMIT %u",
        showFromId, GOSSIP_COUNT_MAX);

    if (result)
    {
        uint32 guildhouseId = 0;
        std::string comment = "";
        do
        {

            Field *fields = result->Fetch();

            guildhouseId = fields[0].GetInt32();
            comment = fields[1].GetString();

            //send comment as a gossip item
            //transmit guildhouseId in Action variable
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_TABARD, comment, GOSSIP_SENDER_MAIN,
                guildhouseId + OFFSET_GH_ID_TO_ACTION);

        } while (result->NextRow());

        if (result->GetRowCount() == GOSSIP_COUNT_MAX)
        {
            //assume that we have additional page
            //add link to next GOSSIP_COUNT_MAX items
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_GOSSIP_NEXTPAGE, GOSSIP_SENDER_MAIN,
                guildhouseId + OFFSET_SHOWBUY_FROM);
        }


        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());

        return true;
    } else
    {
        if (showFromId = 0)
        {
            //all guildhouses are occupied
            _creature->MonsterWhisper(MSG_NOFREEGH, player->GetGUID());
            player->CLOSE_GOSSIP_MENU();
        } else
        {
            //this condition occurs when COUNT(guildhouses) % GOSSIP_COUNT_MAX == 0
            //just show GHs from beginning
            showBuyList(player, _creature, 0);
        }
    }

    return false;
}

bool showPrevList(Player *player, Creature *_creature, uint32 showFromId = 0)
{
    //show not occupied guildhouses

    QueryResult result;
    result = WorldDatabase.PQuery("SELECT `id`, `comment` FROM `guildhouses` WHERE `guildId` = 0 AND `id` > %u ORDER BY `id` ASC LIMIT %u",
        showFromId, GOSSIP_COUNT_MAX);

    if (result)
    {
        uint32 guildhouseId = 0;
        std::string comment = "";
        do
        {

            Field *fields = result->Fetch();

            guildhouseId = fields[0].GetInt32();
            comment = fields[1].GetString();

            //send comment as a gossip item
            //transmit guildhouseId in Action variable
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_TABARD, comment, GOSSIP_SENDER_MAIN,
                guildhouseId + OFFSET_GH_ID_TO_ACTION_P);

        } while (result->NextRow());

        if (result->GetRowCount() == GOSSIP_COUNT_MAX)
        {
            //assume that we have additional page
            //add link to next GOSSIP_COUNT_MAX items
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_GOSSIP_NEXTPAGE, GOSSIP_SENDER_MAIN,
                guildhouseId + OFFSET_SHOWPREV_FROM);
        }


        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());

        return true;
    } else
    {
        if (showFromId = 0)
        {
            //all guildhouses are occupied
            _creature->MonsterWhisper(MSG_NOFREEGH, player->GetGUID());
            player->CLOSE_GOSSIP_MENU();
        } else
        {
            //this condition occurs when COUNT(guildhouses) % GOSSIP_COUNT_MAX == 0
            //just show GHs from beginning
            showPrevList(player, _creature, 0);
        }
    }

    return false;
}

bool isPlayerHasGuildhouse(Player *player, Creature *_creature, bool whisper = false)
{

    QueryResult result;

    result = WorldDatabase.PQuery("SELECT `comment` FROM `guildhouses` WHERE `guildId` = %u",
        player->GetGuildId());

    if (result)
    {
        if (whisper)
        {
            //whisper to player "already have etc..."
            Field *fields = result->Fetch();
            char msg[100];
            sprintf(msg, MSG_ALREADYHAVEGH, fields[0].GetString().c_str());
            _creature->MonsterWhisper(msg, player->GetGUID());
        }

        return true;
    }
    return false;

}

void buyGuildhouse(Player *player, Creature *_creature, uint32 guildhouseId)
{
    if (player->GetMoney() < COST_GH_BUY)
    {
        //show how much money player need to buy GH (in gold)
        char msg[100];
        sprintf(msg, MSG_NOTENOUGHMONEY, COST_GH_BUY / 10000);
        _creature->MonsterWhisper(msg, player->GetGUID());
        return;
    }

    if (isPlayerHasGuildhouse(player, _creature, true))
    {
        //player already have GH
        return;
    }

    QueryResult result;

    //check if somebody already occupied this GH
    result = WorldDatabase.PQuery("SELECT `id` FROM `guildhouses` WHERE `id` = %u AND `guildId` <> 0",
        guildhouseId);

    if (result)
    {
        _creature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
        return;
    }

    //update DB
    result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = %u WHERE `id` = %u",
        player->GetGuildId(), guildhouseId);

    //if (result)

    player->ModifyMoney(-COST_GH_BUY);
    _creature->MonsterSay(MSG_CONGRATULATIONS, LANG_UNIVERSAL, player->GetGUID());

}

void prevGuildhouse(Player *player, Creature *_creature, uint32 guildhouseId)
{
    if (isPlayerHasGuildhouse(player, _creature, true))
    {
        //player already have GH
        return;
    }

    QueryResult result;

    //check if somebody already occupied this GH
    result = WorldDatabase.PQuery("SELECT `id` FROM `guildhouses` WHERE `id` = %u AND `guildId` <> 0",
        guildhouseId);

    if (result)
    {
        _creature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
        return;
    }

    if (player->GetGuildId() == 0)
    {
        //if player has no guild
        _creature->MonsterWhisper(MSG_NOTINGUILD, player->GetGUID());
        return;
    }

    if (!player->getAttackers().empty())
    {
        //if player in combat
        _creature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, player->GetGUID());
        return;
    }

    float x, y, z;
    uint32 map;

    if (getGuildHouseCoordsEx(guildhouseId, x, y, z, map))
    {
        //teleport player to the specified location
        player->TeleportTo(map, x, y, z, 0.0f);
    }
    else
        _creature->MonsterWhisper(MSG_NOGUILDHOUSE, player->GetGUID());

}

void sellGuildhouse(Player *player, Creature *_creature)
{
    if (isPlayerHasGuildhouse(player, _creature))
    {
        QueryResult result;

        result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = 0 WHERE `guildId` = %u",
        player->GetGuildId());

        //if (result)

        player->ModifyMoney(COST_GH_SELL);

        //display message e.g. "here your money etc."
        char msg[100];
        sprintf(msg, MSG_SOLD, COST_GH_SELL / 10000);
        _creature->MonsterWhisper(msg, player->GetGUID());
    }
}

class guildhouseKeeper : public CreatureScript
{
public:
    guildhouseKeeper() : CreatureScript("npc_guildhouse_keeper") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, MSG_GOSSIP_TELE_HOUSE,
            GOSSIP_SENDER_MAIN, ACTION_TELE);
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, MSG_GOSSIP_TELE_CITY,
                    GOSSIP_SENDER_MAIN, ACTION_TELE_CITY);
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, "TOGGLE MASK",
                            GOSSIP_SENDER_MAIN, ACTION_PHASE);

        if (isPlayerGuildLeader(pPlayer))
        {
            //show additional menu for guild leader
            pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, MSG_GOSSIP_BUY,
                GOSSIP_SENDER_MAIN, ACTION_SHOW_BUYLIST);
            pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_WING,MSG_GOSSIP_PREV,
                        GOSSIP_SENDER_MAIN, ACTION_SHOW_PREVLIST);
            if (isPlayerHasGuildhouse(pPlayer, pCreature))
            {
                //and additional for guildhouse owner
                pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, ICON_GOSSIP_GOLD, MSG_GOSSIP_SELL, GOSSIP_SENDER_MAIN, ACTION_SELL_GUILDHOUSE, MSG_CODEBOX_SELL, 0, true);
            }
        }
        pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 action )
    {
        if (sender != GOSSIP_SENDER_MAIN)
            return false;

        switch (action)
        {
            case ACTION_PHASE:
                togglePhaseMask(player, _creature);
                break;
            case ACTION_TELE:
                //teleport player to GH
                player->CLOSE_GOSSIP_MENU();
                teleportPlayerToGuildHouse(player, _creature);
                break;
            case ACTION_TELE_CITY:
                //teleport player to GC
                player->CLOSE_GOSSIP_MENU();
                teleportPlayerToGuildCity(player, _creature);
                break;
            case ACTION_SHOW_BUYLIST:
                //show list of GHs which currently not occupied
                showBuyList(player, _creature);
                break;
            case ACTION_SHOW_PREVLIST:
                //show list of GHs which currently not occupied
                showPrevList(player, _creature);
                break;
            default:
                if (action > OFFSET_SHOWPREV_FROM)
                {
                    showPrevList(player, _creature, action - OFFSET_SHOWBUY_FROM);
                } else if (action > OFFSET_SHOWBUY_FROM)
                {
                    showBuyList(player, _creature, action - OFFSET_SHOWBUY_FROM);
                } else if (action > OFFSET_GH_ID_TO_ACTION_P)
                {
                    //player clicked on buy list
                    player->CLOSE_GOSSIP_MENU();
                    //get guildhouseId from action
                    //guildhouseId = action - OFFSET_GH_ID_TO_ACTION
                    prevGuildhouse(player, _creature, action - OFFSET_GH_ID_TO_ACTION_P);
                } else if (action > OFFSET_GH_ID_TO_ACTION)
                {
                    //player clicked on buy list
                    player->CLOSE_GOSSIP_MENU();
                    //get guildhouseId from action
                    //guildhouseId = action - OFFSET_GH_ID_TO_ACTION
                    buyGuildhouse(player, _creature, action - OFFSET_GH_ID_TO_ACTION);
                }
                break;
        }

        return true;
    }

    bool OnGossipSelectCode(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction, const char* code)
    {
        if(uiSender == GOSSIP_SENDER_MAIN)
        {
            if(uiAction == ACTION_SELL_GUILDHOUSE)
            {
                int i = -1;
                //try
                //{
                    //compare code
                    if (strlen(code) + 1 == sizeof CODE_SELL)
                        i = strcmp(CODE_SELL, code);
                //}
                //This is very stupid catch
                //catch(char *str) {error_db_log(str);}

                if (i == 0)
                {
                    //right code
                    sellGuildhouse(pPlayer, pCreature);
                }
                pPlayer->CLOSE_GOSSIP_MENU();
                return true;
            }
        }
        return false;
    }

    /*CreatureAI* GetAI(Creature* pCreature) const
    {
        return new guildhouseKeeperAI (pCreature);
    }*/
};


void AddSC_npc_guildhouse_keeper()
{
    new guildhouseKeeper;
    /*
    Script *newscript;
    newscript = new Script;
    newscript->Name = "guildhouse_keeper";
    newscript->pGossipHello = &GossipHello_guildmaster;
    newscript->pGossipSelect = &GossipSelect_guildmaster;
    newscript->pGossipSelectWithCode =  &GossipSelectWithCode_guildmaster;
    newscript->RegisterSelf();*/
}
