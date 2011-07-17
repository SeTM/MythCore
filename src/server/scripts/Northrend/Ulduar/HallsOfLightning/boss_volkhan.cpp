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
    SAY_AGGRO                     = -1602032,
    SAY_SLAY_1                    = -1602033,
    SAY_SLAY_2                    = -1602034,
    SAY_SLAY_3                    = -1602035,
    SAY_DEATH                     = -1602036,
    SAY_STOMP_1                   = -1602037,
    SAY_STOMP_2                   = -1602038,
    SAY_FORGE_1                   = -1602039,
    SAY_FORGE_2                   = -1602040,
    EMOTE_TO_ANVIL                = -1602041,
    EMOTE_SHATTER                 = -1602042,
    SPELL_HEAT_N                  = 52387,
    SPELL_HEAT_H                  = 59528,
    SPELL_SHATTERING_STOMP_N      = 52237,
    SPELL_SHATTERING_STOMP_H      = 59529,
    SPELL_TEMPER                  = 52238,
    SPELL_TEMPER_DUMMY            = 52654,
    SPELL_SUMMON_MOLTEN_GOLEM     = 52405,
    SPELL_BLAST_WAVE              = 23113,
    SPELL_IMMOLATION_STRIKE_N     = 52433,
    SPELL_IMMOLATION_STRIKE_H     = 59530,
    SPELL_SHATTER_N               = 52429,
    SPELL_SHATTER_H               = 59527,
    NPC_MOLTEN_GOLEM              = 28695,
    NPC_BRITTLE_GOLEM             = 28681,
    POINT_ID_ANVIL                = 0,
    MAX_GOLEM                     = 2,
    ACHIEVEMENT_SHATTER_RESISTANT = 2042
};

class boss_volkhan : public CreatureScript
{
public:
    boss_volkhan() : CreatureScript("boss_volkhan") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_volkhanAI(pCreature);
    }

    struct boss_volkhanAI : public ScriptedAI
    {
        boss_volkhanAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        std::list<uint64> m_lGolemGUIDList;
        bool m_bHasTemper;
        bool m_bIsStriking;
        bool m_bCanShatterGolem;
        bool m_bMove;
        uint8 GolemsShattered;
        uint32 m_uiPause_Timer;
        uint32 m_uiShatteringStomp_Timer;
        uint32 m_uiShatter_Timer;
        uint32 m_uiCheckTimer;
        uint32 m_uiCheckZ;
        uint32 m_uiHealthAmountModifier;

        void Reset()
        {
            m_bIsStriking = false;
            m_bHasTemper = false;
            m_bCanShatterGolem = false;
            m_bMove = false;
            m_uiPause_Timer = 1500;
            m_uiShatteringStomp_Timer = 30000;
            m_uiShatter_Timer = 3000;
            m_uiCheckTimer = 1100;
            m_uiCheckZ = 1000;
            GolemsShattered = 0;

            DespawnGolem();

            me->SetReactState(REACT_AGGRESSIVE);
            if (!me->HasUnitMovementFlag(MOVEMENTFLAG_WALKING))
                me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);

            if (pInstance)
                pInstance->SetData(TYPE_VOLKHAN, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
                pInstance->SetData(TYPE_VOLKHAN, IN_PROGRESS);
        }

        void AttackStart(Unit* pWho)
        {
            if (me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 0.0f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);

                if (!m_bHasTemper)
                    me->GetMotionMaster()->MoveChase(pWho);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);
            DespawnGolem();

            if (pInstance)
                pInstance->SetData(TYPE_VOLKHAN, DONE);

            if (IsHeroic() && GolemsShattered < 5)
            {
                AchievementEntry const *AchievShatterResistant = GetAchievementStore()->LookupEntry(ACHIEVEMENT_SHATTER_RESISTANT);
                if (AchievShatterResistant)
                {
                    Map* pMap = me->GetMap();
                    if (pMap && pMap->IsDungeon())
                    {
                        Map::PlayerList const &players = pMap->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            itr->getSource()->CompletedAchievement(AchievShatterResistant);
                    }
                }
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }

        void DespawnGolem()
        {
            if (m_lGolemGUIDList.empty())
                return;

            for (std::list<uint64>::const_iterator itr = m_lGolemGUIDList.begin(); itr != m_lGolemGUIDList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                {
                    if (pTemp->isAlive())
                        pTemp->DespawnOrUnsummon();
                }
            }

            m_lGolemGUIDList.clear();
        }

        void ShatterGolem()
        {
            if (m_lGolemGUIDList.empty())
                return;

            for (std::list<uint64>::const_iterator itr = m_lGolemGUIDList.begin(); itr != m_lGolemGUIDList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                {
                    if (pTemp->isAlive() && pTemp->GetEntry() == NPC_BRITTLE_GOLEM)
                    {
                        pTemp->CastSpell(pTemp, DUNGEON_MODE(SPELL_SHATTER_N, SPELL_SHATTER_H), false);
                        GolemsShattered++;
                    }
                }
            }
        }

        void JustSummoned(Creature* pSummoned)
        {
            if (pSummoned->GetEntry() == NPC_MOLTEN_GOLEM)
            {
                m_lGolemGUIDList.push_back(pSummoned->GetGUID());

                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    pSummoned->AI()->AttackStart(pTarget);
                pSummoned->CastSpell(pSummoned, DUNGEON_MODE(SPELL_HEAT_N, SPELL_HEAT_H), false, NULL, NULL, me->GetGUID());
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (m_uiCheckZ <= diff)
            {
                if (me->GetPositionZ() < 50.0f)
                {
                    EnterEvadeMode();
                    return;
                }
                m_uiCheckZ = 1000;
            } else m_uiCheckZ -= diff;

            if (m_bIsStriking && !m_bMove)
            {
                if (m_uiPause_Timer <= diff)
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != TARGETED_MOTION_TYPE)
                        if (me->getVictim())
                            me->GetMotionMaster()->MoveChase(me->getVictim());

                    m_bHasTemper = false;
                    m_bIsStriking = false;
                    m_uiPause_Timer = 1500;
                } else m_uiPause_Timer -= diff;

                return;
            }

            if (!m_bHasTemper && !m_bMove)
            {
                if (m_uiShatteringStomp_Timer <= diff)
                {
                    DoScriptText(RAND(SAY_STOMP_1,SAY_STOMP_2), me);

                    DoCast(me, DUNGEON_MODE(SPELL_SHATTERING_STOMP_N,SPELL_SHATTERING_STOMP_H));

                    if (Creature* pCreature = me->FindNearestCreature(NPC_BRITTLE_GOLEM,99))
                    {
                        DoScriptText(EMOTE_SHATTER, me);
                        m_bCanShatterGolem = true;
                    }

                    m_uiShatteringStomp_Timer = 30000;
                } else m_uiShatteringStomp_Timer -= diff;
            }

            if (m_bCanShatterGolem)
            {
                if (m_uiShatter_Timer <= diff)
                {
                    ShatterGolem();
                    m_uiShatter_Timer = 3000;
                    m_bCanShatterGolem = false;
                } else m_uiShatter_Timer -= diff;
            }

            Creature* pAnvil = pInstance->instance->GetCreature(pInstance->GetData64(DATA_VOLKHAN_ANVIL));

            float fX, fY, fZ;
            me->GetContactPoint(pAnvil, fX, fY, fZ, INTERACTION_DISTANCE);

            if (!m_bCanShatterGolem && me->HealthBelowPct(100 - 20 * m_uiHealthAmountModifier) && !m_bMove)
            {
                ++m_uiHealthAmountModifier;

                if (me->IsNonMeleeSpellCasted(false))
                    me->InterruptNonMeleeSpells(false);

                DoScriptText(RAND(SAY_FORGE_1,SAY_FORGE_2), me);

                if (me->GetDistance(pAnvil) > 5)
                {
                    me->GetMotionMaster()->Clear();
                    me->SetReactState(REACT_PASSIVE);
                    me->GetMotionMaster()->MovePoint(5,fX,fY,fZ);
                }

                DoScriptText(EMOTE_TO_ANVIL, me);
                m_bMove=true;
            }

            if (me->IsWithinMeleeRange(pAnvil,5) && m_bMove)
            {
                me->GetMotionMaster()->Clear();
                me->SetReactState(REACT_AGGRESSIVE);
                m_bHasTemper = true;
                m_bMove=false;
                for (uint8 i = 0; i < MAX_GOLEM; ++i)
                    DoCast(SPELL_SUMMON_MOLTEN_GOLEM);
                DoCast(SPELL_TEMPER);
                m_bIsStriking = true;
            }

            if (me->GetMotionMaster()->GetCurrentMovementGeneratorType()!=POINT_MOTION_TYPE && m_bMove)
            {
                me->GetMotionMaster()->MovePoint(5,fX,fY,fZ);
                m_uiCheckTimer=1100;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class mob_molten_golem : public CreatureScript
{
public:
    mob_molten_golem() : CreatureScript("mob_molten_golem") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_molten_golemAI(pCreature);
    }

    struct mob_molten_golemAI : public ScriptedAI
    {
        mob_molten_golemAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        bool m_bIsFrozen;
        uint32 m_uiBlast_Timer;
        uint32 m_uiDeathDelay_Timer;
        uint32 m_uiImmolation_Timer;

        void Reset()
        {
            m_bIsFrozen = false;

            m_uiBlast_Timer = 20000;
            m_uiDeathDelay_Timer = 0;
            m_uiImmolation_Timer = 5000;
        }

        void AttackStart(Unit* pWho)
        {
            if (me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 0.0f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);

                if (!m_bIsFrozen)
                    me->GetMotionMaster()->MoveChase(pWho);
            }
        }

        void DamageTaken(Unit* /*pDoneBy*/, uint32 &uiDamage)
        {
            if (uiDamage > me->GetHealth())
            {
                me->UpdateEntry(NPC_BRITTLE_GOLEM);
                me->SetHealth(1);
                uiDamage = 0;
                me->RemoveAllAuras();
                me->AttackStop();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                if (me->IsNonMeleeSpellCasted(false))
                    me->InterruptNonMeleeSpells(false);
                if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == TARGETED_MOTION_TYPE)
                    me->GetMotionMaster()->MovementExpired();
                m_bIsFrozen = true;
            }
        }

        void SpellHit(Unit* /*pCaster*/, const SpellEntry* pSpell)
        {
            if (pSpell->Id == SPELL_SHATTER_N || pSpell->Id == SPELL_SHATTER_H)
            {
                if (me->GetEntry() == NPC_BRITTLE_GOLEM)
                    me->DespawnOrUnsummon();
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim() || m_bIsFrozen)
                return;

            if (m_uiBlast_Timer <= diff)
            {
                DoCast(me, SPELL_BLAST_WAVE);
                m_uiBlast_Timer = 20000;
            } else m_uiBlast_Timer -= diff;

            if (m_uiImmolation_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_IMMOLATION_STRIKE_N);
                m_uiImmolation_Timer = 5000;
            } else m_uiImmolation_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_volkhan()
{
    new boss_volkhan();
    new mob_molten_golem();
}