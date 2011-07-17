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

#ifndef DEF_PIT_OF_SARON_H
#define DEF_PIT_OF_SARON_H

#define PoSScriptName "instance_pit_of_saron"
#define MAX_ENCOUNTER 3

enum DataTypes
{
    // Encounter states and GUIDs
    DATA_GARFROST           = 0,
    DATA_ICK                = 1,
    DATA_TYRANNUS           = 2,

    // GUIDs
    DATA_RIMEFANG           = 3,
    DATA_KRICK              = 4,
    DATA_JAINA_SYLVANAS_1   = 5,    // GUID of either Jaina or Sylvanas part 1, depending on team, as it's the same spawn.
    DATA_JAINA_SYLVANAS_2   = 6,    // GUID of either Jaina or Sylvanas part 2, depending on team, as it's the same spawn.
    DATA_TYRANNUS_EVENT     = 7,
    DATA_TEAM_IN_INSTANCE   = 8,
    DATA_SINDRAGOSA         = 9,
    DATA_VICTUS_OR_GORKUN_FREED = 10,
    DATA_TYRANNUS_EVENT_PRE_INTRO = 11,
};

enum CreatureIds
{
    NPC_GARFROST                                = 36494,
    NPC_KRICK                                   = 36477,
    NPC_ICK                                     = 36476,
    NPC_TYRANNUS                                = 36658,
    NPC_RIMEFANG                                = 36661,

    NPC_TYRANNUS_EVENTS                         = 36794,
    NPC_SYLVANAS_PART1                          = 36990,
    NPC_SYLVANAS_PART2                          = 38189,
    NPC_JAINA_PART1                             = 36993,
    NPC_JAINA_PART2                             = 38188,
    NPC_KILARA                                  = 37583,
    NPC_ELANDRA                                 = 37774,
    NPC_KORALEN                                 = 37779,
    NPC_KORLAEN                                 = 37582,
    NPC_CHAMPION_1_HORDE                        = 37584,
    NPC_CHAMPION_2_HORDE                        = 37587,
    NPC_CHAMPION_3_HORDE                        = 37588,
    NPC_CHAMPION_1_ALLIANCE                     = 37496,
    NPC_CHAMPION_2_ALLIANCE                     = 37497,
    NPC_NECROLYTE                               = 36788,
    NPC_HUNGERING_GHOUL                         = 37711,

    NPC_HORDE_SLAVE_1                           = 36770,
    NPC_HORDE_SLAVE_2                           = 36771,
    NPC_HORDE_SLAVE_3                           = 36772,
    NPC_HORDE_SLAVE_4                           = 36773,
    NPC_ALLIANCE_SLAVE_1                        = 36764,
    NPC_ALLIANCE_SLAVE_2                        = 36765,
    NPC_ALLIANCE_SLAVE_3                        = 36766,
    NPC_ALLIANCE_SLAVE_4                        = 36767,
    NPC_FREED_ALLIANCE_SLAVE1                   = 37576,
    NPC_FREED_ALLIANCE_SLAVE2                   = 37575,
    NPC_FREED_ALLIANCE_SLAVE3                   = 37572,
    NPC_FREED_HORDE_SLAVE1                      = 37579,
    NPC_FREED_HORDE_SLAVE2                      = 37578,
    NPC_FREED_HORDE_SLAVE3                      = 37577,
    NPC_SINDRAGOSA                              = 37755,
    NPC_MARTIN_VICTUS_FREED                     = 37580,
    NPC_MARTIN_VICTUS                           = 37591,
    NPC_GORKUN_IRONSKULL_FREED                  = 37581,
    NPC_GORKUN_IRONSKULL                        = 37592,

    NPC_FORGEMASTER_STALKER                     = 36495,
    NPC_EXPLODING_ORB                           = 36610,
    NPC_YMIRJAR_DEATHBRINGER                    = 36892,
    NPC_ICY_BLAST                               = 36731
};

enum GameObjectIds
{
    GO_SARONITE_ROCK                            = 196485,
    GO_ICE_WALL                                 = 201885,
};

#endif