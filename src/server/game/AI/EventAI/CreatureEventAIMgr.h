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

#ifndef TRINITY_CREATURE_EAI_MGR_H
#define TRINITY_CREATURE_EAI_MGR_H

#include "Common.h"
#include "CreatureEventAI.h"

class CreatureEventAIMgr
{
    friend class ACE_Singleton<CreatureEventAIMgr, ACE_Null_Mutex>;
    CreatureEventAIMgr(){};
    public:
        ~CreatureEventAIMgr(){};

        void LoadCreatureEventAI_Texts();
        void LoadCreatureEventAI_Summons();
        void LoadCreatureEventAI_Scripts();

        CreatureEventAI_Event_Map  const& GetCreatureEventAIMap()       const { return m_CreatureEventAI_Event_Map; }
        CreatureEventAI_Summon_Map const& GetCreatureEventAISummonMap() const { return m_CreatureEventAI_Summon_Map; }
        CreatureEventAI_TextMap    const& GetCreatureEventAITextMap()   const { return m_CreatureEventAI_TextMap; }

    private:
        CreatureEventAI_Event_Map  m_CreatureEventAI_Event_Map;
        CreatureEventAI_Summon_Map m_CreatureEventAI_Summon_Map;
        CreatureEventAI_TextMap    m_CreatureEventAI_TextMap;
};

#define sEventAIMgr ACE_Singleton<CreatureEventAIMgr, ACE_Null_Mutex>::instance()
#endif
