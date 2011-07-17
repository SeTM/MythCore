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
#include "ScriptSystem.h"
#include "ObjectMgr.h"
#include "DatabaseEnv.h"

ScriptPointVector const SystemMgr::_empty;

void SystemMgr::LoadVersion()
{
    // Get Version information
    QueryResult result = WorldDatabase.Query("SELECT script_version FROM version LIMIT 1");

    if (result)
    {
        Field* fields = result->Fetch();

        sLog->outString("TSCR: Database version is: %s", fields[0].GetCString());
        sLog->outString();
    }
    else
    {
        sLog->outError("TSCR: Missing `version`.`script_version` information.");
        sLog->outString();
    }
}

void SystemMgr::LoadScriptTexts()
{
    sLog->outString("TSCR: Loading Script Texts...");
    LoadTrinityStrings("script_texts", TEXT_SOURCE_RANGE, 1+(TEXT_SOURCE_RANGE*2));

    sLog->outString("TSCR: Loading Script Texts additional data...");
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT entry, sound, type, language, emote FROM script_texts");

    if (!result)
    {
        sLog->outString(">> Loaded 0 additional Script Texts data. DB table `script_texts` is empty.");
        sLog->outString();
        return;
    }

    uint32 uiCount = 0;

    do
    {
        Field* pFields = result->Fetch();
        StringTextData pTemp;

        int32 iId           = pFields[0].GetInt32();
        pTemp.uiSoundId     = pFields[1].GetUInt32();
        pTemp.uiType        = pFields[2].GetUInt32();
        pTemp.uiLanguage    = pFields[3].GetUInt32();
        pTemp.uiEmote       = pFields[4].GetUInt32();

        if (iId >= 0)
        {
            sLog->outErrorDb("TSCR: Entry %i in table `script_texts` is not a negative value.", iId);
            continue;
        }

        if (iId > TEXT_SOURCE_RANGE || iId <= TEXT_SOURCE_RANGE*2)
        {
            sLog->outErrorDb("TSCR: Entry %i in table `script_texts` is out of accepted entry range for table.", iId);
            continue;
        }

        if (pTemp.uiSoundId)
        {
            if (!GetSoundEntriesStore()->LookupEntry(pTemp.uiSoundId))
                sLog->outErrorDb("TSCR: Entry %i in table `script_texts` has soundId %u but sound does not exist.", iId, pTemp.uiSoundId);
        }

        if (!GetLanguageDescByID(pTemp.uiLanguage))
            sLog->outErrorDb("TSCR: Entry %i in table `script_texts` using Language %u but Language does not exist.", iId, pTemp.uiLanguage);

        if (pTemp.uiType > CHAT_TYPE_ZONE_YELL)
            sLog->outErrorDb("TSCR: Entry %i in table `script_texts` has Type %u but this Chat Type does not exist.", iId, pTemp.uiType);

        m_mTextDataMap[iId] = pTemp;
        ++uiCount;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u additional Script Texts data in %u ms", uiCount, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SystemMgr::LoadScriptWaypoints()
{
    uint32 oldMSTime = getMSTime();

    // Drop Existing Waypoint list
    m_mPointMoveMap.clear();

    uint64 uiCreatureCount = 0;

    // Load Waypoints
    QueryResult result = WorldDatabase.Query("SELECT COUNT(entry) FROM script_waypoint GROUP BY entry");
    if (result)
        uiCreatureCount = result->GetRowCount();

    sLog->outString("TSCR: Loading Script Waypoints for " UI64FMTD " creature(s)...", uiCreatureCount);

    result = WorldDatabase.Query("SELECT entry, pointid, location_x, location_y, location_z, waittime FROM script_waypoint ORDER BY pointid");

    if (!result)
    {
        sLog->outString(">> Loaded 0 Script Waypoints. DB table `script_waypoint` is empty.");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do
    {
        Field* pFields = result->Fetch();
        ScriptPointMove pTemp;

        pTemp.uiCreatureEntry   = pFields[0].GetUInt32();
        uint32 uiEntry          = pTemp.uiCreatureEntry;
        pTemp.uiPointId         = pFields[1].GetUInt32();
        pTemp.fX                = pFields[2].GetFloat();
        pTemp.fY                = pFields[3].GetFloat();
        pTemp.fZ                = pFields[4].GetFloat();
        pTemp.uiWaitTime        = pFields[5].GetUInt32();

        CreatureTemplate const* pCInfo = sObjectMgr->GetCreatureTemplate(pTemp.uiCreatureEntry);

        if (!pCInfo)
        {
            sLog->outErrorDb("TSCR: DB table script_waypoint has waypoint for non-existant creature entry %u", pTemp.uiCreatureEntry);
            continue;
        }

        if (!pCInfo->ScriptID)
            sLog->outErrorDb("TSCR: DB table script_waypoint has waypoint for creature entry %u, but creature does not have ScriptName defined and then useless.", pTemp.uiCreatureEntry);

        m_mPointMoveMap[uiEntry].push_back(pTemp);
        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u Script Waypoint nodes in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}
