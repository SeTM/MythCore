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
#include "shadowfang_keep.h"

#define MAX_ENCOUNTER              4

enum eEnums
{
    SAY_BOSS_DIE_AD          = -1033007,
    SAY_BOSS_DIE_AS          = -1033008,
    SAY_ARCHMAGE             = -1033009,
    NPC_ASH                  = 3850,
    NPC_ADA                  = 3849,
    NPC_ARCHMAGE_ARUGAL      = 4275,
    NPC_ARUGAL_VOIDWALKER    = 4627,
    NPC_APOTHECARY_HUMMEL    = 36296,
    NPC_APOTHECARY_BAXTER    = 36565,
    NPC_APOTHECARY_FRYE      = 36272,
    GO_COURTYARD_DOOR        = 18895,
    GO_SORCERER_DOOR         = 18972,
    GO_ARUGAL_DOOR           = 18971,
    SPELL_ASHCROMBE_TELEPORT = 15742
};

const Position SpawnLocation[] =
{
    {-148.199f, 2165.647f, 128.448f, 1.026f},
    {-153.110f, 2168.620f, 128.448f, 1.026f},
    {-145.905f, 2180.520f, 128.448f, 4.183f},
    {-140.794f, 2178.037f, 128.448f, 4.090f},
    {-138.640f, 2170.159f, 136.577f, 2.737f}
};
class instance_shadowfang_keep : public InstanceMapScript
{
public:
    instance_shadowfang_keep() : InstanceMapScript("instance_shadowfang_keep", 33) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_shadowfang_keep_InstanceMapScript(pMap);
    }

    struct instance_shadowfang_keep_InstanceMapScript : public InstanceScript
    {
        instance_shadowfang_keep_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;

        uint64 uiAshGUID;
        uint64 uiAdaGUID;
        uint64 uiArchmageArugalGUID;
        uint64 uiHummelGUID;
        uint64 uiBaxterGUID;
        uint64 uiFryeGUID;

        uint64 DoorCourtyardGUID;
        uint64 DoorSorcererGUID;
        uint64 DoorArugalGUID;

        uint8 uiPhase;
        uint16 uiTimer;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            uiAshGUID = 0;
            uiAdaGUID = 0;
            uiArchmageArugalGUID = 0;

            DoorCourtyardGUID = 0;
            DoorSorcererGUID = 0;
            DoorArugalGUID = 0;

            uiPhase = 0;
            uiTimer = 0;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch(creature->GetEntry())
            {
                case NPC_ASH: uiAshGUID = creature->GetGUID(); break;
                case NPC_ADA: uiAdaGUID = creature->GetGUID(); break;
                case NPC_ARCHMAGE_ARUGAL: uiArchmageArugalGUID = creature->GetGUID(); break;
                case NPC_APOTHECARY_HUMMEL: uiHummelGUID = creature->GetGUID(); break;
                case NPC_APOTHECARY_BAXTER: uiBaxterGUID = creature->GetGUID(); break;
                case NPC_APOTHECARY_FRYE: uiFryeGUID = creature->GetGUID(); break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch(go->GetEntry())
            {
                case GO_COURTYARD_DOOR:
                    DoorCourtyardGUID = go->GetGUID();
                    if (m_auiEncounter[0] == DONE)
                        HandleGameObject(0, true, go);
                    break;
                case GO_SORCERER_DOOR:
                    DoorSorcererGUID = go->GetGUID();
                    if (m_auiEncounter[2] == DONE)
                        HandleGameObject(0, true, go);
                    break;
                case GO_ARUGAL_DOOR:
                    DoorArugalGUID = go->GetGUID();
                    if (m_auiEncounter[3] == DONE)
                        HandleGameObject(0, true, go);
                    break;
            }
        }

        void DoSpeech()
        {
            Creature* pAda = instance->GetCreature(uiAdaGUID);
            Creature* pAsh = instance->GetCreature(uiAshGUID);

            if (pAda && pAda->isAlive() && pAsh && pAsh->isAlive())
            {
                DoScriptText(SAY_BOSS_DIE_AD, pAda);
                DoScriptText(SAY_BOSS_DIE_AS, pAsh);
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case TYPE_FREE_NPC:
                    if (data == DONE)
                        DoUseDoorOrButton(DoorCourtyardGUID);
                    m_auiEncounter[0] = data;
                    break;
                case TYPE_RETHILGORE:
                    if (data == DONE)
                        DoSpeech();
                    m_auiEncounter[1] = data;
                    break;
                case TYPE_FENRUS:
                    switch(data)
                    {
                        case DONE:
                            uiTimer = 1000;
                            uiPhase = 1;
                            break;
                        case 7:
                            DoUseDoorOrButton(DoorSorcererGUID);
                            break;
                    }
                    m_auiEncounter[2] = data;
                    break;
                case TYPE_NANDOS:
                    if (data == DONE)
                        DoUseDoorOrButton(DoorArugalGUID);
                    m_auiEncounter[3] = data;
                    break;
            }

            if (data == DONE)
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << m_auiEncounter[0] << " " << m_auiEncounter[1] << " " << m_auiEncounter[2] << " " << m_auiEncounter[3];

                str_data = saveStream.str();

                SaveToDB();
                OUT_SAVE_INST_DATA_COMPLETE;
            }
        }

        uint32 GetData(uint32 type)
        {
            switch(type)
            {
                case TYPE_FREE_NPC:
                    return m_auiEncounter[0];
                case TYPE_RETHILGORE:
                    return m_auiEncounter[1];
                case TYPE_FENRUS:
                    return m_auiEncounter[2];
                case TYPE_NANDOS:
                    return m_auiEncounter[3];
            }
            return 0;
        }

        uint64 GetData64(uint32 id)
        {
            switch(id)
            {
                case DATA_HUMMEL:
                    return uiHummelGUID;
                case DATA_BAXTER:
                    return uiBaxterGUID;
                case DATA_FRYE:
                    return uiFryeGUID;
            }
            return NULL;
        }

        std::string GetSaveData()
        {
            return str_data;
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            std::istringstream loadStream(in);
            loadStream >> m_auiEncounter[0] >> m_auiEncounter[1] >> m_auiEncounter[2] >> m_auiEncounter[3];

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (m_auiEncounter[i] == IN_PROGRESS)
                    m_auiEncounter[i] = NOT_STARTED;
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void Update(uint32 diff)
        {
            if (GetData(TYPE_FENRUS) != DONE)
                return;

            Creature* pArchmage = instance->GetCreature(uiArchmageArugalGUID);
            Creature* pSummon = NULL;

            if (!pArchmage || !pArchmage->isAlive())
                return;

            if (uiPhase)
            {
                if (uiTimer <= diff)
                {
                    switch(uiPhase)
                    {
                        case 1:
                            pSummon = pArchmage->SummonCreature(pArchmage->GetEntry(), SpawnLocation[4], TEMPSUMMON_TIMED_DESPAWN, 10000);
                            pSummon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
                            pSummon->SetReactState(REACT_DEFENSIVE);
                            pSummon->CastSpell(pSummon, SPELL_ASHCROMBE_TELEPORT, true);
                            DoScriptText(SAY_ARCHMAGE, pSummon);
                            uiTimer = 2000;
                            uiPhase = 2;
                            break;
                        case 2:
                            pArchmage->SummonCreature(NPC_ARUGAL_VOIDWALKER, SpawnLocation[0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                            pArchmage->SummonCreature(NPC_ARUGAL_VOIDWALKER, SpawnLocation[1], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                            pArchmage->SummonCreature(NPC_ARUGAL_VOIDWALKER, SpawnLocation[2], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                            pArchmage->SummonCreature(NPC_ARUGAL_VOIDWALKER, SpawnLocation[3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                            uiPhase = 0;
                            break;

                    }
                } else uiTimer -= diff;
            }
        }
    };

};

void AddSC_instance_shadowfang_keep()
{
    new instance_shadowfang_keep();
}
