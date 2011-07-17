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

#ifndef OUTDOOR_PVP_WG_
#define OUTDOOR_PVP_WG_

#include "OutdoorPvP.h"
#include "BattlegroundMgr.h"
#include "Player.h"

#define ZONE_DALARAN             4395
#define ZONE_WINTERGRASP         4197
#define POS_X_CENTER             5100
#define MAX_VEHICLE_PER_WORKSHOP    4

const uint32 WintergraspFaction[3] = {1802, 1801, 35};
const uint32 WG_MARK_OF_HONOR = 43589;
const uint32 VehNumWorldState[2] = {3680,3490};
const uint32 MaxVehNumWorldState[2] = {3681,3491};
const uint32 ClockWorldState[2] = {3781,4354};
const uint8 CapturePointArtKit[3] = {2, 1, 21};
char const *fmtstring(char const *format, ...);
const Team TeamId2Team[3] = {ALLIANCE, HORDE, TEAM_OTHER};

enum OutdoorPvPWGSpell
{
    SPELL_RECRUIT                                = 37795,
    SPELL_CORPORAL                               = 33280,
    SPELL_LIEUTENANT                             = 55629,
    SPELL_TENACITY                               = 58549,
    SPELL_TENACITY_VEHICLE                       = 59911,
    SPELL_TOWER_CONTROL                          = 62064,
    SPELL_SPIRITUAL_IMMUNITY                     = 58729,
    SPELL_VICTORY_REWARD                         = 56902,
    SPELL_DEFEAT_REWARD                          = 58494,
    SPELL_DAMAGED_TOWER                          = 59135,
    SPELL_DESTROYED_TOWER                        = 59136,
    SPELL_DAMAGED_BUILDING                       = 59201,
    SPELL_INTACT_BUILDING                        = 59203,
    SPELL_TELEPORT_ALLIENCE_CAMP                 = 58632,
    SPELL_TELEPORT_HORDE_CAMP                    = 58633,
    SPELL_TELEPORT_FORTRESS                      = 59096,
    SPELL_TELEPORT_DALARAN                       = 53360,
    SPELL_VICTORY_AURA                           = 60044
};

const uint16 GameEventWintergraspDefender[2] = {50, 51};

enum OutdoorPvP_WG_Sounds
{
    OutdoorPvP_WG_SOUND_KEEP_CLAIMED            = 8192,
    OutdoorPvP_WG_SOUND_KEEP_CAPTURED_ALLIANCE  = 8173,
    OutdoorPvP_WG_SOUND_KEEP_CAPTURED_HORDE     = 8213,
    OutdoorPvP_WG_SOUND_KEEP_ASSAULTED_ALLIANCE = 8212,
    OutdoorPvP_WG_SOUND_KEEP_ASSAULTED_HORDE    = 8174,
    OutdoorPvP_WG_SOUND_NEAR_VICTORY            = 8456,
    OutdoorPvP_WG_SOUND_HORDE_WINS              = 8454,
    OutdoorPvP_WG_SOUND_ALLIANCE_WINS           = 8455,
    OutdoorPvP_WG_SOUND_WORKSHOP_Horde          = 6205,
    OutdoorPvP_WG_SOUND_WORKSHOP_ALLIANCE       = 6298,
    OutdoorPvP_WG_HORDE_CAPTAIN                 = 8333,
    OutdoorPvP_WG_ALLIANCE_CAPTAIN              = 8232,
    OutdoorPvP_WG_SOUND_START_BATTLE            = 3439
};

enum DataId
{
     DATA_ENGINEER_DIE
};

enum OutdoorPvP_WG_KeepStatus
{
    OutdoorPvP_WG_KEEP_TYPE_NEUTRAL             = 0,
    OutdoorPvP_WG_KEEP_TYPE_CONTESTED           = 1,
    OutdoorPvP_WG_KEEP_STATUS_ALLY_CONTESTED    = 1,
    OutdoorPvP_WG_KEEP_STATUS_HORDE_CONTESTED   = 2,
    OutdoorPvP_WG_KEEP_TYPE_OCCUPIED            = 3,
    OutdoorPvP_WG_KEEP_STATUS_ALLY_OCCUPIED     = 3,
    OutdoorPvP_WG_KEEP_STATUS_HORDE_OCCUPIED    = 4
};

enum OutdoorPVPWGStatus
{
    WORLDSTATE_WINTERGRASP_WARTIME            = 31001,
    WORLDSTATE_WINTERGRASP_TIMER              = 31002,
    WORLDSTATE_WINTERGRASP_DEFENDERS          = 31003,
    WORLDSTATE_WINTERGRASP_CONTROLING_FACTION = 31004,
    WORLDSTATE_VALUE_COUNT,
};

enum OutdoorPvPWGCreType
{
    CREATURE_OTHER,
    CREATURE_SIEGE_VEHICLE,
    CREATURE_TURRET,
    CREATURE_ENGINEER,
    CREATURE_GUARD,
    CREATURE_SPECIAL,
    CREATURE_SPIRIT_GUIDE,
    CREATURE_SPIRIT_HEALER,
    CREATURE_QUESTGIVER
};

enum OutdoorPvPWGBuildingType
{
    BUILDING_WALL,
    BUILDING_WORKSHOP,
    BUILDING_TOWER
};

enum OutdoorPvPWGDamageState
{
    DAMAGE_INTACT,
    DAMAGE_DAMAGED,
    DAMAGE_DESTROYED
};

typedef uint32 TeamPair[2];

enum OutdoorPvPWGQuest
{
    A_VICTORY_IN_WG                              = 13181,
    H_VICTORY_IN_WG                              = 13183,
    CRE_PVP_KILL                                 = 31086,
    CRE_PVP_KILL_V                               = 31093,
    TOWER_PVP_DESTROYED                          = 35074
};

enum OutdoorPvPWGCreEntry
{
    CRE_ENG_A                                    = 30499,
    CRE_ENG_H                                    = 30400,
    CRE_SPI_A                                    = 31842,
    CRE_SPI_H                                    = 31841
};

const TeamPair OutdoorPvPWGCreEntryPair[] =
{
    {32307, 32308},
    {30739, 30740},
    {32296, 32294},
    {39173, 39172},
    {32615, 32626},
    {0,0}
};

const TeamPair OutdoorPvPWGGODisplayPair[] =
{
    {5651, 5652},
    {8256, 8257},
    {0,0}
};

const uint32 AreaPOIIconId[3][3] = {{7,8,9},{4,5,6},{1,2,3}};
typedef std::list<const AreaPOIEntry *> AreaPOIList;

struct BuildingState
{
    explicit BuildingState(uint32 _worldState, TeamId _team, bool asDefault)
         : worldState(_worldState), health(0)
         , defaultTeam(asDefault ? _team : OTHER_TEAM(_team)), damageState(DAMAGE_INTACT), team(_team)
         , building(NULL), graveTeam(NULL), type(BUILDING_WALL) {}
    uint32 worldState;
    uint32 health;
    TeamId defaultTeam;
    OutdoorPvPWGDamageState damageState;
    TeamId team;
    GameObject *building;
    uint32 *graveTeam;
    OutdoorPvPWGBuildingType type;

    void SendUpdate(Player* player) const
    {
        player->SendUpdateWorldState(worldState, AreaPOIIconId[team][damageState]);
    }

    void FillData(WorldPacket &data) const
    {
        data << worldState << AreaPOIIconId[team][damageState];
    }

    TeamId GetTeam() const { return team; }
    void SetTeam(TeamId t)
    {
        team = t;
        if(graveTeam)
            if (uint32 newTeam = TeamId2Team[t])
                *graveTeam = newTeam;
    }
};

typedef std::map<uint32, uint32> TeamPairMap;
class OPvPCapturePointWG;

class OutdoorPvPWG : public OutdoorPvP
{
protected:
    typedef std::map<uint32, BuildingState *> BuildingStateMap;
    typedef std::set<Creature*> CreatureSet;
    typedef std::set<GameObject*> GameObjectSet;
    typedef std::map<std::pair<uint32, bool>, Position> QuestGiverPositionMap;
    typedef std::map<uint32, Creature*> QuestGiverMap;

public:
    OutdoorPvPWG();
    bool SetupOutdoorPvP();
    int TeamIDsound;
    uint32 GetCreatureEntry(uint32 guidlow, const CreatureData *data);
    void OnCreatureCreate(Creature* creature);
    void OnGameObjectCreate(GameObject *go);
    void OnCreatureRemove(Creature* creature);
    void OnGameObjectRemove(GameObject *go);
    void ProcessEvent(GameObject *obj, uint32 eventId);
    void HandlePlayerEnterZone(Player* plr, uint32 zone);
    void HandlePlayerLeaveZone(Player* plr, uint32 zone);
    void HandlePlayerResurrects(Player* plr, uint32 zone);
    void HandleKill(Player* killer, Unit* victim);
    bool Update(uint32 diff);
    void BroadcastStateChange(BuildingState *state) const;
    uint32 GetData(uint32 id);
    void ModifyWorkshopCount(TeamId team, bool add);
    uint32 GetTimer() const { return m_timer / 1000; };
    bool isWarTime() const { return m_wartime; };
    void setTimer(uint32 timer) { if (timer >= 0) m_timer = timer; };
    uint32 GetNumPlayersA() const { return m_players[TEAM_ALLIANCE].size(); };
    uint32 GetNumPlayersH() const { return m_players[TEAM_HORDE].size(); };
    TeamId getDefenderTeam() const { return m_defender; };
    TeamId getAttackerTeam() const { return OTHER_TEAM(m_defender); };
    void forceChangeTeam();
    void forceStopBattle();
    void forceStartBattle();

    void SendAreaSpiritHealerQueryOpcode(Player* pl, const uint64& guid);
    void AddPlayerToResurrectQueue(uint64 npc_guid, uint64 player_guid);
    void RemovePlayerFromResurrectQueue(uint64 player_guid);
    void RelocateAllianceDeadPlayers(Creature* cr);
    void RelocateHordeDeadPlayers(Creature* cr);

    void SendInitWorldStatesTo(Player* player = NULL) const;
    uint32 m_timer;
    bool m_changeAlly;
    bool m_changeHorde;

protected:
    std::vector<uint64> m_ResurrectQueue;
    uint32 m_LastResurrectTime;

    std::map<uint64, std::vector<uint64> >  m_ReviveQueue;

    uint32 GetLastResurrectTime() const { return m_LastResurrectTime; }
    uint32 GetReviveQueueSize() const { return m_ReviveQueue.size(); }

    TeamId m_defender;
    int32 m_tenacityStack;

    BuildingStateMap m_buildingStates;
    BuildingState *m_gate;

    CreatureSet m_creatures;
    CreatureSet m_vehicles[2];
    GameObjectSet m_gobjects;
    GameObjectSet m_gobjectsDestroyable;
    QuestGiverMap m_questgivers;

    TeamPairMap m_creEntryPair, m_goDisplayPair;
    QuestGiverPositionMap m_qgPosMap;

    bool m_wartime;
    bool m_changeDefender;
    uint32 m_clock[2];
    uint32 m_workshopCount[2];
    uint32 m_towerDestroyedCount[2];
    uint32 m_towerDamagedCount[2];
    uint32 m_WSSaveTimer;

    OPvPCapturePointWG *GetWorkshop(uint32 lowguid) const;
    OPvPCapturePointWG *GetWorkshopByEngGuid(uint32 lowguid) const;
    OPvPCapturePointWG *GetWorkshopByGOGuid(uint64 lowguid) const;

    void StartBattle();
    void EndBattle();
    void UpdateClock();
    void UpdateClockDigit(uint32 &timer, uint32 digit, uint32 mod);
    void PromotePlayer(Player* player) const;
    void UpdateTenacityStack();
    void UpdateAllWorldObject();
    bool UpdateCreatureInfo(Creature* creature);
    bool UpdateGameObjectInfo(GameObject *go) const;
    bool CanBuildVehicle(OPvPCapturePointWG *workshop) const;
    OutdoorPvPWGCreType GetCreatureType(uint32 entry) const;

    void RebuildAllBuildings();
    void RemoveOfflinePlayerWGAuras();
    void RewardMarkOfHonor(Player* player, uint32 count);
    void MoveQuestGiver(uint32 guid);
    void LoadQuestGiverMap(uint32 guid, Position posHorde, Position posAlli);
    bool UpdateQuestGiverPosition(uint32 guid, Creature* creature);
};

class OPvPCapturePointWG : public OPvPCapturePoint
{
public:
    explicit OPvPCapturePointWG(OutdoorPvPWG *opvp, BuildingState *state);
    void SetTeamByBuildingState();
    void ChangeState() {}
    void ChangeTeam(TeamId oldteam);
    uint32 *m_spiEntry;
    uint32 m_spiGuid;
    Creature* m_spiritguide;
    Creature* m_spiritguide_horde;
    Creature* m_spiritguide_alliance;
    uint32 *m_engEntry;
    uint32 m_engGuid;
    Creature* m_engineer;
    uint32 m_workshopGuid;
    BuildingState *m_buildingState;

protected:
    OutdoorPvPWG *m_wintergrasp;
};
#endif