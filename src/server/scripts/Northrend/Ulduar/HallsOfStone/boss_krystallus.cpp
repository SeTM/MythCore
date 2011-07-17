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
#include "halls_of_stone.h"

enum Spells
{
    SPELL_BOULDER_TOSS          = 50843,
    H_SPELL_BOULDER_TOSS        = 59742,
    SPELL_GROUND_SPIKE          = 59750,
    SPELL_GROUND_SLAM           = 50827,
    SPELL_GROUND_SLAM_TRIGGERED = 50833,
    SPELL_SHATTER               = 50810,
    H_SPELL_SHATTER             = 61546,
    SPELL_SHATTER_EFFECT        = 50811,
    H_SPELL_SHATTER_EFFECT      = 61547,
    SPELL_STONED                = 50812,
    SPELL_STOMP                 = 48131,
    H_SPELL_STOMP               = 59744
};

enum Yells
{
    SAY_AGGRO   = -1599007,
    SAY_KILL    = -1599008,
    SAY_DEATH   = -1599009,
    SAY_SHATTER = -1599010
};

class boss_krystallus : public CreatureScript
{
public:
    boss_krystallus() : CreatureScript("boss_krystallus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_krystallusAI (pCreature);
    }

    struct boss_krystallusAI : public ScriptedAI
    {
        boss_krystallusAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            SpellEntry *TempSpell;
            TempSpell = GET_SPELL(SPELL_GROUND_SLAM_TRIGGERED);
            if (TempSpell)
                TempSpell->InterruptFlags = 0;
        }

        uint32 uiBoulderTossTimer;
        uint32 uiGroundSpikeTimer;
        uint32 uiGroundSlamTimer;
        uint32 uiStompTimer;
        bool bIsSlam;
        InstanceScript* pInstance;

        void Reset()
        {
            bIsSlam = false;

            uiBoulderTossTimer = 3000 + rand()%6000;
            uiGroundSpikeTimer = 6000 + rand()%5000;
            uiGroundSlamTimer = 20000 + rand()%3000;
            uiStompTimer = 15000 + rand()%5000;

            if (pInstance)
                pInstance->SetData(DATA_KRYSTALLUS_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
                pInstance->SetData(DATA_KRYSTALLUS_EVENT, IN_PROGRESS);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (bIsSlam)
            {
                if (uiGroundSlamTimer <= diff)
                {
                    uiGroundSlamTimer = 15000 + rand()%5000;
                    DoCast(me, DUNGEON_MODE(SPELL_SHATTER, H_SPELL_SHATTER));
                } else uiGroundSlamTimer -= diff;
            } else {
                if (IsHeroic())
                {
                    if (uiGroundSpikeTimer <= diff)
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            DoCast(pTarget, SPELL_GROUND_SPIKE);
                        uiGroundSpikeTimer = 7000 + rand()%5000;
                    } else uiGroundSpikeTimer -= diff;
                }

                if (uiBoulderTossTimer <= diff)
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(pTarget, SPELL_BOULDER_TOSS);
                    uiBoulderTossTimer = 9000 + rand()%6000;
                } else uiBoulderTossTimer -= diff;

                if (uiStompTimer <= diff)
                {
                    DoCast(me, SPELL_STOMP);
                    uiStompTimer = 12000 + rand()%6000;
                } else uiStompTimer -= diff;

                if (uiGroundSlamTimer <= diff)
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();

                    bIsSlam = true;
                    uiGroundSlamTimer = 10000;

                    DoCast(me, SPELL_GROUND_SLAM, true);
                } else uiGroundSlamTimer -= diff;

                DoMeleeAttackIfReady();
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
            {
                pInstance->SetData(DATA_KRYSTALLUS_EVENT, DONE);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_STONED);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GROUND_SLAM);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GROUND_SLAM_TRIGGERED);
            }
        }

        void KilledUnit(Unit* victim)
        {
            if (victim == me)
                return;
            DoScriptText(SAY_KILL, me);
        }

        void SpellHitTarget(Unit* pTarget, const SpellEntry* pSpell)
        {
            if (pSpell->Id == SPELL_SHATTER || pSpell->Id == H_SPELL_SHATTER)
            {
                pTarget->CastSpell(pTarget, DUNGEON_MODE(SPELL_SHATTER_EFFECT, H_SPELL_SHATTER_EFFECT), true);

                if (pTarget->HasAura(SPELL_STONED))
                    pTarget->RemoveAurasDueToSpell(SPELL_STONED);

                if (bIsSlam)
                {
                    bIsSlam = false;

                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != TARGETED_MOTION_TYPE)
                    {
                        if (me->getVictim())
                            me->GetMotionMaster()->MoveChase(me->getVictim());
                    }
                }
            }
        }
    };
};

void AddSC_boss_krystallus()
{
    new boss_krystallus();
}