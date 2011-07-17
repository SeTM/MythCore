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
#include "halls_of_lightning.h"

enum Spells
{
    SPELL_BALL_LIGHTNING         = 52780,
    H_SPELL_BALL_LIGHTNING       = 59800,
    SPELL_STATIC_OVERLOAD        = 52658,
    H_SPELL_STATIC_OVERLOAD      = 59795,
    SPELL_DISPERSE               = 52770,
    SPELL_SUMMON_SPARK           = 52746,
    SPELL_SPARK_DESPAWN          = 52776,
    SPELL_ARCING_BURN            = 52671,
    H_SPELL_ARCING_BURN          = 59834,
    SPELL_SPARK_VISUAL_TRIGGER   = 52667,
    H_SPELL_SPARK_VISUAL_TRIGGER = 59833,
    SPELL_ARC_WELD               = 59086
};

enum Yells
{
    SAY_AGGRO   = -1602011,
    SAY_SLAY_1  = -1602012,
    SAY_SLAY_2  = -1602013,
    SAY_SLAY_3  = -1602014,
    SAY_DEATH   = -1602015,
    SAY_SPLIT_1 = -1602016,
    SAY_SPLIT_2 = -1602017
};

enum Creatures
{
    NPC_SPARK_OF_IONAR                            = 28926
};

enum Misc
{
    DATA_MAX_SPARKS         = 5,
    DATA_MAX_SPARK_DISTANCE = 90,
    DATA_POINT_CALLBACK     = 0
};

class boss_ionar : public CreatureScript
{
public:
    boss_ionar() : CreatureScript("boss_ionar") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_ionarAI(pCreature);
    }

    struct boss_ionarAI : public ScriptedAI
    {
        boss_ionarAI(Creature* pCreature) : ScriptedAI(pCreature), lSparkList(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList lSparkList;
        bool bIsSplitPhase;

        uint32 uiSplitTimer;
        uint32 uiStaticOverloadTimer;
        uint32 uiBallLightningTimer;
        uint32 uiHealthAmountModifier;

        void Reset()
        {
            lSparkList.DespawnAll();

            bIsSplitPhase = true;
            uiHealthAmountModifier = 1;
            uiSplitTimer = 15*IN_MILLISECONDS;

            uiStaticOverloadTimer = urand(5*IN_MILLISECONDS, 6*IN_MILLISECONDS);
            uiBallLightningTimer = urand(10*IN_MILLISECONDS, 11*IN_MILLISECONDS);

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_DISABLE_MOVE);
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);

            if (!me->IsVisible())
                me->SetVisible(true);

            if (pInstance)
                pInstance->SetData(TYPE_IONAR, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
                pInstance->SetData(TYPE_IONAR, IN_PROGRESS);
            DoCast(me, SPELL_DISPERSE, false);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            lSparkList.DespawnAll();

            if (pInstance)
                pInstance->SetData(TYPE_IONAR, DONE);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }

        void CallBackSparks()
        {
            if (lSparkList.empty())
                return;

            Position pos;
            me->GetPosition(&pos);

            for (std::list<uint64>::const_iterator itr = lSparkList.begin(); itr != lSparkList.end(); ++itr)
            {
                if (Creature* pSpark = Unit::GetCreature(*me, *itr))
                {
                    if (pSpark->isAlive())
                    {
                        pSpark->SetSpeed(MOVE_RUN, 2.0f);
                        pSpark->GetMotionMaster()->Clear();
                        pSpark->GetMotionMaster()->MovePoint(DATA_POINT_CALLBACK, pos);
                    } else pSpark->DespawnOrUnsummon();
                }
            }
        }

        void SpellHit(Unit* caster, const SpellEntry* spell)
        {
            if (spell->Id == SPELL_DISPERSE)
            {
                for (uint8 i = 0; i < DATA_MAX_SPARKS; ++i)
                    me->CastSpell(me, SPELL_SUMMON_SPARK, true);

                me->AttackStop();
                me->SetVisible(false);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_DISABLE_MOVE);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
            }
        }

        void DamageTaken(Unit* /*pDoneBy*/, uint32 &uiDamage)
        {
            if (!me->IsVisible())
                uiDamage = 0;
        }

        void JustSummoned(Creature* pSummoned)
        {
            if (pSummoned->GetEntry() == NPC_SPARK_OF_IONAR)
            {
                lSparkList.Summon(pSummoned);

                pSummoned->CastSpell(pSummoned, DUNGEON_MODE(SPELL_SPARK_VISUAL_TRIGGER,H_SPELL_SPARK_VISUAL_TRIGGER), true);
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                if (pTarget)
                {
                    pSummoned->SetInCombatWith(pTarget);
                    pSummoned->GetMotionMaster()->Clear();
                    pSummoned->GetMotionMaster()->MoveFollow(pTarget, 0.0f, 0.0f);
                }
            }
        }

        void SummonedCreatureDespawn(Creature* pSummoned)
        {
            if (pSummoned->GetEntry() == NPC_SPARK_OF_IONAR)
                lSparkList.Despawn(pSummoned);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (!me->IsVisible())
            {
                if (uiSplitTimer <= diff)
                {
                    uiSplitTimer = 7500;

                    if (bIsSplitPhase)
                    {
                        CallBackSparks();
                        bIsSplitPhase = false;
                    }
                    else if (lSparkList.empty())
                    {
                        me->SetVisible(true);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_DISABLE_MOVE);

                        DoCast(me, SPELL_SPARK_DESPAWN, false);

                        uiSplitTimer = 15*IN_MILLISECONDS;
                        bIsSplitPhase = true;

                        if (me->getVictim())
                            me->GetMotionMaster()->MoveChase(me->getVictim());
                    }
                } else uiSplitTimer -= diff;

                return;
            }

            if (uiStaticOverloadTimer <= diff)
            {
                if (!me->IsNonMeleeSpellCasted(false))
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        DoCast(pTarget, DUNGEON_MODE(SPELL_STATIC_OVERLOAD,H_SPELL_STATIC_OVERLOAD));

                uiStaticOverloadTimer = urand(5*IN_MILLISECONDS, 6*IN_MILLISECONDS);
                }
            } else uiStaticOverloadTimer -= diff;

            if (uiBallLightningTimer <= diff)
            {
                if (!me->IsNonMeleeSpellCasted(false))
                {
                    if (Unit* pTemp = SelectTarget(SELECT_TARGET_RANDOM,1,100,true))
                        DoCast(pTemp, DUNGEON_MODE(SPELL_BALL_LIGHTNING,H_SPELL_BALL_LIGHTNING));
                    else
                        DoCast(me->getVictim(), DUNGEON_MODE(SPELL_BALL_LIGHTNING,H_SPELL_BALL_LIGHTNING));

                uiBallLightningTimer = urand(10*IN_MILLISECONDS, 11*IN_MILLISECONDS);
                }
            } else uiBallLightningTimer -= diff;

            if (me->HealthBelowPct(100 - 20 * uiHealthAmountModifier))
            {
                ++uiHealthAmountModifier;

                DoScriptText(RAND(SAY_SPLIT_1,SAY_SPLIT_2), me);

                if (me->IsNonMeleeSpellCasted(false))
                    me->InterruptNonMeleeSpells(false);

                me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, false);
                DoCast(me, SPELL_DISPERSE, false);
            }

            DoMeleeAttackIfReady();
        }
    };
};

class mob_spark_of_ionar : public CreatureScript
{
public:
    mob_spark_of_ionar() : CreatureScript("mob_spark_of_ionar") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_spark_of_ionarAI(pCreature);
    }

    struct mob_spark_of_ionarAI : public ScriptedAI
    {
        mob_spark_of_ionarAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint32 uiCheckTimer;
        uint32 uiArcWeldTimer;

        void Reset()
        {
            uiArcWeldTimer = 0;
            me->SetSpeed(MOVE_RUN, 0.7f);
            uiCheckTimer = 2*IN_MILLISECONDS;
            DoCast(DUNGEON_MODE(SPELL_SPARK_VISUAL_TRIGGER,H_SPELL_SPARK_VISUAL_TRIGGER));
        }

        void MovementInform(uint32 uiType, uint32 uiPointId)
        {
            if (uiType != POINT_MOTION_TYPE || !pInstance)
                return;

            if (uiPointId == DATA_POINT_CALLBACK)
                me->DespawnOrUnsummon();
        }

        void DamageTaken(Unit* /*pDoneBy*/, uint32 &uiDamage)
        {
            uiDamage = 0;
        }

        void UpdateAI(uint32 const diff)
        {
            if (pInstance && pInstance->GetData(TYPE_IONAR) != IN_PROGRESS)
            {
                me->DespawnOrUnsummon();
                return;
            }

            if (uiArcWeldTimer <= diff)
            {
                DoCast(me, SPELL_ARC_WELD);
                uiArcWeldTimer = 500;
            } else uiArcWeldTimer -= diff;

            if (uiCheckTimer <= diff)
            {
                if (pInstance)
                {
                    Creature* pIonar = pInstance->instance->GetCreature(pInstance->GetData64(DATA_IONAR));
                    if (pIonar && pIonar->isAlive())
                    {
                        if (me->GetDistance(pIonar) > DATA_MAX_SPARK_DISTANCE)
                        {
                            Position pos;
                            pIonar->GetPosition(&pos);

                            me->SetSpeed(MOVE_RUN, 2.0f);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MovePoint(DATA_POINT_CALLBACK, pos);
                        }
                    } else me->DespawnOrUnsummon();
                }
                uiCheckTimer = 2*IN_MILLISECONDS;
            } else uiCheckTimer -= diff;
        }
    };
};

void AddSC_boss_ionar()
{
    new boss_ionar();
    new mob_spark_of_ionar();
}