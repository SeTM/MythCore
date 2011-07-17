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
    SPELL_FROZEN_PRISON          = 47854,
    SPELL_TAIL_SWEEP             = 50155,
    SPELL_CRYSTAL_CHAINS         = 50997,
    SPELL_ENRAGE                 = 8599,
    SPELL_CRYSTALFIRE_BREATH     = 48096,
    H_SPELL_CRYSTALFIRE_BREATH   = 57091,
    SPELL_CRYSTALIZE             = 48179,
    SPELL_INTENSE_COLD           = 48094,
    SPELL_INTENSE_COLD_TRIGGERED = 48095
};

enum Yells
{
    SAY_AGGRO                    = -1576040,
    SAY_SLAY                     = -1576041,
    SAY_ENRAGE                   = -1576042,
    SAY_DEATH                    = -1576043,
    SAY_CRYSTAL_NOVA             = -1576044
};

#define ACHIEV_INTENSE_COLD      2036
#define DATA_CONTAINMENT_SPHERES 3

class boss_keristrasza : public CreatureScript
{
public:
    boss_keristrasza() : CreatureScript("boss_keristrasza") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_keristraszaAI (pCreature);
    }

    struct boss_keristraszaAI : public ScriptedAI
    {
        boss_keristraszaAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint32 uiCrystalfireBreathTimer;
        uint32 uiCrystalChainsTimer;
        uint32 uiCrystalizeTimer;
        uint32 uiTailSweepTimer;
        bool bEnrage;

        std::set<uint64> lIntenseColdPlayers;
        uint64 auiContainmentSphereGUIDs[DATA_CONTAINMENT_SPHERES];

        void Reset()
        {
            uiCrystalfireBreathTimer = 10*IN_MILLISECONDS;
            uiCrystalChainsTimer = 20*IN_MILLISECONDS;
            uiCrystalizeTimer = urand(10*IN_MILLISECONDS, 15*IN_MILLISECONDS);
            uiTailSweepTimer = 5*IN_MILLISECONDS;
            bEnrage = false;

            lIntenseColdPlayers.clear();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
            RemovePrison(CheckContainmentSpheres());

            if (pInstance)
                pInstance->SetData(DATA_KERISTRASZA_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
            DoCast(SPELL_INTENSE_COLD);

            if (pInstance)
            {
                pInstance->SetData(DATA_KERISTRASZA_EVENT, IN_PROGRESS);

                Map::PlayerList const &players = pInstance->instance->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    lIntenseColdPlayers.insert(itr->getSource()->GetGUID());
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
            {
                AchievementEntry const *achievIntenseCold = GetAchievementStore()->LookupEntry(ACHIEV_INTENSE_COLD);
                if (achievIntenseCold && IsHeroic())
                {
                    for (std::set<uint64>::const_iterator itr = lIntenseColdPlayers.begin(); itr != lIntenseColdPlayers.end(); ++itr)
                    {
                        Player* temp = Unit::GetPlayer(*me, *itr);
                        if (temp && temp->isAlive() && (temp->GetDistance2d(me) < 50))
                            temp->CompletedAchievement(achievIntenseCold);
                    }
                }

                pInstance->SetData(DATA_KERISTRASZA_EVENT, DONE);
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(SAY_SLAY, me);
        }

        bool CheckContainmentSpheres(bool remove_prison = false)
        {
            if (!pInstance)
                return false;

            auiContainmentSphereGUIDs[0] = pInstance->GetData64(ANOMALUS_CONTAINMET_SPHERE);
            auiContainmentSphereGUIDs[1] = pInstance->GetData64(ORMOROKS_CONTAINMET_SPHERE);
            auiContainmentSphereGUIDs[2] = pInstance->GetData64(TELESTRAS_CONTAINMET_SPHERE);

            GameObject *ContainmentSpheres[DATA_CONTAINMENT_SPHERES];

            for (uint8 i = 0; i < DATA_CONTAINMENT_SPHERES; ++i)
            {
                ContainmentSpheres[i] = pInstance->instance->GetGameObject(auiContainmentSphereGUIDs[i]);
                if (!ContainmentSpheres[i])
                    return false;
                if (ContainmentSpheres[i]->GetGoState() != GO_STATE_ACTIVE)
                    return false;
            }
            if (remove_prison)
                RemovePrison(true);
            return true;
        }

        void RemovePrison(bool remove)
        {
            if (remove)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                if (me->HasAura(SPELL_FROZEN_PRISON))
                    me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);
            } else {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                DoCast(me, SPELL_FROZEN_PRISON, false);
            }
        }

        void SpellHitTarget(Unit *pTarget, const SpellEntry *spell)
        {
            if (pTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            if (spell->Id == SPELL_INTENSE_COLD_TRIGGERED)
                 if (Aura* pColdAura = pTarget->GetAura(SPELL_INTENSE_COLD_TRIGGERED))
                     if (pColdAura->GetStackAmount() > 2)
                         lIntenseColdPlayers.erase(pTarget->GetGUID());
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (!bEnrage && HealthBelowPct(25))
            {
                DoScriptText(SAY_ENRAGE, me);
                DoCast(me, SPELL_ENRAGE);
                bEnrage = true;
            }

            if (uiCrystalfireBreathTimer <= diff)
            {
            DoCast(me->getVictim(), DUNGEON_MODE(SPELL_CRYSTALFIRE_BREATH,H_SPELL_CRYSTALFIRE_BREATH));
                uiCrystalfireBreathTimer = 14*IN_MILLISECONDS;
            } else uiCrystalfireBreathTimer -= diff;

            if (uiTailSweepTimer <= diff)
            {
                DoCast(me, SPELL_TAIL_SWEEP);
                uiTailSweepTimer = 5*IN_MILLISECONDS;
            } else uiTailSweepTimer -= diff;

            if (uiCrystalChainsTimer <= diff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(pTarget, SPELL_CRYSTAL_CHAINS);
                uiCrystalChainsTimer = urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS);
            } else uiCrystalChainsTimer -= diff;

            if (IsHeroic()) {
                if (uiCrystalizeTimer <= diff)
                {
                    DoScriptText(SAY_CRYSTAL_NOVA, me);
                    DoCast(me, SPELL_CRYSTALIZE);

                    uiCrystalizeTimer = urand(20*IN_MILLISECONDS, 25*IN_MILLISECONDS);
                } else uiCrystalizeTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class containment_sphere : public GameObjectScript
{
public:
    containment_sphere() : GameObjectScript("containment_sphere") {}

    bool OnGossipHello(Player* /*pPlayer*/, GameObject *pGO)
    {
        InstanceScript *pInstance = pGO->GetInstanceScript();

        Creature* pKeristrasza = Unit::GetCreature(*pGO, pInstance ? pInstance->GetData64(DATA_KERISTRASZA) : 0);
        if (pKeristrasza && pKeristrasza->isAlive())
        {
            pGO->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
            pGO->SetGoState(GO_STATE_ACTIVE);

            CAST_AI(boss_keristrasza::boss_keristraszaAI, pKeristrasza->AI())->CheckContainmentSpheres(true);
        }
        return true;
    }
};

void AddSC_boss_keristrasza()
{
    new boss_keristrasza();
    new containment_sphere();
}