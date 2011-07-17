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

enum Spells
{
    SPELL_ARCANE_SHIELD                           = 53813,
    SPELL_EMPOWERED_ARCANE_EXPLOSION              = 51110,
    SPELL_EMPOWERED_ARCANE_EXPLOSION_2            = 59377,
    SPELL_FROSTBOMB                               = 51103,
    SPELL_SUMMON_MENAGERIE                        = 50476,
    SPELL_SUMMON_MENAGERIE_2                      = 50495,
    SPELL_SUMMON_MENAGERIE_3                      = 50496,
    SPELL_TELEPORT                                = 51112,
    SPELL_TIME_BOMB                               = 51121,
    SPELL_TIME_BOMB_2                             = 59376
};

enum Yells
{
    SAY_AGGRO_1                                   = -1578000,
    SAY_AGGRO_2                                   = -1578001,
    SAY_AGGRO_3                                   = -1578002,
    SAY_AGGRO_4                                   = -1578003,
    SAY_TELEPORT                                  = -1578004,
};

enum eCreature
{
    NPC_PHANTASMAL_CLOUDSCRAPER                   = 27645,
    NPC_PHANTASMAL_MAMMOTH                        = 27642,
    NPC_PHANTASMAL_WOLF                           = 27644,

    NPC_PHANTASMAL_AIR                            = 27650,
    NPC_PHANTASMAL_FIRE                           = 27651,
    NPC_PHANTASMAL_WATER                          = 27653,

    NPC_PHANTASMAL_MURLOC                         = 27649,
    NPC_PHANTASMAL_NAGAL                          = 27648,
    NPC_PHANTASMAL_OGRE                           = 27647
};

struct Summons
{
    uint32 entry[4];
};

static Summons Group[]=
{
    { {NPC_PHANTASMAL_CLOUDSCRAPER, NPC_PHANTASMAL_CLOUDSCRAPER, NPC_PHANTASMAL_MAMMOTH, NPC_PHANTASMAL_WOLF} },
    { {NPC_PHANTASMAL_AIR, NPC_PHANTASMAL_AIR, NPC_PHANTASMAL_WATER, NPC_PHANTASMAL_FIRE} },
    { {NPC_PHANTASMAL_OGRE, NPC_PHANTASMAL_OGRE, NPC_PHANTASMAL_NAGAL, NPC_PHANTASMAL_MURLOC} }
};

static uint32 TeleportSpells[]=
{
    SPELL_SUMMON_MENAGERIE,SPELL_SUMMON_MENAGERIE_2,SPELL_SUMMON_MENAGERIE_3
};

static int32 SayAggro[]=
{
    SAY_AGGRO_1,SAY_AGGRO_2,SAY_AGGRO_3,SAY_AGGRO_4
};

class boss_urom : public CreatureScript
{
public:
    boss_urom(): CreatureScript("boss_urom") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_uromAI (pCreature);
    }

    struct boss_uromAI : public BossAI
    {
        boss_uromAI(Creature* creature) : BossAI(creature,DATA_UROM_EVENT) {}

        void Reset()
        {
            if (instance->GetBossState(DATA_VAROS_EVENT) != DONE)
                DoCast(SPELL_ARCANE_SHIELD);

            _Reset();

            if (instance->GetData(DATA_UROM_PLATAFORM) == 0)
            {
                for (uint8 i = 0; i < 3; i++)
                    group[i] = 0;
            }

            x = 0.0f;
            y = 0.0f;
            canCast = false;
            canGoBack = false;

            me->GetMotionMaster()->MoveIdle();

            teleportTimer = urand(30000,35000);
            arcaneExplosionTimer = 9000;
            castArcaneExplosionTimer = 2000;
            frostBombTimer = urand(5000,8000);
            timeBombTimer = urand(20000,25000);
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();

            SetGroups();
            SummonGroups();
            CastTeleport();

            if (instance->GetData(DATA_UROM_PLATAFORM) != 3)
                instance->SetData(DATA_UROM_PLATAFORM,instance->GetData(DATA_UROM_PLATAFORM)+1);
        }

        void AttackStart(Unit* pWho)
        {
            if (!pWho)
                return;

            if (me->GetPositionZ() > 518.63f)
                DoStartNoMovement(pWho);

            if (me->GetPositionZ() < 518.63f)
            {
                if (me->Attack(pWho, true))
                {
                    DoScriptText(SayAggro[3],me);

                    me->SetInCombatWith(pWho);
                    pWho->SetInCombatWith(me);

                    me->GetMotionMaster()->MoveChase(pWho, 0,0);
                }
            }
        }

        void SetGroups()
        {
            if (!instance || instance->GetData(DATA_UROM_PLATAFORM) != 0)
                return;

            while (group[0] == group[1] || group[0] == group[2] || group[1] == group[2])
            {
                for (uint8 i = 0; i < 3; i++)
                    group[i] = urand(0,2);
            }
        }

        void SetPosition(uint8 i)
        {
            switch(i)
            {
                case 0:
                    x = me->GetPositionX() + 4;
                    y = me->GetPositionY() - 4;
                    break;
                case 1:
                    x = me->GetPositionX() + 4;
                    y = me->GetPositionY() + 4;
                    break;
                case 2:
                    x = me->GetPositionX() - 4;
                    y = me->GetPositionY() + 4;
                    break;
                case 3:
                    x = me->GetPositionX() - 4;
                    y = me->GetPositionY() - 4;
                    break;
                default:
                    break;
            }
        }

        void SummonGroups()
        {
            if (!instance || instance->GetData(DATA_UROM_PLATAFORM) > 2)
                return;

            for (uint8 i = 0; i < 4 ; i++)
            {
                SetPosition(i);
                me->SummonCreature(Group[group[instance->GetData(DATA_UROM_PLATAFORM)]].entry[i],x,y,me->GetPositionZ(),me->GetOrientation());
            }
        }

        void CastTeleport()
        {
            if (!instance || instance->GetData(DATA_UROM_PLATAFORM) > 2)
                return;

            DoScriptText(SayAggro[instance->GetData(DATA_UROM_PLATAFORM)],me);
            DoCast(TeleportSpells[instance->GetData(DATA_UROM_PLATAFORM)]);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (!instance || instance->GetData(DATA_UROM_PLATAFORM) < 2)
                return;

            if (teleportTimer <= uiDiff)
            {
                me->InterruptNonMeleeSpells(false);
                DoScriptText(SAY_TELEPORT,me);
                me->GetMotionMaster()->MoveIdle();
                DoCast(SPELL_TELEPORT);
                teleportTimer = urand(30000,35000);

            } else teleportTimer -= uiDiff;

            if (canCast && !me->FindCurrentSpellBySpellId(SPELL_EMPOWERED_ARCANE_EXPLOSION))
            {
                if (castArcaneExplosionTimer <= uiDiff)
                {
                    canCast = false;
                    canGoBack = true;
                    DoCastAOE(SPELL_EMPOWERED_ARCANE_EXPLOSION);
                    castArcaneExplosionTimer = 2000;
                } else castArcaneExplosionTimer -= uiDiff;
            }

            if (canGoBack)
            {
                if (arcaneExplosionTimer <= uiDiff)
                {
                    Position pPos;
                    me->getVictim()->GetPosition(&pPos);

                    me->NearTeleportTo(pPos.GetPositionX(),pPos.GetPositionY(),pPos.GetPositionZ(),pPos.GetOrientation());
                    me->GetMotionMaster()->MoveChase(me->getVictim(),0,0);
                    me->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);

                    canCast = false;
                    canGoBack = false;
                    arcaneExplosionTimer = 9000;
                } else arcaneExplosionTimer -= uiDiff;
            }

            if (!me->IsNonMeleeSpellCasted(false, true, true))
            {
                if (frostBombTimer <= uiDiff)
                {
                    DoCastVictim(SPELL_FROSTBOMB);
                    frostBombTimer = urand(5000,8000);
                } else frostBombTimer -= uiDiff;

                if (timeBombTimer <= uiDiff)
                {
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM))
                        DoCast(pUnit,SPELL_TIME_BOMB);

                    timeBombTimer = urand(20000,25000);
                } else timeBombTimer -= uiDiff;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
        }

        void LeaveCombat()
        {
            me->RemoveAllAuras();
            me->CombatStop(false);
            me->DeleteThreatList();
        }

        void SpellHit(Unit* /*pCaster*/, const SpellEntry* pSpell)
        {
            switch(pSpell->Id)
            {
                case SPELL_SUMMON_MENAGERIE:
                    me->SetHomePosition(968.66f,1042.53f,527.32f,0.077f);
                    LeaveCombat();
                    break;
                case SPELL_SUMMON_MENAGERIE_2:
                    me->SetHomePosition(1164.02f,1170.85f,527.321f,3.66f);
                    LeaveCombat();
                    break;
                case SPELL_SUMMON_MENAGERIE_3:
                    me->SetHomePosition(1118.31f,1080.377f,508.361f,4.25f);
                    LeaveCombat();
                    break;
                case SPELL_TELEPORT:
                    me->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
                    canCast = true;
                    break;
                default:
                    break;
            }
        }
        private:
            float x,y;

            bool canCast;
            bool canGoBack;

            uint8 group[3];

            uint32 teleportTimer;
            uint32 arcaneExplosionTimer;
            uint32 castArcaneExplosionTimer;
            uint32 frostBombTimer;
            uint32 timeBombTimer;
    };
};

void AddSC_boss_urom()
{
    new boss_urom();
}