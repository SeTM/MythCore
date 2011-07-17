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

#include "GuardAI.h"
#include "Errors.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "World.h"
#include "CreatureAIImpl.h"

int GuardAI::Permissible(const Creature* creature)
{
    if (creature->isGuard())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

GuardAI::GuardAI(Creature* creature) : ScriptedAI(creature), i_victimGuid(0), i_state(STATE_NORMAL), i_tracker(TIME_INTERVAL_LOOK)
{
}

bool GuardAI::CanSeeAlways(WorldObject const* obj)
{
    if (!obj->isType(TYPEMASK_UNIT))
        return false;

    std::list<HostileReference *> t_list = me->getThreatManager().getThreatList();
    for (std::list<HostileReference *>::const_iterator itr = t_list.begin(); itr!= t_list.end(); ++itr)
    {
        if (Unit* unit = Unit::GetUnit(*me, (*itr)->getUnitGuid()))
            if (unit == obj)
                return true;
    }

    return false;
}

void GuardAI::MoveInLineOfSight(Unit* unit)
{
    // Ignore Z for flying creatures
    if (!me->canFly() && me->GetDistanceZ(unit) > CREATURE_Z_ATTACK_RANGE)
        return;

    if (!me->getVictim() && me->canAttack(unit) &&
        (unit->IsHostileToPlayers() || me->IsHostileTo(unit) /*|| u->getVictim() && me->IsFriendlyTo(u->getVictim())*/) &&
        unit->isInAccessiblePlaceFor(me))
    {
        float attackRadius = me->GetAttackDistance(unit);
        if (me->IsWithinDistInMap(unit, attackRadius))
        {
            //Need add code to let guard support player
            AttackStart(unit);
            //u->RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
        }
    }
}

void GuardAI::EnterEvadeMode()
{
    if (!me->isAlive())
    {
        sLog->outStaticDebug("Creature stopped attacking because he is dead [guid=%u]", me->GetGUIDLow());
        me->GetMotionMaster()->MoveIdle();

        i_state = STATE_NORMAL;

        i_victimGuid = 0;
        me->CombatStop(true);
        me->DeleteThreatList();
        return;
    }

    Unit* victim = ObjectAccessor::GetUnit(*me, i_victimGuid);

    if (!victim)
    {
        sLog->outStaticDebug("Creature stopped attacking because victim does not exist [guid=%u]", me->GetGUIDLow());
    }
    else if (!victim ->isAlive())
    {
        sLog->outStaticDebug("Creature stopped attacking because victim is dead [guid=%u]", me->GetGUIDLow());
    }
    else if (victim ->HasStealthAura())
    {
        sLog->outStaticDebug("Creature stopped attacking because victim is using stealth [guid=%u]", me->GetGUIDLow());
    }
    else if (victim ->isInFlight())
    {
        sLog->outStaticDebug("Creature stopped attacking because victim is flying away [guid=%u]", me->GetGUIDLow());
    }
    else
    {
        sLog->outStaticDebug("Creature stopped attacking because victim outran him [guid=%u]", me->GetGUIDLow());
    }

    me->RemoveAllAuras();
    me->DeleteThreatList();
    i_victimGuid = 0;
    me->CombatStop(true);
    i_state = STATE_NORMAL;

    // Remove TargetedMovementGenerator from MotionMaster stack list, and add HomeMovementGenerator instead
    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == TARGETED_MOTION_TYPE)
        me->GetMotionMaster()->MoveTargetedHome();
}

void GuardAI::UpdateAI(const uint32 /*diff*/)
{
    // update i_victimGuid if me->getVictim() !=0 and changed
    if (!UpdateVictim())
        return;
    if (me->getVictim())
        i_victimGuid = me->getVictim()->GetGUID();
    else
    {
        i_victimGuid = 0;
        return;
    }

    if (me->isAttackReady())
    {
        if (me->IsWithinMeleeRange(me->getVictim()))
        {
            me->AttackerStateUpdate(me->getVictim());
            me->resetAttackTimer();
        }
    }
}

void GuardAI::JustDied(Unit* killer)
{
    if (Player* pkiller = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
        me->SendZoneUnderAttackMessage(pkiller);
}
