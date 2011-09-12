/*
 * guildcity.cpp
 *
 *  Created on: Sep 7, 2011
 *      Author: Filchenko Nikolay
 */

#include "ScriptMgr.h"

#include "guildhouses.h"
#include <set>


class guildcity : public InstanceMapScript
{
public:
    guildcity() : InstanceMapScript("guildcity", 169) {}

    InstanceScript *GetInstanceScript(InstanceMap *pMap) const
    {
        return new guildcity_script(pMap);
    }

    struct guildcity_script : public InstanceScript
    {
    public:
        guildcity_script(Map *pMap) : InstanceScript(pMap) {gc = this;}

        virtual void OnPlayerEnter(Player* player)
        {
            players.insert(player);
            uint32 phaseMask = GuildhouseManager::instance()->getPlayerAccess(player);
            phaseMask = ~phaseMask;
            player->SetPhaseMask(phaseMask, true);
        }

        virtual void OnPlayerexit(Player* player)
        {
            players.erase(player);
            player->SetPhaseMask(1, true);
        }

        void reload()
        {
            for (std::set<Player*>::iterator it = players.begin(); it != players.end(); ++it)
            {
                Player * player = *it;
                uint32 phaseMask = GuildhouseManager::instance()->getPlayerAccess(player);
                phaseMask = ~phaseMask;
                player->SetPhaseMask(phaseMask, true);
            }
        }
    private:
        std::set<Player*> players;
    };

    static guildcity_script * gc;
};

guildcity::guildcity_script * guildcity::gc = 0;

void reloadGuilds()
{
    if (guildcity::gc)
        guildcity::gc->reload();
}

void AddSC_guildcity()
{
    new guildcity;
}
