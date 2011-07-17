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

#define SOUND_AGGRO     RAND(8852,8853,8854)
#define SOUND_SLAY      RAND(8861,8863)
#define SOUND_COMMND    RAND(8855,8856,8858,8859,8861)
#define SOUND_DEATH     8860
#define SOUND_AGGROMIX  8847

#define SPELL_UNBALANCING_STRIKE    26613
#define SPELL_DISRUPTING_SHOUT      RAID_MODE(29107,55543)
#define SPELL_JAGGED_KNIFE          55550
#define SPELL_HOPELESS              29125

enum Events
{
    EVENT_NONE,
    EVENT_STRIKE,
    EVENT_SHOUT,
    EVENT_KNIFE,
    EVENT_COMMAND
};

class boss_razuvious : public CreatureScript
{
public:
    boss_razuvious() : CreatureScript("boss_razuvious") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_razuviousAI (pCreature);
    }

    struct boss_razuviousAI : public BossAI
    {
        boss_razuviousAI(Creature* c) : BossAI(c, BOSS_RAZUVIOUS) {}

        void Reset()
        {
            _Reset();
        }

        void KilledUnit(Unit* /*victim*/)
        {
            if (!(rand()%3))
                DoPlaySoundToSet(me, SOUND_SLAY);
        }

        void DamageTaken(Unit* pDone_by, uint32& uiDamage)
        {
            if (pDone_by->GetTypeId() == TYPEID_UNIT && (pDone_by->GetEntry() == 16803 || pDone_by->GetEntry() == 29941))
                me->LowerPlayerDamageReq(uiDamage);
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
            DoPlaySoundToSet(me, SOUND_DEATH);
            me->CastSpell(me, SPELL_HOPELESS, true);
            std::list<Creature*> lList;
            me->GetCreatureListWithEntryInGrid(lList , 29912, 200);

            if (!lList.size())
                return;

            for (std::list<Creature*>::const_iterator i = lList.begin(); i != lList.end(); ++i)
                (*i)->DealDamage((*i),(*i)->GetHealth());
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            DoPlaySoundToSet(me, SOUND_AGGRO);
            events.ScheduleEvent(EVENT_STRIKE, 30000);
            events.ScheduleEvent(EVENT_SHOUT, 25000);
            events.ScheduleEvent(EVENT_COMMAND, 40000);
            events.ScheduleEvent(EVENT_KNIFE, 10000);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_STRIKE:
                        DoCast(me->getVictim(), SPELL_UNBALANCING_STRIKE);
                        events.ScheduleEvent(EVENT_STRIKE, 30000);
                        return;
                    case EVENT_SHOUT:
                        DoCastAOE(SPELL_DISRUPTING_SHOUT);
                        events.ScheduleEvent(EVENT_SHOUT, 25000);
                        return;
                    case EVENT_KNIFE:
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f))
                            DoCast(pTarget, SPELL_JAGGED_KNIFE);
                        events.ScheduleEvent(EVENT_KNIFE, 10000);
                        return;
                    case EVENT_COMMAND:
                        DoPlaySoundToSet(me, SOUND_COMMND);
                        events.ScheduleEvent(EVENT_COMMAND, 40000);
                        return;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_razuvious()
{
    new boss_razuvious();
}