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
#include "oculus.h"
#include "MapManager.h"

enum Says
{
    SAY_AGGRO           = 0,
    SAY_AZURE           = 1,
    SAY_AZURE_EMOTE     = 2,
    SAY_DEATH           = 3
};

enum Spells
{
    SPELL_ENERGIZE_CORES_VISUAL                   = 62136,
    SPELL_ENERGIZE_CORES                          = 50785,
    SPELL_CALL_AZURE_RING_CAPTAIN                 = 51002,
    SPELL_CALL_AMPLIFY_MAGIC                      = 51054,

    SPELL_ICE_BEAM                                = 49549,
    SPELL_ARCANE_BEAM_PERIODIC                    = 51019,
    SPELL_SUMMON_ARCANE_BEAM                      = 51017
};

enum Events
{
    EVENT_ENERGIZE_CORES = 1,
    EVENT_CALL_AZURE,
    EVENT_AMPLIFY_MAGIC,
    EVENT_ENERGIZE_CORES_VISUAL
};

class boss_varos : public CreatureScript
{
public:
    boss_varos() : CreatureScript("boss_varos") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_varosAI (creature);
    }

    struct boss_varosAI : public BossAI
    {
        boss_varosAI(Creature* creature) : BossAI(creature, DATA_VAROS_EVENT)
        {
            if (instance->GetBossState(DATA_DRAKOS_EVENT) != DONE)
                DoCast(me,SPELL_CENTRIFUGE_SHIELD);
        }

        void Reset()
        {
            _Reset();

            events.ScheduleEvent(EVENT_AMPLIFY_MAGIC, urand(20,25) * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_ENERGIZE_CORES_VISUAL, 5000);

            events.ScheduleEvent(EVENT_CALL_AZURE, urand(15,30) * IN_MILLISECONDS);

            firstCoreEnergize = false;
            coreEnergizeOrientation = 0.0f;
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (!players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* pPlayer = itr->getSource();
                        if (pPlayer)
                            pPlayer->ExitVehicle();
                    }
                }

            Talk(SAY_AGGRO);
        }

        float GetCoreEnergizeOrientation()
        {
            return coreEnergizeOrientation;
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ENERGIZE_CORES:
                        DoCast(me,SPELL_ENERGIZE_CORES);
                        events.CancelEvent(EVENT_ENERGIZE_CORES);
                        break;
                    case EVENT_ENERGIZE_CORES_VISUAL:
                        if (!firstCoreEnergize)
                        {
                            coreEnergizeOrientation = me->GetOrientation();
                            firstCoreEnergize = true;
                        } else
                            coreEnergizeOrientation = MapManager::NormalizeOrientation(coreEnergizeOrientation - 2.0f);

                        DoCast(me,SPELL_ENERGIZE_CORES_VISUAL);
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES_VISUAL, 5000);
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES, 4000);
                        break;
                    case EVENT_CALL_AZURE:
                        DoCast(me,SPELL_CALL_AZURE_RING_CAPTAIN);
                        Talk(SAY_AZURE);
                        Talk(SAY_AZURE_EMOTE);
                        events.ScheduleEvent(EVENT_CALL_AZURE, urand(20,25) * IN_MILLISECONDS);
                        break;
                    case EVENT_AMPLIFY_MAGIC:
                        DoCast(me->getVictim(),SPELL_CALL_AMPLIFY_MAGIC);
                        events.ScheduleEvent(EVENT_AMPLIFY_MAGIC, urand(17,20) * IN_MILLISECONDS);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();

            Talk(SAY_DEATH);
        }
    private:
        bool firstCoreEnergize;
        float coreEnergizeOrientation;
    };
};

class npc_azure_ring_captain : public CreatureScript
{
    public:
        npc_azure_ring_captain() : CreatureScript("npc_azure_ring_captain") { }

        struct npc_azure_ring_captainAI : public ScriptedAI
        {
            npc_azure_ring_captainAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                targetGUID = 0;

                me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING | MOVEMENTFLAG_FLYING);
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void SpellHitTarget(Unit* target, SpellEntry const* spell)
            {
                if (spell->Id == SPELL_ICE_BEAM)
                {
                    target->CastSpell(target,SPELL_SUMMON_ARCANE_BEAM,true);
                    me->DespawnOrUnsummon();
                }
            }

            void UpdateAI(const uint32 /*diff*/)
            {
                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE ||
                    id != ACTION_CALL_DRAGON_EVENT)
                    return;

                me->GetMotionMaster()->MoveIdle();

                if (Unit* target = ObjectAccessor::GetUnit(*me,targetGUID))
                    DoCast(target,SPELL_ICE_BEAM);
            }

            void DoAction(int32 const action)
            {
                switch (action)
                {
                   case ACTION_CALL_DRAGON_EVENT:
                        if (instance)
                        {
                            if (Creature* varos = ObjectAccessor::GetCreature(*me,instance->GetData64(DATA_VAROS)))
                            {
                                if (Unit* victim = varos->AI()->SelectTarget(SELECT_TARGET_RANDOM,0))
                                {
                                    me->SetReactState(REACT_PASSIVE);
                                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                    me->GetMotionMaster()->MovePoint(ACTION_CALL_DRAGON_EVENT,victim->GetPositionX(),victim->GetPositionY(),victim->GetPositionZ() + 20.0f);
                                    targetGUID = victim->GetGUID();
                                }
                            }
                        }
                        break;
                }
           }

        private:
            uint64 targetGUID;
            InstanceScript* instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_azure_ring_captainAI(creature);
        }
};

class spell_varos_centrifuge_shield : public SpellScriptLoader
{
    public:
        spell_varos_centrifuge_shield() : SpellScriptLoader("spell_varos_centrifuge_shield") { }

        class spell_varos_centrifuge_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_varos_centrifuge_shield_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster()->ToCreature())
                    return;

                if (GetCaster()->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15|UNIT_FLAG_PASSIVE|UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_UNK_6))
                {
                    GetCaster()->ToCreature()->SetReactState(REACT_PASSIVE);
                    GetCaster()->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15|UNIT_FLAG_PASSIVE|UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_UNK_6);
                }
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster()->ToCreature())
                    return;

                GetCaster()->ToCreature()->SetReactState(REACT_AGGRESSIVE);
                GetCaster()->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15|UNIT_FLAG_PASSIVE|UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_UNK_6);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_varos_centrifuge_shield_AuraScript::OnRemove, EFFECT_0,SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectApply += AuraEffectApplyFn(spell_varos_centrifuge_shield_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_varos_centrifuge_shield_AuraScript();
        }
};

class spell_varos_energize_core_area_enemy : public SpellScriptLoader
{
    public:
        spell_varos_energize_core_area_enemy() : SpellScriptLoader("spell_varos_energize_core_area_enemy") {}

        class spell_varos_energize_core_area_enemySpellScript : public SpellScript
        {
            PrepareSpellScript(spell_varos_energize_core_area_enemySpellScript)

            void FilterTargets(std::list<Unit*>& targetList)
            {
                Creature* varos = GetCaster()->ToCreature();
                if (!varos)
                    return;

                if (varos->GetEntry() != NPC_VAROS)
                    return;

                float orientation = CAST_AI(boss_varos::boss_varosAI,varos->AI())->GetCoreEnergizeOrientation();

                for (std::list<Unit*>::iterator itr = targetList.begin() ; itr != targetList.end();)
                {
                    Position pos;
                    (*itr)->GetPosition(&pos);

                    float angle = varos->GetAngle((*itr)->GetPositionX(),(*itr)->GetPositionY());
                    float diff = fabs(orientation - angle);

                    if (diff > 1.0f)
                        itr = targetList.erase(itr);
                    else
                        ++itr;
                }
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_varos_energize_core_area_enemySpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_AREA_ENEMY_SRC);
            }
        };

        SpellScript *GetSpellScript() const
        {
            return new spell_varos_energize_core_area_enemySpellScript();
        }
};

class spell_varos_energize_core_area_entry : public SpellScriptLoader
{
    public:
        spell_varos_energize_core_area_entry() : SpellScriptLoader("spell_varos_energize_core_area_entry") {}

        class spell_varos_energize_core_area_entrySpellScript : public SpellScript
        {
            PrepareSpellScript(spell_varos_energize_core_area_entrySpellScript)

            void FilterTargets(std::list<Unit*>& targetList)
            {
                Creature* varos = GetCaster()->ToCreature();
                if (!varos)
                    return;

                if (varos->GetEntry() != NPC_VAROS)
                    return;

                float orientation = CAST_AI(boss_varos::boss_varosAI,varos->AI())->GetCoreEnergizeOrientation();

                for (std::list<Unit*>::iterator itr = targetList.begin() ; itr != targetList.end();)
                {
                    Position pos;
                    (*itr)->GetPosition(&pos);

                    float angle = varos->GetAngle((*itr)->GetPositionX(),(*itr)->GetPositionY());
                    float diff = fabs(orientation - angle);

                    if (diff > 1.0f)
                        itr = targetList.erase(itr);
                    else
                        ++itr;
                }
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_varos_energize_core_area_entrySpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_AREA_ENTRY_SRC);
            }
        };

        SpellScript *GetSpellScript() const
        {
            return new spell_varos_energize_core_area_entrySpellScript();
        }
};

void AddSC_boss_varos()
{
    new boss_varos();
    new npc_azure_ring_captain();
    new spell_varos_centrifuge_shield();
    new spell_varos_energize_core_area_enemy();
    new spell_varos_energize_core_area_entry();
}