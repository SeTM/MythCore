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
#include "ulduar.h"

const DoorData doorData[] =
{
    {194416,    BOSS_LEVIATHAN, DOOR_TYPE_ROOM,     0},
    {194905,    BOSS_LEVIATHAN, DOOR_TYPE_PASSAGE,  0},
    {194631,    BOSS_XT002,     DOOR_TYPE_ROOM,     0},
    {194554,    BOSS_ASSEMBLY,  DOOR_TYPE_ROOM,     0},
    {194556,    BOSS_ASSEMBLY,  DOOR_TYPE_PASSAGE,  0},
    {194553,    BOSS_KOLOGARN,  DOOR_TYPE_ROOM,     0},
    {194441,    BOSS_HODIR,     DOOR_TYPE_PASSAGE,  0},
    {194634,    BOSS_HODIR,     DOOR_TYPE_PASSAGE,  0},
    {194442,    BOSS_HODIR,     DOOR_TYPE_ROOM,     0},
    {194559,    BOSS_THORIM,    DOOR_TYPE_ROOM,     0},
    {194774,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194775,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194776,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194750,    BOSS_VEZAX,     DOOR_TYPE_PASSAGE,  0},
    {194773,    BOSS_YOGGSARON, DOOR_TYPE_ROOM,     0},
    {0,         0,              DOOR_TYPE_ROOM,     0}
};

enum eGameObjects
{
    GO_LEVIATHAN_DOOR           = 194630,
    GO_KOLOGARN_BRIDGE          = 194232,
    GO_HODIR_RARE_CHEST_10      = 194200,
    GO_HODIR_RARE_CHEST_25      = 194201,
    GO_RUNIC_DOOR               = 194557,
    GO_STONE_DOOR               = 194558,
    GO_THORIM_LEVER             = 194265,
    GO_MIMIRON_TRAM             = 194675,
    GO_MIMIRON_ELEVATOR         = 194749,
    GO_KEEPERS_DOOR             = 194255,
    GO_ARCHIVUM_CONSOLE         = 194555,
    GO_CELESTIAL_ACCES          = 194628,
    GO_CELESTIAL_ACCES_H        = 194752,
    GO_CELESTIAL_DOOR           = 194767,
    GO_UNIVERSE_FLOOR_ARCHIVUM  = 194715,
    GO_UNIVERSE_FLOOR_CELESTIAL = 194716,
    GO_AZEROTH_GLOBE            = 194148,
    GO_GIFT_OF_OBSERVER_25      = 194821,
    GO_GIFT_OF_OBSERVER_10      = 194822,
    GO_GIFT_OF_OBSERVER_H       = 194823,
};

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", 603) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetBossNumber(MAX_BOSS_NUMBER);
            LoadDoorData(doorData);
        }

        uint64 uiLeviathan;
        uint64 uiNorgannon;
        uint64 uiIgnis;
        uint64 uiRazorscale;
        uint64 uiExpCommander;
        uint64 uiXT002;
        uint64 uiSteelbreaker;
        uint64 uiMolgeim;
        uint64 uiBrundir;
        uint64 uiKologarn;
        uint64 uiKologarnBridge;
        uint64 uiAuriaya;
        uint64 uiBrightleaf;
        uint64 uiIronbranch;
        uint64 uiStonebark;
        uint64 uiFreya;
        uint64 uiThorim;
        uint64 uiRunicColossus;
        uint64 uiRuneGiant;
        uint64 uiMimiron;
        uint64 uiLeviathanMKII;
        uint64 uiVX001;
        uint64 uiAerialUnit;
        uint64 uiMagneticCore;
        uint64 uiKeepersGate;
        uint64 uiVezax;
        uint64 uiFreyaImage;
        uint64 uiThorimImage;
        uint64 uiMimironImage;
        uint64 uiHodirImage;
        uint64 uiFreyaYS;
        uint64 uiThorimYS;
        uint64 uiMimironYS;
        uint64 uiHodirYS;
        uint64 uiYoggSaronBrain;
        uint64 uiYoggSaron;
        uint64 uiAlgalon;
        uint64 uiLeviathanDoor;
        uint64 uiHodirRareChest;
        uint64 uiRunicDoor;
        uint64 uiStoneDoor;
        uint64 uiThorimLever;
        uint64 uiMimironTram;
        uint64 uiMimironElevator;
        uint64 uiCelestialDoor;
        uint64 uiCelestialConsole;
        uint64 uiUniverseFloorCelestial;
        uint64 uiAzerothGlobe;
        uint64 uiAlagonLoot;
        uint64 uiArchivumConsole;
        uint64 uiUniverseFloorArchivum;

        void OnGameObjectCreate(GameObject* pGo)
        {
            AddDoor(pGo, true);
            switch(pGo->GetEntry())
            {
                case GO_LEVIATHAN_DOOR:
                    uiLeviathanDoor = pGo->GetGUID();
                    break;
                case GO_KOLOGARN_BRIDGE:
                    uiKologarnBridge = pGo->GetGUID();
                    HandleGameObject(uiKologarnBridge, true);
                    break;
                case GO_HODIR_RARE_CHEST_10:
                    uiHodirRareChest = pGo->GetGUID();
                    break;
                case GO_HODIR_RARE_CHEST_25:
                    uiHodirRareChest = pGo->GetGUID();
                    break;
                case GO_RUNIC_DOOR:
                    uiRunicDoor = pGo->GetGUID();
                    break;
                case GO_STONE_DOOR:
                    uiStoneDoor = pGo->GetGUID();
                    break;
                case GO_THORIM_LEVER:
                    uiThorimLever = pGo->GetGUID();
                    break;
                case GO_MIMIRON_TRAM:
                    uiMimironTram = pGo->GetGUID();
                    break;
                case GO_MIMIRON_ELEVATOR:
                    uiMimironElevator = pGo->GetGUID();
                    break;
                case GO_KEEPERS_DOOR:
                    uiKeepersGate = pGo->GetGUID();
                    pGo->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                    if (instance)
                        for (uint32 i = BOSS_MIMIRON; i < BOSS_VEZAX; ++i)
                            if (GetBossState(i) != DONE)
                                pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                    break;
                case GO_ARCHIVUM_CONSOLE:
                    uiArchivumConsole = pGo->GetGUID();
                    break;
                case GO_UNIVERSE_FLOOR_ARCHIVUM:
                    uiUniverseFloorArchivum = pGo->GetGUID();
                    break;
                    // Celestial Planetarium
                case GO_CELESTIAL_ACCES:
                    uiCelestialConsole = pGo->GetGUID();
                    break;
                case GO_CELESTIAL_DOOR:
                    uiCelestialDoor = pGo->GetGUID();
                    break;
                case GO_UNIVERSE_FLOOR_CELESTIAL:
                    uiUniverseFloorCelestial = pGo->GetGUID();
                    break;
                case GO_AZEROTH_GLOBE:
                    uiAzerothGlobe = pGo->GetGUID();
                    break;
                case GO_GIFT_OF_OBSERVER_10:
                    uiAlagonLoot = pGo->GetGUID();
                    break;
                case GO_GIFT_OF_OBSERVER_25:
                    uiAlagonLoot = pGo->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go)
        {
            AddDoor(go, false);
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            Map::PlayerList const &players = instance->GetPlayers();
            uint32 TeamInInstance = 0;

            if (!players.isEmpty())
                if (Player* pPlayer = players.begin()->getSource())
                    TeamInInstance = pPlayer->GetTeam();

            switch(pCreature->GetEntry())
            {
                case 33113: uiLeviathan = pCreature->GetGUID(); return;
                case 33686: uiNorgannon = pCreature->GetGUID(); return;
                case 33118: uiIgnis = pCreature->GetGUID(); return;
                case 33186: uiRazorscale = pCreature->GetGUID(); return;
                case 33210: uiExpCommander = pCreature->GetGUID(); return;
                case 33293: uiXT002 = pCreature->GetGUID(); return;
                case 32867: uiSteelbreaker = pCreature->GetGUID(); return;
                case 32927: uiMolgeim = pCreature->GetGUID(); return;
                case 32857: uiBrundir = pCreature->GetGUID(); return;
                case 32930: uiKologarn = pCreature->GetGUID(); return;
                case 33515: uiAuriaya = pCreature->GetGUID(); return;
                case 32915: uiBrightleaf = pCreature->GetGUID(); return;
                case 32913: uiIronbranch = pCreature->GetGUID(); return;
                case 32914: uiStonebark = pCreature->GetGUID(); return;
                case 32906: uiFreya = pCreature->GetGUID(); return;
                case 32865: uiThorim = pCreature->GetGUID(); return;
                case 32872: uiRunicColossus = pCreature->GetGUID(); return;
                case 32873: uiRuneGiant = pCreature->GetGUID(); return;
                case 33350: uiMimiron = pCreature->GetGUID(); return;
                case 33432: uiLeviathanMKII = pCreature->GetGUID(); return;
                case 33651: uiVX001 = pCreature->GetGUID(); return;
                case 33670: uiAerialUnit = pCreature->GetGUID(); return;
                case 34068: uiMagneticCore = pCreature->GetGUID(); return;
                case 33271: uiVezax = pCreature->GetGUID(); return;
                case 33410: uiFreyaYS = pCreature->GetGUID(); return;
                case 33413: uiThorimYS = pCreature->GetGUID(); return;
                case 33412: uiMimironYS = pCreature->GetGUID(); return;
                case 33411: uiHodirYS = pCreature->GetGUID(); return;
                case 33890: uiYoggSaronBrain = pCreature->GetGUID(); return;
                case 33288: uiYoggSaron = pCreature->GetGUID(); return;
                case 32871: uiAlgalon = pCreature->GetGUID(); return;

                // Keeper's Images
                case 33241: uiFreyaImage = pCreature->GetGUID();
                {
                    InstanceScript* pInstance = pCreature->GetInstanceScript();
                    pCreature->SetVisible(false);
                    if (pInstance && pInstance->GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisible(true);
                }
                return;
                case 33242: uiThorimImage = pCreature->GetGUID();
                {
                    InstanceScript* pInstance = pCreature->GetInstanceScript();
                    pCreature->SetVisible(false);
                    if (pInstance && pInstance->GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisible(true);
                }
                return;
                case 33244: uiMimironImage = pCreature->GetGUID();
                {
                    InstanceScript* pInstance = pCreature->GetInstanceScript();
                    pCreature->SetVisible(false);
                    if (pInstance && pInstance->GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisible(true);
                }
                return;
                case 33213: uiHodirImage = pCreature->GetGUID();
                {
                    InstanceScript* pInstance = pCreature->GetInstanceScript();
                    pCreature->SetVisible(false);
                    if (pInstance && pInstance->GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisible(true);
                }
                return;
            }

            // Hodir: Alliance npcs are spawned by default
            if (TeamInInstance == HORDE)
            {
                switch(pCreature->GetEntry())
                {
                    case 33325: pCreature->UpdateEntry(32941, HORDE); return;
                    case 32901: pCreature->UpdateEntry(33333, HORDE); return;
                    case 33328: pCreature->UpdateEntry(33332, HORDE); return;
                    case 32900: pCreature->UpdateEntry(32950, HORDE); return;
                    case 32893: pCreature->UpdateEntry(33331, HORDE); return;
                    case 33327: pCreature->UpdateEntry(32946, HORDE); return;
                    case 32897: pCreature->UpdateEntry(32948, HORDE); return;
                    case 33326: pCreature->UpdateEntry(33330, HORDE); return;
                    case 32908: pCreature->UpdateEntry(32907, HORDE); return;
                    case 32885: pCreature->UpdateEntry(32883, HORDE); return;
                }
            }
        }

        uint64 GetData64(uint32 id)
        {
            switch(id)
            {
                case DATA_LEVIATHAN:
                    return uiLeviathan;
                case DATA_NORGANNON:
                    return uiNorgannon;
                case DATA_IGNIS:
                    return uiIgnis;
                case DATA_RAZORSCALE:
                    return uiRazorscale;
                case DATA_EXP_COMMANDER:
                    return uiExpCommander;
                case DATA_XT002:
                    return uiXT002;
                case DATA_STEELBREAKER:
                    return uiSteelbreaker;
                case DATA_MOLGEIM:
                    return uiMolgeim;
                case DATA_BRUNDIR:
                    return uiBrundir;
                case DATA_KOLOGARN:
                    return uiKologarn;
                case DATA_AURIAYA:
                    return uiAuriaya;
                case DATA_BRIGHTLEAF:
                    return uiBrightleaf;
                case DATA_IRONBRANCH:
                    return uiIronbranch;
                case DATA_STONEBARK:
                    return uiStonebark;
                case DATA_FREYA:
                    return uiFreya;
                case DATA_THORIM:
                    return uiThorim;
                case DATA_RUNIC_COLOSSUS:
                    return uiRunicColossus;
                case DATA_RUNE_GIANT:
                    return uiRuneGiant;
                case DATA_MIMIRON:
                    return uiMimiron;
                case DATA_LEVIATHAN_MK_II:
                    return uiLeviathanMKII;
                case DATA_VX_001:
                    return uiVX001;
                case DATA_AERIAL_UNIT:
                    return uiAerialUnit;
                case DATA_MAGNETIC_CORE:
                    return uiMagneticCore;
                case DATA_VEZAX:
                    return uiVezax;
                case DATA_YS_FREYA:
                    return uiFreyaYS;
                case DATA_YS_THORIM:
                    return uiThorimYS;
                case DATA_YS_MIMIRON:
                    return uiMimironYS;
                case DATA_YS_HODIR:
                    return uiHodirYS;
                case DATA_YOGGSARON_BRAIN:
                    return uiYoggSaronBrain;
                case DATA_YOGGSARON:
                    return uiYoggSaron;
                case DATA_ALGALON:
                    return uiAlgalon;
                case DATA_CELESTIAL_DOOR:
                    return uiCelestialDoor;
            }
            return NULL;
        }

        void SetData(uint32 id, uint32 value)
        {
            switch(id)
            {
                case DATA_LEVIATHAN_DOOR:
                    if (GameObject* pLeviathanDoor = instance->GetGameObject(uiLeviathanDoor))
                        pLeviathanDoor->SetGoState(GOState(value));
                    break;
                case DATA_TOWER_DESTROYED:
                    {
                        if (Creature* pLeviathan = instance->GetCreature(uiLeviathan))
                        {
                            switch(value)
                            {
                                case 1: // Tower of Storms
                                    pLeviathan->AI()->DoAction(1);
                                    break;
                                case 2: // Tower of Flames
                                    pLeviathan->AI()->DoAction(2);
                                    break;
                                case 3: // Tower of Frost
                                    pLeviathan->AI()->DoAction(3);
                                    break;
                                case 4: // Tower of Life
                                    pLeviathan->AI()->DoAction(4);
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                    break;
                case DATA_RUNIC_DOOR:
                    if (GameObject* pRunicDoor = instance->GetGameObject(uiRunicDoor))
                        pRunicDoor->SetGoState(GOState(value));
                    break;
                case DATA_STONE_DOOR:
                    if (GameObject* pStoneDoor = instance->GetGameObject(uiStoneDoor))
                        pStoneDoor->SetGoState(GOState(value));
                    break;
                case DATA_CALL_TRAM:
                    if (GameObject* pMimironTram = instance->GetGameObject(uiMimironTram))
                    {
                        // Load Mimiron Tram (unfortunally only server side)
                        instance->LoadGrid(2307, 284.632f);

                        if (value == 0)
                            pMimironTram->SetGoState(GO_STATE_READY);
                        if (value == 1)
                            pMimironTram->SetGoState(GO_STATE_ACTIVE);

                        // Send movement update to players
                        if (Map* pMap = pMimironTram->GetMap())
                        {
                            if (pMap->IsDungeon())
                            {
                                Map::PlayerList const &PlayerList = pMap->GetPlayers();

                                if (!PlayerList.isEmpty())
                                {
                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    {
                                        if (i->getSource())
                                        {
                                            UpdateData data;
                                            WorldPacket pkt;
                                            pMimironTram->BuildValuesUpdateBlockForPlayer(&data, i->getSource());
                                            data.BuildPacket(&pkt);
                                            i->getSource()->GetSession()->SendPacket(&pkt);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    break;
                case DATA_MIMIRON_ELEVATOR:
                    if (GameObject* pMimironElevator = instance->GetGameObject(uiMimironElevator))
                        pMimironElevator->SetGoState(GOState(value));
                    break;
                case DATA_HODIR_RARE_CHEST:
                    if (GameObject* pHodirRareChest = instance->GetGameObject(uiHodirRareChest))
                    {
                        if (value == GO_STATE_READY)
                            pHodirRareChest->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_UNK1);
                    }
                    break;
            }
        }

        bool SetBossState(uint32 id, EncounterState state)
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            switch (id)
            {
                case BOSS_KOLOGARN:
                    if (state == DONE)
                        HandleGameObject(uiKologarnBridge, false);
                    break;
                case BOSS_HODIR:
                    CheckKeepersState();
                    break;
                case BOSS_THORIM:
                    if (GameObject* pThorimLever = instance->GetGameObject(uiThorimLever))
                    {
                        if (state == IN_PROGRESS)
                            pThorimLever->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_UNK1);
                    }
                    CheckKeepersState();
                    break;
                case BOSS_MIMIRON:
                    CheckKeepersState();
                    break;
                case BOSS_FREYA:
                    CheckKeepersState();
                    break;
                case BOSS_VEZAX:
                    if (state == DONE)
                    {
                        // Keeper's Images
                        if (Creature* pFreya = instance->GetCreature(uiFreyaImage))
                            pFreya->SetVisible(true);
                        if (Creature* pThorim = instance->GetCreature(uiThorimImage))
                            pThorim->SetVisible(true);
                        if (Creature* pMimiron = instance->GetCreature(uiMimironImage))
                            pMimiron->SetVisible(true);
                        if (Creature* pHodir = instance->GetCreature(uiHodirImage))
                            pHodir->SetVisible(true);
                    }
                    break;
                case BOSS_ALGALON:
                    if (GameObject* pCelestialDoor = instance->GetGameObject(uiCelestialDoor))
                        pCelestialDoor->SetGoState(GO_STATE_READY);
                    if (GameObject* pUniverseFloorCelestial = instance->GetGameObject(uiUniverseFloorCelestial))
                        pUniverseFloorCelestial->SetGoState(GO_STATE_READY);
                    if (state == DONE)
                        DoRespawnGameObject(uiAlagonLoot, 30*MINUTE);
                    break;
            }

            return true;
        }

        void CheckKeepersState()
        {
            if (GameObject* pGo = instance->GetGameObject(uiKeepersGate))
            {
                InstanceScript* pInstance = pGo->GetInstanceScript();
                pGo->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                if (pInstance)
                {
                    for (uint32 i = BOSS_MIMIRON; i < BOSS_VEZAX; ++i)
                        if (pInstance->GetBossState(i) != DONE)
                            pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                }
            }
        }
    };

};

class go_call_tram : public GameObjectScript
{
public:
    go_call_tram() : GameObjectScript("go_call_tram") { }

    bool OnGossipHello(Player* /*pPlayer*/, GameObject* pGo)
    {
        InstanceScript* pInstance = pGo->GetInstanceScript();

        if (!pInstance)
            return false;

        switch(pGo->GetEntry())
        {
            case 194914:
            case 194438:
                pInstance->SetData(DATA_CALL_TRAM, 0);
                break;
            case 194912:
            case 194437:
                pInstance->SetData(DATA_CALL_TRAM, 1);
                break;
        }
        return true;
    }
};

void AddSC_instance_ulduar()
{
    new instance_ulduar();
    new go_call_tram();
}