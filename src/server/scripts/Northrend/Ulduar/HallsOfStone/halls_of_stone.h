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

#ifndef DEF_HALLS_OF_STONE_H
#define DEF_HALLS_OF_STONE_H

enum Data
{
    DATA_KRYSTALLUS_EVENT,
    DATA_MAIDEN_OF_GRIEF_EVENT,
    DATA_SJONNIR_EVENT,
    DATA_BRANN_EVENT
};

enum Data64
{
    DATA_KRYSTALLUS,
    DATA_MAIDEN_OF_GRIEF,
    DATA_SJONNIR,
    DATA_KADDRAK,
    DATA_MARNAK,
    DATA_ABEDNEUM,
    DATA_GO_TRIBUNAL_CONSOLE,
    DATA_GO_KADDRAK,
    DATA_GO_MARNAK,
    DATA_GO_ABEDNEUM,
    DATA_GO_SKY_FLOOR,
    DATA_SJONNIR_DOOR,
    DATA_MAIDEN_DOOR
};

enum Creatures
{
    CREATURE_MAIDEN     = 27975,
    CREATURE_KRYSTALLUS = 27977,
    CREATURE_SJONNIR    = 27978,
    CREATURE_MARNAK     = 30897,
    CREATURE_KADDRAK    = 30898,
    CREATURE_ABEDNEUM   = 30899,
    CREATURE_BRANN      = 28070
};

enum GameObjects
{
    GO_ABEDNEUM            = 191669,
    GO_MARNAK              = 191670,
    GO_KADDRAK             = 191671,
    GO_MAIDEN_DOOR         = 191292,
    GO_BRANN_DOOR          = 191295,
    GO_SJONNIR_DOOR        = 191296,
    GO_TRIBUNAL_CONSOLE    = 193907,
    GO_TRIBUNAL_CHEST      = 190586,
    GO_TRIBUNAL_CHEST_HERO                                 = 193996,
    GO_TRIBUNAL_SKYROOM_FLOOR                              = 191527
};

#endif