#include "Config.h"

#define COST_RACE 3000
#define COST_FACTION 4000
#define COST_RENAME 1000
#define COST_GOLD 500

#define STRING(x) #x
#define STR(x) STRING(x)
#define GOSSIP_HELLO             "Vote bonuses system"
#define GOSSIP_RACE              "Change race (" STR(COST_RACE) ")"
#define GOSSIP_FACTION           "Change faction (" STR(COST_GENDER) ")"
#define GOSSIP_RENAME            "Rename (" STR(COST_RENAME) ")"
#define GOSSIP_NOMONEY           "You need more votes"
#define GOSSIP_SUCCESS           "Will be changed on nex login"
#define GOSSIP_SUCC_BUY          "Success"
#define GOSSIP_SHOP              "Bonus shop"
#define GOSSIP_GOLD              "1000 gold (" STR(COST_GENDER) ")"

struct item {
    std::string name;
    uint32 cost;
    uint32 id;
    uint32 lvl;
};

enum category {
    CURRENCY = 0,
    EQUIP = 1,
    MAUNT = 2,
    PET = 3,
    STONE = 4,
    EXCLUSIVE = 5,
    CAT_COUNT = 6
};
std::vector<item> & itemDB(category cat) {
    static bool loaded = false;
    static std::vector<item> categories[CAT_COUNT];

    if (!loaded)
    {
        loaded = true;
        QueryResult result = CharacterDatabase.PQuery("SELECT name, cost, id, lvl, cat FROM shop");
        if(result)
        {
            while (result->NextRow())
            {
                Field *fields = result->Fetch();
                item i;
                i.name = fields[0].GetString();
                i.cost = fields[1].GetUInt32();
                i.id = fields[2].GetUInt32();
                i.lvl = fields[3].GetUInt32();
                std::string cat = fields[4].GetString();
                if (cat == "gem")
                {
                    categories[STONE].push_back(i);
                }
                else if (cat == "exclusive")
                {
                    categories[EXCLUSIVE].push_back(i);
                }
                else if (cat == "mau")
                {
                    categories[MAUNT].push_back(i);
                }
                else if (cat == "pet")
                {
                    categories[PET].push_back(i);
                }
                else if (cat == "cash")
                {
                    categories[CURRENCY].push_back(i);
                }
                else if (cat == "ode")
                {
                    categories[EQUIP].push_back(i);
                }
            }
        }
    }
    return categories[cat];
}

enum {
    ACTION_RACE = 1,
    ACTION_GENDER = 2,
    ACTION_RENAME = 3,
    ACTION_GOLD =   4,
    ACTION_SHOP = 8,
    ACTION_BUY = 16,
};

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
};

class npc_bonuses : public CreatureScript
{
public:
    npc_bonuses() : CreatureScript("npc_bonuses") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, GOSSIP_RACE,
                            GOSSIP_SENDER_MAIN, ACTION_RACE);
        /*pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, GOSSIP_FACTION,
                            GOSSIP_SENDER_MAIN, ACTION_FACTION);*/
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, GOSSIP_RENAME,
                            GOSSIP_SENDER_MAIN, ACTION_RENAME);
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, GOSSIP_GOLD,
                                    GOSSIP_SENDER_MAIN, ACTION_GOLD);
        pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, GOSSIP_SHOP,
                                    GOSSIP_SENDER_MAIN, ACTION_SHOP);
        pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
    {
        if (uiSender != GOSSIP_SENDER_MAIN)
            return false;

        pPlayer->PlayerTalkClass->ClearMenus();

        int BONUS_TOKEN = 37711;
        Item * i = pPlayer->GetItemByEntry(BONUS_TOKEN);
        if (i == 0)
            return false;

        switch (uiAction)
        {
        case ACTION_RACE:
            if (i->GetCount() >= COST_RACE)
                i->SetCount(i->GetCount() - COST_RACE);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCCESS, pPlayer->GetGUID());
            pPlayer->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
            return true;
        /*case ACTION_FACTION:
            if (i->GetCount() >= COST_FACTION)
                i->SetCount(i->GetCount() - COST_FACTION);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCCESS, pPlayer->GetGUID());
            pPlayer->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
            return true;*/
        case ACTION_RENAME:
            if (i->GetCount() >= COST_RENAME)
                i->SetCount(i->GetCount() - COST_RENAME);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCCESS, pPlayer->GetGUID());
            pPlayer->SetAtLoginFlag(AT_LOGIN_RENAME);
            return true;
        case ACTION_GOLD:
            if (i->GetCount() >= COST_GOLD)
                i->SetCount(i->GetCount() - COST_GOLD);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCC_BUY, pPlayer->GetGUID());
            pPlayer->SetMoney(pPlayer->GetMoney() + 1000 * 100 * 100);
            return true;
        }

        if ((uiAction & ACTION_SHOP) == ACTION_SHOP)
        {
            uint32 cat = uiAction & 7;

            if (cat == 0)
            {
                /*CURRENCY = 0,
                    EQUIP = 1,
                    MAUNT = 2,
                    PET = 3,
                    STONE = 4,
                    EXCLUSIVE = 5,
                    CAT_COUNT = 6*/
                char catname[6][20] = {"Cash", "Equip", "Maunt", "Pet", "Gem", "Exclusive"};
                for (int i = 1; i <= CAT_COUNT; ++i)
                {
                    pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, catname[i - 1],
                                            GOSSIP_SENDER_MAIN, ACTION_SHOP | i);
                }
                pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
                return true;
            }
            else
            {
                --cat;
                std::vector<item> & cati = itemDB((category)cat);
                for (int i = 0; i < cati.size(); ++i)
                {
                    if (cati[i].lvl > pPlayer->getLevel())
                        continue;
                    char buf[1024];
                    sprintf(buf, "%s [%d]", cati[i].name.c_str(), cati[i].cost);
                    pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, buf ,
                                GOSSIP_SENDER_MAIN, ACTION_BUY | cat | (i << 5));
                }
                pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
                return true;
            }

        }
        if ((uiAction & ACTION_BUY) == ACTION_BUY)
        {
            uint32 cat = uiAction & 7;
            uint32 id = uiAction >> 5;
            item it = itemDB((category)cat)[id];

            if (i->GetCount() >= it.cost)
                i->SetCount(i->GetCount() - it.cost);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                return false;
            }

            pCreature->MonsterWhisper(GOSSIP_SUCC_BUY, pPlayer->GetGUID());
            pPlayer->AddItem(it.id, 1);

        }

        return false;
    }
    /*
    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_bonusesAI (pCreature);
    }*/
    /*
    struct npc_bonusesAI : public ScriptedAI
    {
        npc_bonusesAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        void UpdateAI(const uint32 diff)
        {

        }
    };
    */
};


void AddSC_npc_bonuses()
{
    new npc_bonuses;
}
