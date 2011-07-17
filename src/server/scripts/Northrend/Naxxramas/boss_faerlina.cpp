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

enum Yells
{
    SAY_GREET       = -1533009,
    SAY_AGGRO_1     = -1533010,
    SAY_AGGRO_2     = -1533011,
    SAY_AGGRO_3     = -1533012,
    SAY_AGGRO_4     = -1533013,
    SAY_SLAY_1      = -1533014,
    SAY_SLAY_2      = -1533015,
    SAY_DEATH       = -1533016
};

enum Spells
{
    SPELL_POISON_BOLT_VOLLEY    = 28796,
    H_SPELL_POISON_BOLT_VOLLEY  = 54098,
    SPELL_RAIN_OF_FIRE          = 28794,
    H_SPELL_RAIN_OF_FIRE        = 54099,
    SPELL_FRENZY                = 28798,
    H_SPELL_FRENZY              = 54100,
    SPELL_WIDOWS_EMBRACE        = 28732,
    H_SPELL_WIDOWS_EMBRACE      = 54097,
    SPELL_FIREBALL              = 54095,
    H_SPELL_FIREBALL            = 54096
};

enum Events
{
    EVENT_NONE,
    EVENT_POISON,
    EVENT_FIRE,
    EVENT_FRENZY
};

enum Achievements
{
    ACHIEVEMENT_MOMMA_SAID_KNOCK_YOU_OUT_10 = 1997,
    ACHIEVEMENT_MOMMA_SAID_KNOCK_YOU_OUT_25 = 2140
};

class boss_faerlina : public CreatureScript
{
public:
    boss_faerlina() : CreatureScript("boss_faerlina") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_faerlinaAI (pCreature);
    }

    struct boss_faerlinaAI : public BossAI
    {
        boss_faerlinaAI(Creature* c) : BossAI(c, BOSS_FAERLINA), greet(false) {}

        bool greet;
        bool doDelayFrenzy;
        bool bAchievement;

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            DoScriptText(RAND(SAY_AGGRO_1,SAY_AGGRO_2,SAY_AGGRO_3,SAY_AGGRO_4), me);
            events.ScheduleEvent(EVENT_POISON, urand(10000,15000));
            events.ScheduleEvent(EVENT_FIRE, urand(6000,18000));
            events.ScheduleEvent(EVENT_FRENZY, urand(60000,80000));
        }

        void Reset()
        {
            _Reset();
            doDelayFrenzy = false;
            bAchievement = true;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!greet && who->GetTypeId() == TYPEID_PLAYER)
            {
                DoScriptText(SAY_GREET, me);
                greet = true;
            }
            BossAI::MoveInLineOfSight(who);
        }

        void KilledUnit(Unit* victim)
        {
            if (!victim->isPet())
                if (!(rand()%3))
                    DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
            DoScriptText(SAY_DEATH, me);

            if (instance && bAchievement)
                instance->DoCompleteAchievement(RAID_MODE(ACHIEVEMENT_MOMMA_SAID_KNOCK_YOU_OUT_10,ACHIEVEMENT_MOMMA_SAID_KNOCK_YOU_OUT_25));
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (doDelayFrenzy && !me->HasAura(RAID_MODE(SPELL_WIDOWS_EMBRACE, H_SPELL_WIDOWS_EMBRACE)))
            {
                doDelayFrenzy = false;
                DoCast(me, RAID_MODE(SPELL_FRENZY, H_SPELL_FRENZY), true);
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_POISON:
                        if (!me->HasAura(RAID_MODE(SPELL_WIDOWS_EMBRACE,H_SPELL_WIDOWS_EMBRACE)))
                            DoCastAOE(RAID_MODE(SPELL_POISON_BOLT_VOLLEY,H_SPELL_POISON_BOLT_VOLLEY));
                        events.ScheduleEvent(EVENT_POISON, urand(8000,15000));
                        break;
                    case EVENT_FIRE:
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(pTarget, RAID_MODE(SPELL_RAIN_OF_FIRE, H_SPELL_RAIN_OF_FIRE));
                        events.ScheduleEvent(EVENT_FIRE, urand(6000,18000));
                        break;
                    case EVENT_FRENZY:
                        if (!me->HasAura(RAID_MODE(SPELL_WIDOWS_EMBRACE,H_SPELL_WIDOWS_EMBRACE)))
                            DoCast(me, RAID_MODE(SPELL_FRENZY, H_SPELL_FRENZY));
                        else
                            doDelayFrenzy = true;

                            events.ScheduleEvent(EVENT_FRENZY, urand(60000,80000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* caster, const SpellEntry *spell)
        {
            if (spell->Id == SPELL_WIDOWS_EMBRACE || spell->Id == H_SPELL_WIDOWS_EMBRACE)
            {
                 bAchievement = false;
                 doDelayFrenzy = false;
                 me->RemoveAurasDueToSpell(SPELL_FRENZY);
                 me->RemoveAurasDueToSpell(H_SPELL_FRENZY);
                 me->Kill(caster);
            }
        }
    };
};

class mob_faerlina_add : public CreatureScript
{
public:
    mob_faerlina_add() : CreatureScript("mob_faerlina_add") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_faerlina_addAI (pCreature);
    }

    struct mob_faerlina_addAI : public ScriptedAI
    {
        mob_faerlina_addAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript *pInstance;
        uint32 uiFireBallTimer;

        void Reset()
        {
            if (GetDifficulty() == RAID_DIFFICULTY_10MAN_NORMAL)
            {
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, SPELL_EFFECT_BIND, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, true);
            }

            uiFireBallTimer = urand(10000,15000);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if(uiFireBallTimer <= diff)
            {
                DoCast(me->getVictim(), DUNGEON_MODE(SPELL_FIREBALL,H_SPELL_FIREBALL));
                uiFireBallTimer = urand(5000,10000);
            } else uiFireBallTimer -= diff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance && GetDifficulty() == RAID_DIFFICULTY_10MAN_NORMAL)
                if (Creature* pFaerlina = pInstance->instance->GetCreature(pInstance->GetData64(DATA_FAERLINA)))
                {
                    me->InterruptNonMeleeSpells(false);
                    DoCast(pFaerlina, SPELL_WIDOWS_EMBRACE,true);
                }
        }
    };
};

void AddSC_boss_faerlina()
{
    new boss_faerlina();
    new mob_faerlina_add();
}