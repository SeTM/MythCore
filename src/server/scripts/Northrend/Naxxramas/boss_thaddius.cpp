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

enum StalaggYells
{
    SAY_STAL_AGGRO          = -1533023,
    SAY_STAL_SLAY           = -1533024,
    SAY_STAL_DEATH          = -1533025
};

enum StalagSpells
{
    SPELL_POWERSURGE        = 28134,
    H_SPELL_POWERSURGE      = 54529,
    SPELL_MAGNETIC_PULL     = 28338,
    SPELL_STALAGG_TESLA     = 28097
};

enum FeugenYells
{
    SAY_FEUG_AGGRO          = -1533026,
    SAY_FEUG_SLAY           = -1533027,
    SAY_FEUG_DEATH          = -1533028
};

enum FeugenSpells
{
    SPELL_STATICFIELD       = 28135,
    H_SPELL_STATICFIELD     = 54528,
    SPELL_FEUGEN_TESLA      = 28109
};

enum ThaddiusActions
{
    ACTION_FEUGEN_RESET,
    ACTION_FEUGEN_DIED,
    ACTION_STALAGG_RESET,
    ACTION_STALAGG_DIED
};

#define C_TESLA_COIL            16218

enum ThaddiusYells
{
    SAY_AGGRO_1             = -1533030,
    SAY_AGGRO_2             = -1533031,
    SAY_AGGRO_3             = -1533032,
    SAY_SLAY                = -1533033,
    SAY_DEATH               = -1533035
};

enum ThaddiusSpells
{
    SPELL_POLARITY_SHIFT        = 28089,
    SPELL_BALL_LIGHTNING        = 28299,
    SPELL_CHAIN_LIGHTNING       = 28167,
    H_SPELL_CHAIN_LIGHTNING     = 54531,
    SPELL_BERSERK               = 27680
};

enum Events
{
    EVENT_NONE,
    EVENT_SHIFT,
    EVENT_CHAIN,
    EVENT_BERSERK
};

class boss_thaddius : public CreatureScript
{
public:
    boss_thaddius() : CreatureScript("boss_thaddius") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_thaddiusAI (pCreature);
    }

    struct boss_thaddiusAI : public BossAI
    {
        boss_thaddiusAI(Creature* c) : BossAI(c, BOSS_THADDIUS)
        {
            checkFeugenAlive = false;
            if (Creature* pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN)))
                checkFeugenAlive = pFeugen->isAlive();

            checkStalaggAlive = false;
            if (Creature* pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG)))
                checkStalaggAlive = pStalagg->isAlive();

            if (!checkFeugenAlive && !checkStalaggAlive)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                me->SetReactState(REACT_AGGRESSIVE);
            } else {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                me->SetReactState(REACT_PASSIVE);
            }
        }

        bool checkStalaggAlive;
        bool checkFeugenAlive;
        uint32 uiAddsTimer;

        void Reset()
        {
            _Reset();

            if (Creature* pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN)))
            {
                pFeugen->Respawn(true);
                checkFeugenAlive = pFeugen->isAlive();
            }

            if (Creature* pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG)))
            {
                pStalagg->Respawn(true);
                checkStalaggAlive = pStalagg->isAlive();
            }

            if (!checkFeugenAlive && !checkStalaggAlive)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                me->SetReactState(REACT_AGGRESSIVE);
            } else {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                me->SetReactState(REACT_PASSIVE);
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            if (!(rand()%5))
                DoScriptText(SAY_SLAY, me);
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
            DoScriptText(SAY_DEATH, me);
        }

        void DoAction(int32 const action)
        {
            switch (action)
            {
                case ACTION_FEUGEN_RESET:
                    checkFeugenAlive = true;
                    break;
                case ACTION_FEUGEN_DIED:
                    checkFeugenAlive = false;
                    break;
                case ACTION_STALAGG_RESET:
                    checkStalaggAlive = true;
                    break;
                case ACTION_STALAGG_DIED:
                    checkStalaggAlive = false;
                    break;
            }

            if (!checkFeugenAlive && !checkStalaggAlive)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                DoZoneInCombat();
            } else {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                me->SetReactState(REACT_PASSIVE);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            DoScriptText(RAND(SAY_AGGRO_1,SAY_AGGRO_2,SAY_AGGRO_3), me);
            events.ScheduleEvent(EVENT_SHIFT, 30000);
            events.ScheduleEvent(EVENT_CHAIN, urand(10000,20000));
            events.ScheduleEvent(EVENT_BERSERK, 360000);
        }

        void DamageTaken(Unit* /*pDoneBy*/, uint32 & /*uiDamage*/)
        {
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void UpdateAI(uint32 const diff)
        {
            if (checkFeugenAlive && checkStalaggAlive)
                uiAddsTimer = 0;

            if (checkStalaggAlive != checkFeugenAlive)
            {
                uiAddsTimer += diff;
                if (uiAddsTimer > 5000)
                {
                    if (!checkStalaggAlive)
                    {
                        if (instance)
                            if (Creature* pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG)))
                                pStalagg->Respawn();
                    } else {
                        if (instance)
                            if (Creature* pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN)))
                                pFeugen->Respawn();
                    }
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SHIFT:
                        DoCastAOE(SPELL_POLARITY_SHIFT);
                        events.ScheduleEvent(EVENT_SHIFT, 30000);
                        return;
                    case EVENT_CHAIN:
                        DoCast(me->getVictim(), RAID_MODE(SPELL_CHAIN_LIGHTNING, H_SPELL_CHAIN_LIGHTNING));
                        events.ScheduleEvent(EVENT_CHAIN, urand(10000,20000));
                        return;
                    case EVENT_BERSERK:
                        me->InterruptNonMeleeSpells(false);
                        DoCast(me, SPELL_BERSERK);
                        return;
                }
            }

            if (events.GetTimer() > 15000 && !me->IsWithinMeleeRange(me->getVictim()))
                DoCast(me->getVictim(), SPELL_BALL_LIGHTNING);
            else
                DoMeleeAttackIfReady();
        }
    };
};

class mob_stalagg : public CreatureScript
{
public:
    mob_stalagg() : CreatureScript("mob_stalagg") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_stalaggAI(pCreature);
    }

    struct mob_stalaggAI : public ScriptedAI
    {
        mob_stalaggAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 powerSurgeTimer;
        uint32 magneticPullTimer;

        void Reset()
        {
            if (pInstance)
                if (Creature* pThaddius = me->GetCreature(*me, pInstance->GetData64(DATA_THADDIUS)))
                    if (pThaddius->AI())
                        pThaddius->AI()->DoAction(ACTION_STALAGG_RESET);
            powerSurgeTimer = urand(20000,25000);
            magneticPullTimer = 20000;
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoCast(SPELL_STALAGG_TESLA);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                if (Creature* pThaddius = me->GetCreature(*me, pInstance->GetData64(DATA_THADDIUS)))
                    if (pThaddius->AI())
                        pThaddius->AI()->DoAction(ACTION_STALAGG_DIED);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (magneticPullTimer <= diff)
            {
                if (Creature* pFeugen = me->GetCreature(*me, pInstance->GetData64(DATA_FEUGEN)))
                {
                    Unit* pStalaggVictim = me->getVictim();
                    Unit* pFeugenVictim = pFeugen->getVictim();

                    if (pFeugenVictim && pStalaggVictim)
                    {
                        pFeugen->getThreatManager().addThreat(pStalaggVictim, pFeugen->getThreatManager().getThreat(pFeugenVictim));
                        me->getThreatManager().addThreat(pFeugenVictim, me->getThreatManager().getThreat(pStalaggVictim));
                        pFeugen->getThreatManager().modifyThreatPercent(pFeugenVictim, -100);
                        me->getThreatManager().modifyThreatPercent(pStalaggVictim, -100);

                        pFeugenVictim->JumpTo(me, 0.3f);
                        pStalaggVictim->JumpTo(pFeugen, 0.3f);
                    }
                }

                magneticPullTimer = 20000;
            } else magneticPullTimer -= diff;

            if (powerSurgeTimer <= diff)
            {
                DoCast(me, RAID_MODE(SPELL_POWERSURGE, H_SPELL_POWERSURGE));
                powerSurgeTimer = urand(15000,20000);
            } else powerSurgeTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_feugen : public CreatureScript
{
public:
    mob_feugen() : CreatureScript("mob_feugen") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_feugenAI(pCreature);
    }

    struct mob_feugenAI : public ScriptedAI
    {
        mob_feugenAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 staticFieldTimer;

        void Reset()
        {
            if (pInstance)
                if (Creature* pThaddius = me->GetCreature(*me, pInstance->GetData64(DATA_THADDIUS)))
                    if (pThaddius->AI())
                        pThaddius->AI()->DoAction(ACTION_FEUGEN_RESET);
            staticFieldTimer = 5000;
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoCast(SPELL_FEUGEN_TESLA);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                if (Creature* pThaddius = me->GetCreature(*me, pInstance->GetData64(DATA_THADDIUS)))
                    if (pThaddius->AI())
                        pThaddius->AI()->DoAction(ACTION_FEUGEN_DIED);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (staticFieldTimer <= diff)
            {
                DoCast(me, RAID_MODE(SPELL_STATICFIELD, H_SPELL_STATICFIELD));
                staticFieldTimer = 5000;
            } else staticFieldTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_thaddius()
{
    new boss_thaddius();
    new mob_stalagg();
    new mob_feugen();
}