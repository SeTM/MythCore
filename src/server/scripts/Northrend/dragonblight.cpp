/*
 * Copyright (C) 2008 - 2011 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 - 2011 Myth Project <http://bitbucket.org/sun/myth-core/>
 *
 * Myth Project's source is based on the Trinity Project source, you can find the
 * link to that easily in Trinity Copyrights. Myth Project is a private community.
 * To get access, you either have to donate or pass a developer test.
 * You can't share Myth Project's sources! Only for personal use.
 */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

enum eEnums
{
    QUEST_RETURN_TO_AG_A    = 12499,
    QUEST_RETURN_TO_AG_H    = 12500,
    MOVIE_ID_GATES          = 14
};

#define GOSSIP_ITEM_WHAT_HAPPENED   "Alexstrasza, can you show me what happened here?"

class npc_alexstrasza_wr_gate : public CreatureScript
{
public:
    npc_alexstrasza_wr_gate() : CreatureScript("npc_alexstrasza_wr_gate") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pCreature->isQuestGiver())
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        if (pPlayer->GetQuestRewardStatus(QUEST_RETURN_TO_AG_A) || pPlayer->GetQuestRewardStatus(QUEST_RETURN_TO_AG_H))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WHAT_HAPPENED, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            pPlayer->CLOSE_GOSSIP_MENU();
            pPlayer->SendMovieStart(MOVIE_ID_GATES);
        }

        return true;
    }
};

/*######
## Quest 12277: Leave Nothing to Chance
######*/

#define QUEST  12277
#define SPELL  48742

class npc_wintergarde_mine_bomb : public CreatureScript
{
public:
    npc_wintergarde_mine_bomb() : CreatureScript("npc_wintergarde_mine_bomb") { }

    struct npc_wintergarde_mine_bombAI : public ScriptedAI
    {
        npc_wintergarde_mine_bombAI(Creature *c) : ScriptedAI(c) {}

        uint32 uiExplosionTimer;
        void Reset()
        {
            uiExplosionTimer = urand(5000, 10000);
        }
        void UpdateAI(uint32 const diff)
        {
            if (uiExplosionTimer < diff)
            {
                DoCast(SPELL);
                for (uint8 i = 0; i < 4; ++i)
                {
                    if (Creature* cCredit = me->FindNearestCreature(27436 + i, 10.0f))
                    {
                        if (Unit* uOwner = me->GetOwner())
                        {
                            Player* pOwner = uOwner->ToPlayer();
                            if (pOwner && pOwner->GetQuestStatus(QUEST) == QUEST_STATUS_INCOMPLETE)
                                pOwner->KilledMonsterCredit(cCredit->GetEntry(), cCredit->GetGUID());
                        }
                    }
                }
                me->Kill(me);
                return;
            } 
            else uiExplosionTimer -= diff;
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_wintergarde_mine_bombAI(creature);
    }
};

void AddSC_dragonblight()
{
    new npc_alexstrasza_wr_gate;
    new npc_wintergarde_mine_bomb;
}
