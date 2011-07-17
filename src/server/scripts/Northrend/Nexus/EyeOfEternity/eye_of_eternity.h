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

#ifndef DEF_EYE_OF_ETERNITY_H
#define DEF_EYE_OF_ETERNITY_H

enum InstanceData
{
    DATA_MALYGOS_EVENT,
    MAX_ENCOUNTER,

    DATA_VORTEX_HANDLING,
    DATA_POWER_SPARKS_HANDLING
};

enum InstanceData64
{
    DATA_TRIGGER,
    DATA_MALYGOS,
    DATA_PLATFORM
};

enum InstanceNpcs
{
    NPC_MALYGOS             = 28859,
    NPC_VORTEX_TRIGGER      = 30090,
    NPC_PORTAL_TRIGGER      = 30118,
    NPC_POWER_SPARK         = 30084,
    NPC_HOVER_DISK_MELEE    = 30234,
    NPC_HOVER_DISK_CASTER   = 30248,
    NPC_ARCANE_OVERLOAD     = 30282,
    NPC_WYRMREST_SKYTALON   = 30161,
    NPC_ALEXSTRASZA         = 32295
};

enum InstanceGameObjects
{
    GO_NEXUS_RAID_PLATFORM      = 193070,
    GO_EXIT_PORTAL              = 193908,
    GO_FOCUSING_IRIS            = 193958,
    GO_ALEXSTRASZA_S_GIFT       = 193905,
    GO_ALEXSTRASZA_S_GIFT_2     = 193967
};

enum InstanceEvents
{
    EVENT_FOCUSING_IRIS = 20711
};

enum InstanceSpells
{
    SPELL_VORTEX_4          = 55853, // damage | used to enter to the vehicle
    SPELL_VORTEX_5          = 56263, // damage | used to enter to the vehicle
    SPELL_PORTAL_OPENED     = 61236,
    SPELL_RIDE_RED_DRAGON   = 56071,
};

#endif
