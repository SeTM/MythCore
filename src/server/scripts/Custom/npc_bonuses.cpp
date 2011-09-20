#include "Config.h"

#define COST_RACE 5000
#define COST_RENAME 5000
#define COST_GOLD 30

#define STRING(x) #x
#define STR(x) STRING(x)
#define GOSSIP_HELLO             "Vote bonuses system"
#define GOSSIP_RACE              "Сменить расу (" STR(COST_RACE) " золота)"
#define GOSSIP_RENAME            "Переименовать персонажа (" STR(COST_RENAME) " золота)"
#define GOSSIP_NOMONEY           "Недостаточно средств"
#define GOSSIP_SUCCESS           "Изменения вступят в силу при следующем входе в игру"
#define GOSSIP_SUCC_BUY          "Операция прошла успешно"
#define GOSSIP_SHOP              "Обмен голосов"
#define GOSSIP_GOLD              "1000 золота (" STR(COST_GOLD) " голосов)"

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

        switch (uiAction)
        {
        case ACTION_RACE:
            if (pPlayer->GetMoney() >= COST_RACE * 100 * 100)
                pPlayer->SetMoney(pPlayer->GetMoney() - COST_RACE * 100 * 100);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                pPlayer->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCCESS, pPlayer->GetGUID());
            pPlayer->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
            pPlayer->PlayerTalkClass->SendCloseGossip();
            return true;
        case ACTION_RENAME:
            if (pPlayer->GetMoney() >= COST_RENAME * 100 * 100)
                pPlayer->SetMoney(pPlayer->GetMoney() - COST_RENAME * 100 * 100);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                pPlayer->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCCESS, pPlayer->GetGUID());
            pPlayer->SetAtLoginFlag(AT_LOGIN_RENAME);
            pPlayer->PlayerTalkClass->SendCloseGossip();
            return true;
        case ACTION_GOLD:
            if (i != 0 && i->GetCount() >= COST_GOLD)
                i->SetCount(i->GetCount() - COST_GOLD);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                pPlayer->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            pCreature->MonsterWhisper(GOSSIP_SUCC_BUY, pPlayer->GetGUID());
            pPlayer->SetMoney(pPlayer->GetMoney() + 1000 * 100 * 100);
            pPlayer->PlayerTalkClass->SendCloseGossip();
            return true;
        }

        if ((uiAction & ACTION_SHOP) == ACTION_SHOP)
        {
            uint32 cat = uiAction & 7;

            if (cat == 0)
            {
                char catname[6][20] = {"Валюта", "Одежда", "Маунты", "Спутники", "Камни", "Эксклюзив"};
                for (int i = 1; i <= CAT_COUNT; ++i)
                {
                    pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, catname[i - 1],
                                            GOSSIP_SENDER_MAIN, ACTION_SHOP | i);
                }

                pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, GOSSIP_GOLD,
                    GOSSIP_SENDER_MAIN, ACTION_GOLD);
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
                    sprintf(buf, "%s (%d голосов)", cati[i].name.c_str(), cati[i].cost);
                    pPlayer->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, buf ,
                                GOSSIP_SENDER_MAIN, ACTION_BUY | cat | (i << 5));
                }
                pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
                return true;
            }

        }
        if ((uiAction & ACTION_BUY) == ACTION_BUY)
        {
            if (i == 0)
            {
                pPlayer->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            uint32 cat = uiAction & 7;
            uint32 id = uiAction >> 5;
            item it = itemDB((category)cat)[id];

            if (i->GetCount() >= it.cost)
                i->SetCount(i->GetCount() - it.cost);
            else
            {
                pCreature->MonsterWhisper(GOSSIP_NOMONEY, pPlayer->GetGUID());
                pPlayer->PlayerTalkClass->SendCloseGossip();
                return false;
            }

            pCreature->MonsterWhisper(GOSSIP_SUCC_BUY, pPlayer->GetGUID());
            pPlayer->AddItem(it.id, 1);
            pPlayer->PlayerTalkClass->SendCloseGossip();
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
