/*
 * npc_guildhouse_keeper.cpp
 *
 *  Created on: Sep 7, 2011
 *      Author: Filchenko Nikolay
 */

#include "guildhouses.h"
#include "ScriptMgr.h"

#define GOSSIP_BUY "Buy GuildHouse (1000 gold)"
#define GOSSIP_SELL "Sell GuildHouse (500 gold)"
#define GOSSIP_PREV "Preview GuildHouse"
#define GOSSIP_CITY "Teleport to guild village"
#define GOSSIP_HOUSE "Teleport to your GuildHouse"

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
#define CODEBOX_SELL         "Enter \"" CODE_SELL "\" If you really want to sell your GuildHouse."

enum {
    ICON_GOSSIP_BALOON      = 0,
    ICON_GOSSIP_WING        = 2,
    ICON_GOSSIP_BOOK        = 3,
    ICON_GOSSIP_WHEEL1      = 4,
    ICON_GOSSIP_WHEEL2      = 5,
    ICON_GOSSIP_GOLD        = 6,
    ICON_GOSSIP_BALOONDOTS  = 7,
    ICON_GOSSIP_TABARD      = 8,
    ICON_GOSSIP_XSWORDS     = 9,

    COST_GH_BUY             = 10000000,  //1000 g.
    COST_GH_SELL            = 5000000,   //500 g.
};


enum {
    ACTION_SELL = 1,
    ACTION_CITY,
    ACTION_HOUSE,
    ACTION_BUYLIST,
    ACTION_PREVLIST,
    ACTION_BUY = 1 << 30,
    ACTION_PREV = 1 << 31,
};


class guildhouseKeeper : public CreatureScript
{
public:
    guildhouseKeeper() : CreatureScript("npc_guildhouse_keeper") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, GOSSIP_CITY,
                    GOSSIP_SENDER_MAIN, ACTION_CITY);

        if (GuildhouseManager::instance()->getGH(pPlayer->GetGuildId()))
        {
            pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, GOSSIP_HOUSE,
                            GOSSIP_SENDER_MAIN, ACTION_HOUSE);
        }

        if ((pPlayer->GetRank() == 0) && (pPlayer->GetGuildId() != 0))
        {
            if (GuildhouseManager::instance()->getGH(pPlayer->GetGuildId()))
            {
                pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,
                        ICON_GOSSIP_GOLD, GOSSIP_SELL, GOSSIP_SENDER_MAIN,
                        ACTION_SELL, CODEBOX_SELL, 0, true);
            }
            else
            {
                pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, GOSSIP_BUY,
                        GOSSIP_SENDER_MAIN, ACTION_BUYLIST);
                pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_WING, GOSSIP_PREV,
                        GOSSIP_SENDER_MAIN, ACTION_PREVLIST);
            }
        }

        pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *pCreature, uint32 sender, uint32 action )
    {
        if (sender != GOSSIP_SENDER_MAIN)
            return false;

        player->CLOSE_GOSSIP_MENU();

        switch (action)
        {
            case ACTION_HOUSE:
                //player->CLOSE_GOSSIP_MENU();
                teleportPlayerToGuildHouse(player, pCreature);
                break;
            case ACTION_CITY:
                //player->CLOSE_GOSSIP_MENU();
                teleportPlayerToGuildCity(player, pCreature);
                break;
            case ACTION_BUYLIST:
                //player->CLOSE_GOSSIP_MENU();
                showFreeList(player, pCreature, ACTION_BUY);
                break;
            case ACTION_PREVLIST:
                //player->CLOSE_GOSSIP_MENU();
                showFreeList(player, pCreature, ACTION_PREV);
                break;
            default:
                if ((action & ACTION_BUY) == ACTION_BUY)
                {
                    if (player->GetMoney() < COST_GH_BUY)
                    {
                        char msg[100];
                        sprintf(msg, MSG_NOTENOUGHMONEY, COST_GH_BUY / 10000);
                        pCreature->MonsterWhisper(msg, player->GetGUID());
                        break;
                    }
                    uint32 result = GuildhouseManager::instance()->buy(player->GetGuildId(),
                            action ^ ACTION_BUY);
                    switch (result)
                    {
                    case 0:
                    {
                        pCreature->MonsterSay(MSG_CONGRATULATIONS, LANG_UNIVERSAL, player->GetGUID());
                        player->ModifyMoney(-COST_GH_BUY);
                        /*uint32 phaseMask = GuildhouseManager::instance()->getPlayerAccess(player);
                        phaseMask = ~phaseMask;
                        player->SetPhaseMask(phaseMask, true);*/
                        reloadGuilds();
                    }
                    break;
                    case 1:
                        pCreature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
                    break;
                    }

                }
                else if ((action & ACTION_PREV) == ACTION_PREV)
                {
                    if (GuildhouseManager::instance()->getFreeGH(action ^ ACTION_PREV))
                    {
                        teleportPlayerToGuildHouse(player, pCreature, action ^ ACTION_PREV);
                    }
                    else
                    {
                        pCreature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
                    }
                }
                break;
        }

        return true;
    }

    bool OnGossipSelectCode(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction, const char* code)
    {
        if(uiSender == GOSSIP_SENDER_MAIN)
        {
            if(uiAction == ACTION_SELL)
            {
                int i = -1;
                if (strlen(code) + 1 == sizeof CODE_SELL)
                    i = strcmp(CODE_SELL, code);

                if (i == 0)
                {
                    if (GuildhouseManager::instance()->sell(pPlayer->GetGuildId()) == 0)
                    {
                        pPlayer->ModifyMoney(COST_GH_SELL);
                        char msg[100];
                        sprintf(msg, MSG_SOLD, COST_GH_SELL / 10000);
                        pCreature->MonsterWhisper(msg, pPlayer->GetGUID());

                        reloadGuilds();
                        /*uint32 phaseMask = GuildhouseManager::instance()->getPlayerAccess(pPlayer);
                        phaseMask = ~phaseMask;
                        pPlayer->SetPhaseMask(phaseMask, true);*/
                    }
                    else
                    {
                        pCreature->MonsterWhisper(MSG_NOGUILDHOUSE, pPlayer->GetGUID());
                    }
                }

                pPlayer->CLOSE_GOSSIP_MENU();
                return true;
            }
        }
        return false;
    }

private:
    void teleportPlayerToGuildCity(Player *player, Creature *pCreature)
    {
        player->TeleportTo(169, -1340.568481, 1330.279419, 92.007797, 0.0f);
    }

    void teleportPlayerToGuildHouse(Player *player, Creature *pCreature, uint32 ghid = -1)
    {
        if (player->GetGuildId() == 0)
        {
            pCreature->MonsterWhisper(MSG_NOTINGUILD, player->GetGUID());
            return;
        }

        if (!player->getAttackers().empty())
        {
            pCreature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, player->GetGUID());
            return;
        }

        float x, y, z;
        uint32 map;

        if (ghid != -1)
        {
            Guildhouse * gh = GuildhouseManager::instance()->getGH(player->GetGuildId());
            if (gh)
                gh->coords(x, y, z, map);
            else
            {
                pCreature->MonsterWhisper(MSG_NOGUILDHOUSE, player->GetGUID());
                return;
            }
        }
        else
        {
            Guildhouse * gh = GuildhouseManager::instance()->getFreeGH(ghid);
            if (gh)
                gh->coords(x, y, z, map);
            else
            {
                pCreature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
                return;
            }
        }

        player->TeleportTo(map, x, y, z, 0.0f);
    }

    void showFreeList(Player * player, Creature * pCreature, uint32 action = 0)
    {
        std::vector<Guildhouse*> free = GuildhouseManager::instance()->getFree();
        for (std::vector<Guildhouse*>::iterator it = free.begin();
                it != free.end(); ++it)
        {
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_TABARD, (*it)->getName(), GOSSIP_SENDER_MAIN,
                    (*it)->getId() | action);
        }

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
    }
    /*CreatureAI* GetAI(Creature* pCreature) const
    {
        return new guildhouseKeeperAI (pCreature);
    }*/
};

void AddSC_npc_guildhouse_keeper()
{
    new guildhouseKeeper;
}
