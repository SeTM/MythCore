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
#include "naxxramas.h"

#define SPELL_BOMBARD_SLIME         28280

#define SPELL_POISON_CLOUD          28240
#define SPELL_MUTATING_INJECTION    28169
#define SPELL_SLIME_SPRAY           RAID_MODE(28157,54364)
#define SPELL_BERSERK               26662
#define SPELL_POISON_CLOUD_ADD      28158
#define SPELL_SLIME_STREAM          28137

#define EVENT_BERSERK   1
#define EVENT_CLOUD     2
#define EVENT_INJECT    3
#define EVENT_SPRAY     4

#define MOB_FALLOUT_SLIME   16290

class boss_grobbulus : public CreatureScript
{
public:
    boss_grobbulus() : CreatureScript("boss_grobbulus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_grobbulusAI (pCreature);
    }

    struct boss_grobbulusAI : public BossAI
    {
        boss_grobbulusAI(Creature* c) : BossAI(c, BOSS_GROBBULUS)
        {
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_POISON_CLOUD_ADD, true);
        }

        uint32 uiSlimeStreamTimer;

        void Reset()
        {
            _Reset();
            uiSlimeStreamTimer = 3*IN_MILLISECONDS;
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_CLOUD, 15000);
            events.ScheduleEvent(EVENT_INJECT, 20000);
            events.ScheduleEvent(EVENT_SPRAY, 15000+rand()%15000);
            events.ScheduleEvent(EVENT_BERSERK, RAID_MODE(12*60000,9*60000));
        }

        void EnterEvadeMode()
        {
            _EnterEvadeMode();
            Reset();
        }

        void SpellHitTarget(Unit* pTarget, const SpellEntry *spell)
        {
            if (spell->Id == uint32(SPELL_SLIME_SPRAY))
                if (TempSummon *slime = me->SummonCreature(MOB_FALLOUT_SLIME, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 0))
                    DoZoneInCombat(slime);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (!me->IsWithinMeleeRange(me->getVictim()))
            {
                if (uiSlimeStreamTimer <= diff)
                {
                    DoCast(SPELL_SLIME_STREAM);
                    uiSlimeStreamTimer = 3*IN_MILLISECONDS;
                } else uiSlimeStreamTimer -= diff;
            } else uiSlimeStreamTimer = 3*IN_MILLISECONDS;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CLOUD:
                        DoCastAOE(SPELL_POISON_CLOUD);
                        events.ScheduleEvent(EVENT_CLOUD, 15000);
                        return;
                    case EVENT_BERSERK:
                        DoCastAOE(SPELL_BERSERK);
                        return;
                    case EVENT_SPRAY:
                        DoCastAOE(SPELL_SLIME_SPRAY);
                        events.ScheduleEvent(EVENT_SPRAY, 15000+rand()%15000);
                        return;
                    case EVENT_INJECT:
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 200, true))
                            if (!pTarget->HasAura(SPELL_MUTATING_INJECTION))
                            {
                                 DoCast(pTarget, SPELL_MUTATING_INJECTION);
                                 events.ScheduleEvent(EVENT_INJECT, 8000 + uint32(120 * me->GetHealthPct()));
                            }
                        return;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_grobbulus_poison_cloud : public CreatureScript
{
public:
    npc_grobbulus_poison_cloud() : CreatureScript("npc_grobbulus_poison_cloud") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_grobbulus_poison_cloudAI(pCreature);
    }

    struct npc_grobbulus_poison_cloudAI : public Scripted_NoMovementAI
    {
        npc_grobbulus_poison_cloudAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            Reset();
        }

        uint32 Cloud_Timer;
        bool cloud_casted;

        void Reset()
        {
            Cloud_Timer = 1000;
            cloud_casted = false;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->setFaction(14);
        }

        void UpdateAI(uint32 const diff)
        {
            if (Cloud_Timer <= diff)
            {
                if(!me->HasAura(SPELL_POISON_CLOUD_ADD))
                {
                    if(!cloud_casted)
                    {
                        DoCast(me, SPELL_POISON_CLOUD_ADD);
                        cloud_casted = true;
                    } else me->DealDamage(me,me->GetHealth());
                }
                Cloud_Timer = 10000;
            } else Cloud_Timer -= diff;
        }
    };
};

void AddSC_boss_grobbulus()
{
    new boss_grobbulus();
    new npc_grobbulus_poison_cloud();
}