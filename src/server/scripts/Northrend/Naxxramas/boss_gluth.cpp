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

#define SPELL_MORTAL_WOUND         25646
#define SPELL_ENRAGE               RAID_MODE(28371,54427)
#define SPELL_DECIMATE             RAID_MODE(28374,54426)
#define SPELL_BERSERK              26662
#define SPELL_INFECTED_WOUND       29307
#define SPELL_INFECTED_TRIGGERED   29306

#define MOB_ZOMBIE  16360

const Position PosSummon[3] =
{
    {3267.9f, -3172.1f, 297.42f, 0.94f},
    {3253.2f, -3132.3f, 297.42f, 0},
    {3308.3f, -3185.8f, 297.42f, 1.58f}
};

enum Events
{
    EVENT_NONE,
    EVENT_WOUND,
    EVENT_ENRAGE,
    EVENT_DECIMATE,
    EVENT_BERSERK,
    EVENT_SUMMON
};

#define EMOTE_NEARBY    " spots a nearby zombie to devour!"

class boss_gluth : public CreatureScript
{
public:
    boss_gluth() : CreatureScript("boss_gluth") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_gluthAI (pCreature);
    }

    struct boss_gluthAI : public BossAI
    {
        boss_gluthAI(Creature* c) : BossAI(c, BOSS_GLUTH)
        {
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_INFECTED_TRIGGERED, true);
        }

        void Reset()
        {
            _Reset();
        }

        void AttackGluth(Creature* pWho)
        {
            pWho->SetReactState(REACT_PASSIVE);
            pWho->AddThreat(me, 9999999);
            pWho->AI()->AttackStart(me);
            pWho->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            pWho->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetEntry() == MOB_ZOMBIE && me->IsWithinDistInMap(who, 7))
            {
                SetGazeOn(who);
                AttackGluth(who->ToCreature());

                me->MonsterTextEmote(EMOTE_NEARBY, 0, true);
            } else BossAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_WOUND, 10000);
            events.ScheduleEvent(EVENT_ENRAGE, 15000);
            events.ScheduleEvent(EVENT_DECIMATE, RAID_MODE(120000,90000));
            events.ScheduleEvent(EVENT_BERSERK, RAID_MODE(8*60000,7*60000));
            events.ScheduleEvent(EVENT_SUMMON, 15000);
        }

        void JustSummoned(Creature* summon)
        {
            if (summon->GetEntry() == MOB_ZOMBIE)
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    summon->AI()->AttackStart(pTarget);

            summons.Summon(summon);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictimWithGaze() || !CheckInRoom())
                return;

            if (me->GetDistance(me->GetHomePosition()) > 80.0f)
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WOUND:
                        DoCast(me->getVictim(), SPELL_MORTAL_WOUND);
                        events.ScheduleEvent(EVENT_WOUND, 10000);
                        break;
                    case EVENT_ENRAGE:
                        DoCast(me, SPELL_ENRAGE);
                        events.ScheduleEvent(EVENT_ENRAGE, 15000);
                        break;
                    case EVENT_DECIMATE:
                        DoCastAOE(SPELL_DECIMATE);
                        events.ScheduleEvent(EVENT_DECIMATE, RAID_MODE(120000,90000));

                        for (std::list<uint64>::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        {
                            Creature* minion = Unit::GetCreature(*me, *itr);
                            if (minion && minion->isAlive())
                            {
                                int32 damage = int32(minion->GetHealth()) - int32(minion->CountPctFromMaxHealth(5));
                                if (damage > 0)
                                    me->CastCustomSpell(28375, SPELLVALUE_BASE_POINT0, damage, minion, true);

                                AttackGluth(minion);
                            }
                        }
                        break;
                    case EVENT_BERSERK:
                        if(!me->HasAura(SPELL_BERSERK))
                            DoCast(me, SPELL_BERSERK);
                        events.ScheduleEvent(EVENT_BERSERK, 1*60000);
                        break;
                    case EVENT_SUMMON:
                        for (int32 i = 0; i < RAID_MODE(1, 2); ++i)
                            DoSummon(MOB_ZOMBIE, PosSummon[rand() % RAID_MODE(1,3)]);
                        events.ScheduleEvent(EVENT_SUMMON, 10000);
                        break;
                }
            }

            if (me->getVictim() && me->getVictim()->GetEntry() == MOB_ZOMBIE)
            {
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                    me->Kill(me->getVictim());
                    me->ModifyHealth(int32(me->CountPctFromMaxHealth(5)));
                }
            } else DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_gluth()
{
    new boss_gluth();
}