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

#define SAY_AGGRO           RAND(-1533109,-1533110,-1533111)
#define SAY_SLAY            -1533112
#define SAY_TAUNT           RAND(-1533113,-1533114,-1533115,-1533116,-1533117)
#define SAY_DEATH           -1533118

#define SPELL_SPELL_DISRUPTION  29310
#define SPELL_DECREPIT_FEVER    RAID_MODE(29998,55011)
#define SPELL_PLAGUE_CLOUD      29350

enum Events
{
    EVENT_NONE,
    EVENT_DISRUPT,
    EVENT_FEVER,
    EVENT_ERUPT,
    EVENT_PHASE
};

enum Phases
{
    PHASE_FIGHT = 1,
    PHASE_DANCE
};

enum Achievment
{
    ACHIEVMENT_THE_SAFETY_DANCE_10 = 1996,
    ACHIEVMENT_THE_SAFETY_DANCE_25 = 2139
};

class boss_heigan : public CreatureScript
{
public:
    boss_heigan() : CreatureScript("boss_heigan") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_heiganAI (pCreature);
    }

    struct boss_heiganAI : public BossAI
    {
        boss_heiganAI(Creature* c) : BossAI(c, BOSS_HEIGAN) {}

        uint32 eruptSection;
        bool eruptDirection;
        Phases phase;

        void Reset()
        {
            _Reset();
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

            if(instance && instance->GetData(DATA_HEIGAN_PLAYER_DEATHS) == 0)
                instance->DoCompleteAchievement(RAID_MODE(ACHIEVMENT_THE_SAFETY_DANCE_10,ACHIEVMENT_THE_SAFETY_DANCE_25));
        }

        void TeleportHeiganCheaters()
        {
            float x, y, z;
            me->GetPosition(x, y, z);

            uint64 tempDoorGuid_1 = instance->GetData64(DATA_GO_ROOM_HEIGAN);
            uint64 tempDoorGuid_2 = instance->GetData64(DATA_GO_PASSAGE_HEIGAN);
            std::list<HostileReference*> &m_threatlist = me->getThreatManager().getThreatList();
            for (std::list<HostileReference*>::iterator itr = m_threatlist.begin(); itr != m_threatlist.end(); ++itr)
            if ((*itr)->getTarget()->GetTypeId() == TYPEID_PLAYER)
                if(Player* player = (*itr)->getTarget()->ToPlayer())
                {
                    if(GameObject* door_1 = GameObject::GetGameObject(*me,tempDoorGuid_1))
                    {
                        if(player->GetPositionX() > door_1->GetPositionX())
                            player->NearTeleportTo(x, y, z, 0);

                        continue;
                    }

                    if(GameObject* door_2 = GameObject::GetGameObject(*me,tempDoorGuid_2))
                    {
                        if(player->GetPositionY() < door_2->GetPositionY())
                            player->NearTeleportTo(x, y, z, 0);

                        continue;
                    }
                }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            TeleportHeiganCheaters();
            DoScriptText(SAY_AGGRO, me);
            EnterPhase(PHASE_FIGHT);
        }

        void EnterPhase(Phases newPhase)
        {
            phase = newPhase;
            events.Reset();
            eruptSection = 3;
            if (phase == PHASE_FIGHT)
            {
                me->GetMotionMaster()->MoveChase(me->getVictim());
                events.ScheduleEvent(EVENT_DISRUPT, urand(10000, 25000));
                events.ScheduleEvent(EVENT_FEVER, urand(15000, 20000));
                events.ScheduleEvent(EVENT_PHASE, 90000);
                events.ScheduleEvent(EVENT_ERUPT, 15000);
            } else {
                float x, y, z, o;
                me->GetHomePosition(x, y, z, o);
                me->NearTeleportTo(x, y, z, o);
                me->GetMotionMaster()->MoveIdle();
                DoCastAOE(SPELL_PLAGUE_CLOUD);
                events.ScheduleEvent(EVENT_PHASE, 45000);
                events.ScheduleEvent(EVENT_ERUPT, 8000);
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim() || !CheckInRoom())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_DISRUPT:
                        DoCastAOE(SPELL_SPELL_DISRUPTION);
                        events.ScheduleEvent(EVENT_DISRUPT, urand(5000, 10000));
                        break;
                    case EVENT_FEVER:
                        DoCastAOE(SPELL_DECREPIT_FEVER);
                        events.ScheduleEvent(EVENT_FEVER, urand(20000, 25000));
                        break;
                    case EVENT_PHASE:
                        EnterPhase(phase == PHASE_FIGHT ? PHASE_DANCE : PHASE_FIGHT);
                        break;
                    case EVENT_ERUPT:
                        instance->SetData(DATA_HEIGAN_ERUPT, eruptSection);
                        TeleportHeiganCheaters();

                        if (eruptSection == 0)
                            eruptDirection = true;
                        else if (eruptSection == 3)
                            eruptDirection = false;

                        eruptDirection ? ++eruptSection : --eruptSection;

                        events.ScheduleEvent(EVENT_ERUPT, phase == PHASE_FIGHT ? 10000 : 4000);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_heigan()
{
    new boss_heigan();
}