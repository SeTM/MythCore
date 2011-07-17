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
    SAY_AGGRO                  = -1602000,
    SAY_SLAY_1                 = -1602001,
    SAY_SLAY_2                 = -1602002,
    SAY_SLAY_3                 = -1602003,
    SAY_DEATH                  = -1602004,
    SAY_BATTLE_STANCE          = -1602005,
    EMOTE_BATTLE_STANCE        = -1602006,
    SAY_BERSEKER_STANCE        = -1602007,
    EMOTE_BERSEKER_STANCE      = -1602008,
    SAY_DEFENSIVE_STANCE       = -1602009,
    EMOTE_DEFENSIVE_STANCE     = -1602010,
    SPELL_DEFENSIVE_STANCE     = 53790,
    SPELL_SPELL_REFLECTION     = 36096,
    SPELL_PUMMEL               = 12555,
    SPELL_KNOCK_AWAY           = 52029,
    SPELL_IRONFORM             = 52022,
    SPELL_BERSEKER_STANCE      = 53791,
    SPELL_INTERCEPT            = 58769,
    SPELL_WHIRLWIND            = 52027,
    SPELL_CLEAVE               = 15284,
    SPELL_BATTLE_STANCE        = 53792,
    SPELL_MORTAL_STRIKE        = 16856,
    SPELL_SLAM                 = 52026,
    NPC_STORMFORGED_LIEUTENANT = 29240,
    SPELL_ARC_WELD             = 59085,
    SPELL_RENEW_STEEL_N        = 52774,
    SPELL_RENEW_STEEL_H        = 59160,
    EQUIP_SWORD                = 37871,
    EQUIP_SHIELD               = 35642,
    EQUIP_MACE                 = 43623,
    STANCE_DEFENSIVE           = 0,
    STANCE_BERSERKER           = 1,
    STANCE_BATTLE              = 2,
    MAX_DISTANCE_CHARGE        = 8
};

class boss_bjarngrim : public CreatureScript
{
public:
    boss_bjarngrim() : CreatureScript("boss_bjarngrim") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_bjarngrimAI(pCreature);
    }

    struct boss_bjarngrimAI : public ScriptedAI
    {
        boss_bjarngrimAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            m_uiStance = STANCE_DEFENSIVE;
            memset(&m_auiStormforgedLieutenantGUID, 0, sizeof(m_auiStormforgedLieutenantGUID));
        }

        InstanceScript* pInstance;
        bool m_bIsChangingStance;
        uint8 m_uiChargingStatus;
        uint8 m_uiStance;
        uint32 m_uiCharge_Timer;
        uint32 m_uiChangeStance_Timer;
        uint32 m_uiReflection_Timer;
        uint32 m_uiKnockAway_Timer;
        uint32 m_uiPummel_Timer;
        uint32 m_uiIronform_Timer;
        uint32 m_uiIntercept_Timer;
        uint32 m_uiWhirlwind_Timer;
        uint32 m_uiCleave_Timer;
        uint32 m_uiMortalStrike_Timer;
        uint32 m_uiSlam_Timer;
        uint64 m_auiStormforgedLieutenantGUID[2];

        void Reset()
        {
            m_bIsChangingStance = false;
            m_uiChargingStatus = 0;
            m_uiCharge_Timer = 1000;
            m_uiChangeStance_Timer = 20000 + rand()%5000;
            m_uiReflection_Timer = 8000;
            m_uiKnockAway_Timer = 20000;
            m_uiPummel_Timer = 10000;
            m_uiIronform_Timer = 25000;
            m_uiIntercept_Timer = 5000;
            m_uiWhirlwind_Timer = 10000;
            m_uiCleave_Timer = 8000;
            m_uiMortalStrike_Timer = 8000;
            m_uiSlam_Timer = 10000;

            for (uint8 i = 0; i < 2; ++i)
                if (Creature* pStormforgedLieutenant = (Unit::GetCreature((*me), m_auiStormforgedLieutenantGUID[i])))
                    if (!pStormforgedLieutenant->isAlive())
                        pStormforgedLieutenant->Respawn();

            if (m_uiStance != STANCE_DEFENSIVE)
            {
                DoRemoveStanceAura(m_uiStance);
                DoCast(me, SPELL_DEFENSIVE_STANCE);
                m_uiStance = STANCE_DEFENSIVE;
            }

            SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SHIELD, EQUIP_NO_CHANGE);

            if (pInstance)
                pInstance->SetData(TYPE_BJARNGRIM, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            me->CallForHelp(40.0f);

            if (pInstance)
                pInstance->SetData(TYPE_BJARNGRIM, IN_PROGRESS);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
                pInstance->SetData(TYPE_BJARNGRIM, DONE);
        }

        void DoRemoveStanceAura(uint8 uiStance)
        {
            switch (uiStance)
            {
                case STANCE_DEFENSIVE:
                    me->RemoveAurasDueToSpell(SPELL_DEFENSIVE_STANCE);
                    break;
                case STANCE_BERSERKER:
                    me->RemoveAurasDueToSpell(SPELL_BERSEKER_STANCE);
                    break;
                case STANCE_BATTLE:
                    me->RemoveAurasDueToSpell(SPELL_BATTLE_STANCE);
                    break;
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (m_uiChangeStance_Timer <= diff)
            {
                if (me->IsNonMeleeSpellCasted(false))
                    return;

                DoRemoveStanceAura(m_uiStance);

                int uiTempStance = rand()%(3-1);

                if (uiTempStance >= m_uiStance)
                    ++uiTempStance;

                m_uiStance = uiTempStance;

                switch (m_uiStance)
                {
                    case STANCE_DEFENSIVE:
                        DoScriptText(SAY_DEFENSIVE_STANCE, me);
                        DoScriptText(EMOTE_DEFENSIVE_STANCE, me);
                        DoCast(me, SPELL_DEFENSIVE_STANCE);
                        SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SHIELD, EQUIP_NO_CHANGE);
                        break;
                    case STANCE_BERSERKER:
                        DoScriptText(SAY_BERSEKER_STANCE, me);
                        DoScriptText(EMOTE_BERSEKER_STANCE, me);
                        DoCast(me, SPELL_BERSEKER_STANCE);
                        SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SWORD, EQUIP_NO_CHANGE);
                        break;
                    case STANCE_BATTLE:
                        DoScriptText(SAY_BATTLE_STANCE, me);
                        DoScriptText(EMOTE_BATTLE_STANCE, me);
                        DoCast(me, SPELL_BATTLE_STANCE);
                        SetEquipmentSlots(false, EQUIP_MACE, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
                        break;
                }

                m_uiChangeStance_Timer = 20000 + rand()%5000;
                return;
            } else m_uiChangeStance_Timer -= diff;

            switch (m_uiStance)
            {
                case STANCE_DEFENSIVE:
                {
                    if (m_uiReflection_Timer <= diff)
                    {
                        DoCast(me, SPELL_SPELL_REFLECTION);
                        m_uiReflection_Timer = 8000 + rand()%1000;
                    } else m_uiReflection_Timer -= diff;

                    if (m_uiKnockAway_Timer <= diff)
                    {
                        DoCast(me, SPELL_KNOCK_AWAY);
                        m_uiKnockAway_Timer = 20000 + rand()%1000;
                    } else m_uiKnockAway_Timer -= diff;

                    if (m_uiPummel_Timer <= diff)
                    {
                        DoCast(me->getVictim(), SPELL_PUMMEL);
                        m_uiPummel_Timer = 10000 + rand()%1000;
                    } else m_uiPummel_Timer -= diff;

                    if (m_uiIronform_Timer <= diff)
                    {
                        DoCast(me, SPELL_IRONFORM);
                        m_uiIronform_Timer = 25000 + rand()%1000;
                    } else m_uiIronform_Timer -= diff;

                    break;
                }
                case STANCE_BERSERKER:
                {
                    float fDist = me->GetExactDist(me->getVictim()->GetPositionX(), me->getVictim()->GetPositionY(), me->getVictim()->GetPositionZ());
                    if (fDist>=8 && fDist<=25)
                        DoCastVictim(SPELL_INTERCEPT);
                    else
                        m_uiIntercept_Timer -= diff;

                    if (m_uiWhirlwind_Timer <= diff)
                    {
                        DoCast(me, SPELL_WHIRLWIND);
                        m_uiWhirlwind_Timer = 10000 + rand()%1000;
                    } else m_uiWhirlwind_Timer -= diff;

                    if (m_uiCleave_Timer <= diff)
                    {
                        DoCast(me->getVictim(), SPELL_CLEAVE);
                        m_uiCleave_Timer = 8000 + rand()%1000;
                    } else m_uiCleave_Timer -= diff;

                    break;
                }
                case STANCE_BATTLE:
                {
                    if (m_uiMortalStrike_Timer <= diff)
                    {
                        DoCast(me->getVictim(), SPELL_MORTAL_STRIKE);
                        m_uiMortalStrike_Timer = 20000 + rand()%1000;
                    } else m_uiMortalStrike_Timer -= diff;

                    if (m_uiSlam_Timer <= diff)
                    {
                        DoCast(me->getVictim(), SPELL_SLAM);
                        m_uiSlam_Timer = 15000 + rand()%1000;
                    } else m_uiSlam_Timer -= diff;

                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

class mob_stormforged_lieutenant : public CreatureScript
{
public:
    mob_stormforged_lieutenant() : CreatureScript("mob_stormforged_lieutenant") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_stormforged_lieutenantAI(pCreature);
    }

    struct mob_stormforged_lieutenantAI : public ScriptedAI
    {
        mob_stormforged_lieutenantAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint32 m_uiArcWeld_Timer;
        uint32 m_uiRenewSteel_Timer;

        void Reset()
        {
            m_uiArcWeld_Timer = 20000 + rand()%1000;
            m_uiRenewSteel_Timer = 10000 + rand()%1000;
        }

        void EnterCombat(Unit* who)
        {
            if (pInstance)
                if (Creature* pBjarngrim = pInstance->instance->GetCreature(pInstance->GetData64(DATA_BJARNGRIM)))
                    if (pBjarngrim->isAlive() && !pBjarngrim->getVictim())
                        pBjarngrim->AI()->AttackStart(who);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (m_uiArcWeld_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_ARC_WELD);
                m_uiArcWeld_Timer = 20000 + rand()%1000;
            } else m_uiArcWeld_Timer -= diff;

            if (m_uiRenewSteel_Timer <= diff)
            {
                if (pInstance)
                    if (Creature* pBjarngrim = pInstance->instance->GetCreature(pInstance->GetData64(DATA_BJARNGRIM)))
                        if (pBjarngrim->isAlive())
                            DoCast(pBjarngrim, DUNGEON_MODE(SPELL_RENEW_STEEL_N,SPELL_RENEW_STEEL_H));

                m_uiRenewSteel_Timer = 10000 + rand()%4000;
            } else m_uiRenewSteel_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_bjarngrim()
{
    new boss_bjarngrim();
    new mob_stormforged_lieutenant();
}