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

enum eEnums
{
    ACHIEV_TIMELY_DEATH_START_EVENT = 20384,
    SAY_AGGRO                       = -1602018,
    SAY_INTRO_1                     = -1602019,
    SAY_INTRO_2                     = -1602020,
    SAY_SLAY_1                      = -1602021,
    SAY_SLAY_2                      = -1602022,
    SAY_SLAY_3                      = -1602023,
    SAY_DEATH                       = -1602024,
    SAY_NOVA_1                      = -1602025,
    SAY_NOVA_2                      = -1602026,
    SAY_NOVA_3                      = -1602027,
    SAY_75HEALTH                    = -1602028,
    SAY_50HEALTH                    = -1602029,
    SAY_25HEALTH                    = -1602030,
    EMOTE_NOVA                      = -1602031,
    SPELL_ARC_LIGHTNING             = 52921,
    SPELL_LIGHTNING_NOVA_N          = 52960,
    SPELL_LIGHTNING_NOVA_H          = 59835,
    SPELL_PULSING_SHOCKWAVE_N       = 52961,
    SPELL_PULSING_SHOCKWAVE_H       = 59836,
    SPELL_PULSING_SHOCKWAVE_AURA    = 59414
};

class boss_loken : public CreatureScript
{
public:
    boss_loken() : CreatureScript("boss_loken") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_lokenAI(pCreature);
    }

    struct boss_lokenAI : public ScriptedAI
    {
        boss_lokenAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        bool m_bIsAura;
        bool bHit;
        uint32 m_uiArcLightning_Timer;
        uint32 m_uiLightningNova_Timer;
        uint32 m_uiPulsingShockwave_Timer;
        uint32 m_uiResumePulsingShockwave_Timer;
        uint32 m_uiHealthAmountModifier;

        void Reset()
        {
            m_bIsAura = false;

            m_uiArcLightning_Timer = 15000;
            m_uiLightningNova_Timer = 20000;
            m_uiPulsingShockwave_Timer = 2000;
            m_uiResumePulsingShockwave_Timer = 15000;
            m_uiHealthAmountModifier = 1;

            if (pInstance)
            {
                pInstance->SetData(TYPE_LOKEN, NOT_STARTED);
                pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMELY_DEATH_START_EVENT);
            }
        }

        void SpellHitTarget(Unit* pTarget, const SpellEntry * spell)
        {
            if (spell->Id==SPELL_ARC_LIGHTNING && bHit)
                if (rand()%100<DUNGEON_MODE(65,80))
                {
                    bHit=false;
                    DoCast(pTarget->GetNextRandomRaidMemberOrPet(10.0f),SPELL_ARC_LIGHTNING);
                }
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
            {
                pInstance->SetData(TYPE_LOKEN, IN_PROGRESS);
                pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMELY_DEATH_START_EVENT);
            }

            if (pInstance->GetData(TYPE_IONAR)!=DONE)
            {
                Map* pMap = me->GetMap();
                if (pMap->IsDungeon())
                {
                    Map::PlayerList const &PlayerList = pMap->GetPlayers();
                    if (PlayerList.isEmpty())
                        return;

                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                        if (i->getSource() && i->getSource()->isAlive() && !i->getSource()->isGameMaster())
                            me->DealDamage(i->getSource(),i->getSource()->GetMaxHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                }
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
                pInstance->SetData(TYPE_LOKEN, DONE);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (m_bIsAura)
            {
                if (m_uiPulsingShockwave_Timer <= diff)
                {
                    Map* pMap = me->GetMap();
                    if (pMap->IsDungeon())
                    {
                        Map::PlayerList const &PlayerList = pMap->GetPlayers();

                        if (PlayerList.isEmpty())
                            return;

                        float fDist=0;
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (i->getSource() && i->getSource()->isAlive() && i->getSource()->isTargetableForAttack())
                            {
                                float fDistTemp = me->GetExactDist(i->getSource()->GetPositionX(), i->getSource()->GetPositionY(), i->getSource()->GetPositionZ());
                                if (fDistTemp>fDist)
                                    fDist=fDistTemp;
                            }
                        int32 dmg= int32(DUNGEON_MODE(100, 150)*fDist);
                        int32 range=200;
                        me->CastCustomSpell(me->getVictim(), DUNGEON_MODE(52942, 59837), &dmg, &range, 0, false);
                    }
                    m_uiPulsingShockwave_Timer = 2000;
                } else m_uiPulsingShockwave_Timer -= diff;
            } else {
                if (m_uiResumePulsingShockwave_Timer <= diff)
                {
                    DoCast(me, SPELL_PULSING_SHOCKWAVE_AURA, true);

                    DoCast(me, DUNGEON_MODE(SPELL_PULSING_SHOCKWAVE_N,SPELL_PULSING_SHOCKWAVE_H));
                    m_bIsAura = true;
                    m_uiResumePulsingShockwave_Timer = 0;
                } else m_uiResumePulsingShockwave_Timer -= diff;
            }

            if (m_uiArcLightning_Timer <= diff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(pTarget, SPELL_ARC_LIGHTNING);

                bHit=true;
                m_uiArcLightning_Timer = 15000 + rand()%1000;
            } else m_uiArcLightning_Timer -= diff;

            if (m_uiLightningNova_Timer <= diff)
            {
                DoScriptText(RAND(SAY_NOVA_1,SAY_NOVA_2,SAY_NOVA_3), me);
                DoScriptText(EMOTE_NOVA, me);
                DoCast(me, DUNGEON_MODE(SPELL_LIGHTNING_NOVA_N,SPELL_LIGHTNING_NOVA_H));

                m_bIsAura = false;
                m_uiResumePulsingShockwave_Timer = DUNGEON_MODE(5000, 4000);
                m_uiLightningNova_Timer = 20000 + rand()%1000;
            } else m_uiLightningNova_Timer -= diff;

            if (HealthBelowPct(100 - 25 * m_uiHealthAmountModifier))
            {
                switch (m_uiHealthAmountModifier)
                {
                    case 1: DoScriptText(SAY_75HEALTH, me); break;
                    case 2: DoScriptText(SAY_50HEALTH, me); break;
                    case 3: DoScriptText(SAY_25HEALTH, me); break;
                }

                ++m_uiHealthAmountModifier;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_loken()
{
    new boss_loken();
}