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
#include "nexus.h"

enum Spells
{
    SPELL_SPARK             = 47751,
    H_SPELL_SPARK           = 57062,
    SPELL_RIFT_SHIELD       = 47748,
    SPELL_CHARGE_RIFT       = 47747,
    SPELL_CREATE_RIFT       = 47743,
    SPELL_ARCANE_ATTRACTION = 57063
};

enum Adds
{
    MOB_CRAZED_MANA_WRAITH  = 26746,
    MOB_CHAOTIC_RIFT        = 26918
};

enum Yells
{
    SAY_AGGRO               = -1576010,
    SAY_DEATH               = -1576011,
    SAY_RIFT                = -1576012,
    SAY_SHIELD              = -1576013
};

#define ACHIEV_CHAOS_THEORY 2037

const Position RiftLocation[6] =
{
    {652.64f, -273.70f, -8.75f, 0},
    {634.45f, -265.94f, -8.44f, 0},
    {620.73f, -281.17f, -9.02f, 0},
    {626.10f, -304.67f, -9.44f, 0},
    {639.87f, -314.11f, -9.49f, 0},
    {651.72f, -297.44f, -9.37f, 0}
};

class boss_anomalus : public CreatureScript
{
public:
    boss_anomalus() : CreatureScript("boss_anomalus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_anomalusAI (pCreature);
    }

    struct boss_anomalusAI : public ScriptedAI
    {
        boss_anomalusAI(Creature* c) : ScriptedAI(c),summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiSparkTimer;
        uint32 uiCreateRiftTimer;
        uint32 uiHealthAmountModifier;
        uint64 uiChaoticRiftGUID;
        SummonList summons;
        bool bDeadChaoticRift;

        void Reset()
        {
            summons.DespawnAll();
            uiHealthAmountModifier = 1;
            uiSparkTimer = 5*IN_MILLISECONDS;
            uiChaoticRiftGUID = 0;

            bDeadChaoticRift = false;

            if (pInstance)
                pInstance->SetData(DATA_ANOMALUS_EVENT, NOT_STARTED);
        }

    void EnterEvadeMode()
    {
        summons.DespawnAll();
        _EnterEvadeMode();
        me->GetMotionMaster()->MoveTargetedHome();
        Reset();
    }

    void SummonedCreatureDespawn(Creature* summon)
    {
        summons.Despawn(summon);
    }

    void JustSummoned(Creature* summon)
    {
        summons.Summon(summon);
    }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
                pInstance->SetData(DATA_ANOMALUS_EVENT, IN_PROGRESS);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);
            summons.DespawnAll();

            if (pInstance)
            {
                if (IsHeroic() && !bDeadChaoticRift)
                    pInstance->DoCompleteAchievement(ACHIEV_CHAOS_THEORY);
                pInstance->SetData(DATA_ANOMALUS_EVENT, DONE);
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (me->GetDistance(me->GetHomePosition()) > 60.0f)
            {
                EnterEvadeMode();
                return;
            }

            if (me->HasAura(SPELL_RIFT_SHIELD))
            {
                if (uiChaoticRiftGUID)
                {
                    Unit* Rift = Unit::GetUnit((*me), uiChaoticRiftGUID);
                    if (Rift && Rift->isDead())
                    {
                        me->RemoveAurasDueToSpell(SPELL_RIFT_SHIELD);
                        uiChaoticRiftGUID = 0;
                    }
                    return;
                }
            } else uiChaoticRiftGUID = 0;

            if (me->HealthBelowPct(100 - 25 * uiHealthAmountModifier))
            {
                ++uiHealthAmountModifier;
                DoScriptText(SAY_SHIELD, me);
                DoCast(me, SPELL_RIFT_SHIELD);
                Creature* Rift = me->SummonCreature(MOB_CHAOTIC_RIFT, RiftLocation[urand(0,5)], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1*IN_MILLISECONDS);
                if (Rift)
                {
                    me->AddAura(SPELL_CHARGE_RIFT,Rift);
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        Rift->AI()->AttackStart(pTarget);
                    uiChaoticRiftGUID = Rift->GetGUID();
                    DoScriptText(SAY_RIFT , me);
                }
            }

            if (uiSparkTimer <= diff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, DUNGEON_MODE(SPELL_SPARK,H_SPELL_SPARK));
                uiSparkTimer = 5*IN_MILLISECONDS;
            } else uiSparkTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

enum RiftSpells
{
    SPELL_CHAOTIC_ENERGY_BURST         = 47688,
    SPELL_CHARGED_CHAOTIC_ENERGY_BURST = 47737,
    SPELL_ARCANEFORM                   = 48019
};

class mob_chaotic_rift : public CreatureScript
{
public:
    mob_chaotic_rift() : CreatureScript("mob_chaotic_rift") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_chaotic_riftAI (pCreature);
    }

    struct mob_chaotic_riftAI : public Scripted_NoMovementAI
    {
        mob_chaotic_riftAI(Creature* c) : Scripted_NoMovementAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 uiChaoticEnergyBurstTimer;
        uint32 uiSummonCrazedManaWraithTimer;

        void Reset()
        {
            uiChaoticEnergyBurstTimer = 1*IN_MILLISECONDS;
            uiSummonCrazedManaWraithTimer = 5*IN_MILLISECONDS;
            DoCast(me, SPELL_ARCANEFORM, false);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Creature* pAnomalus = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_ANOMALUS) : 0))
                if (pInstance && pInstance->GetData(DATA_ANOMALUS_EVENT) == IN_PROGRESS)
                    CAST_AI(boss_anomalus::boss_anomalusAI,pAnomalus->AI())->bDeadChaoticRift = true;
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (uiChaoticEnergyBurstTimer <= diff)
            {
                Unit* pAnomalus = Unit::GetUnit(*me, pInstance ? pInstance->GetData64(DATA_ANOMALUS) : 0);
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    int dmg=244+rand()%162;
                    if (pAnomalus && pAnomalus->HasAura(SPELL_RIFT_SHIELD))
                        dmg*= 2;
                    me->CastCustomSpell(pTarget,SPELL_CHAOTIC_ENERGY_BURST,&dmg,0,0,false);
                }
                uiChaoticEnergyBurstTimer = 1*IN_MILLISECONDS;
            } else uiChaoticEnergyBurstTimer -= diff;

            if (uiSummonCrazedManaWraithTimer <= diff)
            {
                Creature* Wraith = me->SummonCreature(MOB_CRAZED_MANA_WRAITH, me->GetPositionX()+1, me->GetPositionY()+1, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1*IN_MILLISECONDS);
                if (Wraith)
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        Wraith->AI()->AttackStart(pTarget);
                Unit* Anomalus = Unit::GetUnit(*me, pInstance ? pInstance->GetData64(DATA_ANOMALUS) : 0);
                if (Anomalus && Anomalus->HasAura(SPELL_RIFT_SHIELD))
                    uiSummonCrazedManaWraithTimer = 5*IN_MILLISECONDS;
                else
                    uiSummonCrazedManaWraithTimer = 10*IN_MILLISECONDS;
            } else uiSummonCrazedManaWraithTimer -= diff;
        }
    };
};

void AddSC_boss_anomalus()
{
    new boss_anomalus();
    new mob_chaotic_rift();
}