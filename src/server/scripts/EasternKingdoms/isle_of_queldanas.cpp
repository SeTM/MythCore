/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
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

#define SAY_CONVERTED_1         -1000188
#define SAY_CONVERTED_2         -1000189

#define SPELL_CONVERT_CREDIT    45009

class npc_converted_sentry : public CreatureScript
{
public:
    npc_converted_sentry() : CreatureScript("npc_converted_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_converted_sentryAI (pCreature);
    }

    struct npc_converted_sentryAI : public ScriptedAI
    {
        npc_converted_sentryAI(Creature *c) : ScriptedAI(c) {}

        bool Credit;
        uint32 Timer;

        void Reset()
        {
            Credit = false;
            Timer = 2500;
        }

        void MoveInLineOfSight(Unit* /*who*/) {}
        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(uint32 const diff)
        {
            if (!Credit)
            {
                if (Timer <= diff)
                {
                    uint32 i = urand(1, 2);
                    if (i == 1)
                        DoScriptText(SAY_CONVERTED_1, me);
                    else
                        DoScriptText(SAY_CONVERTED_2, me);

                    DoCast(me, SPELL_CONVERT_CREDIT);
                    if (me->isPet())
                        me->ToPet()->SetDuration(7500);
                    Credit = true;
                } else Timer -= diff;
            }
        }
    };
};

#define ENRAGE  45111
#define ORB     45109
#define QUESTG  11541
#define DM      25060

class npc_greengill_slave : public CreatureScript
{
public:
    npc_greengill_slave() : CreatureScript("npc_greengill_slave") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_greengill_slaveAI(pCreature);
    }

    struct npc_greengill_slaveAI : public ScriptedAI
    {
        npc_greengill_slaveAI(Creature* c) : ScriptedAI(c) {}

        uint64 PlayerGUID;

        void EnterCombat(Unit* /*who*/){}

        void Reset()
        {
            PlayerGUID = 0;
        }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            if (!caster)
                return;

            if (caster->GetTypeId() == TYPEID_PLAYER && spell->Id == ORB && !me->HasAura(ENRAGE))
            {
                PlayerGUID = caster->GetGUID();
                if (PlayerGUID)
                {
                    Unit* plr = Unit::GetUnit((*me), PlayerGUID);
                    if (plr && CAST_PLR(plr)->GetQuestStatus(QUESTG) == QUEST_STATUS_INCOMPLETE)
                        DoCast(plr, 45110, true);
                }
                DoCast(me, ENRAGE);
                Unit* Myrmidon = me->FindNearestCreature(DM, 70);
                if (Myrmidon)
                {
                    me->AddThreat(Myrmidon, 100000.0f);
                    AttackStart(Myrmidon);
                }
            }
        }

        void UpdateAI(const uint32 /*diff*/)
        {
            DoMeleeAttackIfReady();
        }
    };

};

enum eThalorien {
    QUEST_HORDE    = 24563,
    QUEST_ALLIANCE = 24535
};

class npc_thalorien_dawnseeker_remains : public CreatureScript
{
public:
    npc_thalorien_dawnseeker_remains() : CreatureScript("npc_thaloriendre") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if( pPlayer->GetTeam( ) == HORDE ) {
            if( pPlayer->GetQuestStatus( QUEST_HORDE ) != QUEST_STATUS_NONE && pPlayer->GetQuestStatus( QUEST_HORDE ) != QUEST_STATUS_COMPLETE ) {
                Quest const* pQuest = sObjectMgr->GetQuestTemplate(QUEST_HORDE);
                // Add quest items for quests that require items
                for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
                {
                    uint32 id = pQuest->ReqItemId[x];
                    uint32 count = pQuest->ReqItemCount[x];
                    if (!id || !count)
                        continue;

                    uint32 curItemCount = pPlayer->GetItemCount(id,true);

                    ItemPosCountVec dest;
                    uint8 msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count-curItemCount);
                    if (msg == EQUIP_ERR_OK)
                    {
                        Item* item = pPlayer->StoreNewItem(dest, id, true);
                        pPlayer->SendNewItem(item,count-curItemCount,true,false);
                    }
                }

                // All creature/GO slain/casted (not required, but otherwise it will display "Creature slain 0/10")
                for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                {
                    int32 creature = pQuest->ReqCreatureOrGOId[i];
                    uint32 creaturecount = pQuest->ReqCreatureOrGOCount[i];

                    if (uint32 spell_id = pQuest->ReqSpell[i])
                    {
                        for (uint16 z = 0; z < creaturecount; ++z)
                            pPlayer->CastedCreatureOrGO(creature,0,spell_id);
                    }
                    else if (creature > 0)
                    {
                        if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(creature))
                            for (uint16 z = 0; z < creaturecount; ++z)
                                pPlayer->KilledMonster(cInfo,0);
                    }
                    else if (creature < 0)
                    {
                        for (uint16 z = 0; z < creaturecount; ++z)
                            pPlayer->CastedCreatureOrGO(creature,0,0);
                    }
                }
            }
        }

         if( pPlayer->GetTeam( ) == ALLIANCE ) {
            if( pPlayer->GetQuestStatus( QUEST_ALLIANCE ) != QUEST_STATUS_NONE && pPlayer->GetQuestStatus( QUEST_ALLIANCE ) != QUEST_STATUS_COMPLETE ) {
                Quest const* pQuest = sObjectMgr->GetQuestTemplate(QUEST_ALLIANCE);
                // Add quest items for quests that require items
                for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
                {
                    uint32 id = pQuest->ReqItemId[x];
                    uint32 count = pQuest->ReqItemCount[x];
                    if (!id || !count)
                        continue;

                    uint32 curItemCount = pPlayer->GetItemCount(id,true);

                    ItemPosCountVec dest;
                    uint8 msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count-curItemCount);
                    if (msg == EQUIP_ERR_OK)
                    {
                        Item* item = pPlayer->StoreNewItem(dest, id, true);
                        pPlayer->SendNewItem(item,count-curItemCount,true,false);
                    }
                }

                // All creature/GO slain/casted (not required, but otherwise it will display "Creature slain 0/10")
                for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                {
                    int32 creature = pQuest->ReqCreatureOrGOId[i];
                    uint32 creaturecount = pQuest->ReqCreatureOrGOCount[i];

                    if (uint32 spell_id = pQuest->ReqSpell[i])
                    {
                        for (uint16 z = 0; z < creaturecount; ++z)
                            pPlayer->CastedCreatureOrGO(creature,0,spell_id);
                    }
                    else if (creature > 0)
                    {
                        if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(creature))
                            for (uint16 z = 0; z < creaturecount; ++z)
                                pPlayer->KilledMonster(cInfo,0);
                    }
                    else if (creature < 0)
                    {
                        for (uint16 z = 0; z < creaturecount; ++z)
                            pPlayer->CastedCreatureOrGO(creature,0,0);
                    }
                }
            }
        }

        return false;
    }
};

void AddSC_isle_of_queldanas()
{
    new npc_converted_sentry();
    new npc_greengill_slave();
    new npc_thalorien_dawnseeker_remains();
}
