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

enum Spells
{
    SPELL_HATEFUL_STRIKE                        = 41926,
    H_SPELL_HATEFUL_STRIKE                      = 59192,
    SPELL_FRENZY                                = 28131,
    SPELL_BERSERK                               = 26662,
    SPELL_SLIME_BOLT                            = 32309
};

enum Yells
{
    SAY_AGGRO_1                                 = -1533017,
    SAY_AGGRO_2                                 = -1533018,
    SAY_SLAY                                    = -1533019,
    SAY_DEATH                                   = -1533020,
    EMOTE_BERSERK                               = -1533021,
    EMOTE_ENRAGE                                = -1533022
};

enum Events
{
    EVENT_NONE,
    EVENT_BERSERK,
    EVENT_HATEFUL,
    EVENT_SLIME
};

#define ACHIEV_MAKE_QUICK_WERK_OF_HIM_STARTING_EVENT 10286
#define ACHIEVEMENT_MAKE_QUICK_WERK_OF_HIM           RAID_MODE(1856, 1857)
#define MAX_ENCOUNTER_TIME                           3 * 60 * 1000

class boss_patchwerk : public CreatureScript
{
public:
    boss_patchwerk() : CreatureScript("boss_patchwerk") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_patchwerkAI (pCreature);
    }

    struct boss_patchwerkAI : public BossAI
    {
        boss_patchwerkAI(Creature* c) : BossAI(c, BOSS_PATCHWERK) {}

        bool Enraged;

        uint32 EncounterTime;

        void Reset()
        {
            _Reset();
            if (instance)
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_MAKE_QUICK_WERK_OF_HIM_STARTING_EVENT);
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

            if (EncounterTime <= MAX_ENCOUNTER_TIME)
            {
                AchievementEntry const *AchievMakeQuickWerkOfHim = GetAchievementStore()->LookupEntry(ACHIEVEMENT_MAKE_QUICK_WERK_OF_HIM);
                if (AchievMakeQuickWerkOfHim)
                {
                    Map *pMap = me->GetMap();
                    if (pMap && pMap->IsDungeon())
                    {
                        Map::PlayerList const &players = pMap->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            itr->getSource()->CompletedAchievement(AchievMakeQuickWerkOfHim);
                    }
                }
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            Enraged = false;
            EncounterTime = 0;
            DoScriptText(RAND(SAY_AGGRO_1,SAY_AGGRO_2), me);
            events.ScheduleEvent(EVENT_HATEFUL, 1200);
            events.ScheduleEvent(EVENT_BERSERK, 360000);
            if (instance)
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_MAKE_QUICK_WERK_OF_HIM_STARTING_EVENT);
        }

        Unit* GetHatefullStrikeTarget()
        {
            const std::list<HostileReference *> &threatlist = me->getThreatManager().getThreatList();
            std::list<Unit*> targetList;

            for (std::list<HostileReference*>::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
            {
                HostileReference* ref = (*itr);
                if (ref->getTarget() && me->IsWithinMeleeRange(ref->getTarget()))
                    targetList.push_back(ref->getTarget());
            }
            uint32 MostHP = 0;
            Unit* pMostHPTarget = NULL;
            uint32 counter = 0;

            for(std::list<Unit*>::const_iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
            {
                counter++;
                if(counter > 3)
                    break;
                Unit* pTarget = (*itr);
                if (pTarget->isAlive() && pTarget->GetHealth() > MostHP)
                {
                    MostHP = pTarget->GetHealth();
                    pMostHPTarget = pTarget;
                }
            }

            if(pMostHPTarget)
                return pMostHPTarget;
            else
                return me->getVictim();
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            EncounterTime += diff;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_HATEFUL:
                    {
                        if(Unit* StrikeTarget = GetHatefullStrikeTarget())
                            DoCast(StrikeTarget, RAID_MODE(SPELL_HATEFUL_STRIKE,H_SPELL_HATEFUL_STRIKE), true);

                        events.ScheduleEvent(EVENT_HATEFUL, 1200);
                        break;
                    }
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK, true);
                        DoScriptText(EMOTE_BERSERK, me);
                        events.ScheduleEvent(EVENT_SLIME, 2000);
                        break;
                    case EVENT_SLIME:
                        DoCast(me->getVictim(), SPELL_SLIME_BOLT);
                        events.ScheduleEvent(EVENT_SLIME, 2000);
                        break;
                }
            }

            if (!Enraged && HealthBelowPct(5))
            {
                DoCast(me, SPELL_FRENZY, true);
                DoScriptText(EMOTE_ENRAGE, me);
                Enraged = true;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_patchwerk()
{
    new boss_patchwerk();
}