/*
 * guildhouses.h
 *
 *  Created on: Sep 7, 2011
 *      Author: Filchenko Nikolay
 */

#ifndef GUILDHOUSES_H_
#define GUILDHOUSES_H_

#include <vector>
#include <map>
#include "Config.h"

class Guildhouse
{
public:
    Guildhouse(uint32 id);
    void coords(float & x, float & y, float & z, uint32 & map) const;
    uint32 owner() const;
    void setOwner(uint32 guild);
    uint32 getId() const;
    std::string const & getName() const;
private:
    float _x, _y, _z;
    uint32 _map;
    uint32 _guild;
    uint32 _id;
    std::string _name;
};

class GuildhouseManager
{
public:
    static GuildhouseManager * instance()
    {
        static GuildhouseManager ghm;
        return &ghm;
    }

    Guildhouse * getGH(uint32 guild) const;
    Guildhouse * getFreeGH(uint32 id) const;
    uint32 buy(uint32 guild, uint32 id);
    uint32 sell(uint32 guild);
    uint32 getPlayerAccess(Player * p) const;
    std::vector<Guildhouse*> getFree() const;
private:
    GuildhouseManager();
    ~GuildhouseManager();
    std::vector<Guildhouse *> _gh;
    mutable std::map<uint32, uint32> _gh_for_guild;
};


void reloadGuilds();

#endif /* GUILDHOUSES_H_ */
