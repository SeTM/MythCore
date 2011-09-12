/*
 * guildhouses.cpp
 *
 *  Created on: Sep 7, 2011
 *      Author: Filchenko Nikolay
 */

#include "guildhouses.h"

#include <exception>

class InvalidGH : public std::exception
{

};

Guildhouse::Guildhouse(uint32 id)
{
    QueryResult result = CharacterDatabase.PQuery("SELECT `x`, `y`, `z`, `map`, `guild`, `name` FROM `guildhouses` WHERE `id` = %u", id);

    if(result)
    {
        Field *fields = result->Fetch();
        _x = fields[0].GetFloat();
        _y = fields[1].GetFloat();
        _z = fields[2].GetFloat();
        _map = fields[3].GetUInt32();
        _guild = fields[4].GetUInt32();
        _name = fields[5].GetString();
        _id = id;
    }
    else
    {
        throw InvalidGH();
    }
}

void Guildhouse::coords(float & x, float & y, float & z, uint32 & map) const
{
    x = _x;
    y = _y;
    z = _z;
    map = _map;
}

uint32 Guildhouse::owner() const
{
    return _guild;
}

void Guildhouse::setOwner(uint32 guild)
{
    _guild = guild;
    CharacterDatabase.PQuery("UPDATE guildhouses SET `guild`=%u WHERE `id`=%u", _guild, _id);
}

uint32 Guildhouse::getId() const
{
    return _id;
}

std::string const & Guildhouse::getName() const
{
    return _name;
}

Guildhouse * GuildhouseManager::getGH(uint32 guild) const
{
    if (_gh_for_guild.count(guild))
    {
        return _gh[_gh_for_guild[guild]];
    }
    return 0;
}

Guildhouse * GuildhouseManager::getFreeGH(uint32 id) const
{
    if (id < _gh.size() && _gh[id]->owner() == 0)
        return _gh[id];
    return 0;
}

uint32 GuildhouseManager::buy(uint32 guild, uint32 id)
{
    if (Guildhouse * gh = getFreeGH(id))
    {
        gh->setOwner(guild);
        _gh_for_guild[guild] = id;
        return 0;
    }

    return 1;
}

uint32 GuildhouseManager::sell(uint32 guild)
{
    if (Guildhouse * gh = getGH(guild))
    {
        gh->setOwner(0);
        _gh_for_guild.erase(guild);
        return 0;
    }

    return 1;
}

uint32 GuildhouseManager::getPlayerAccess(Player * p) const
{
    uint32 guild = p->GetGuildId();
    uint32 mask = 0;
    if (_gh_for_guild.count(guild))
    {
        mask = 1 << (_gh_for_guild[guild]);
    }
    return mask;
}

std::vector<Guildhouse*> GuildhouseManager::getFree() const
{
    std::vector<Guildhouse*> free;
    for (size_t i = 0; i < _gh.size(); ++i)
    {
        if (_gh[i] && _gh[i]->owner() == 0)
        {
            free.push_back(_gh[i]);
        }
    }

    return free;
}

GuildhouseManager::GuildhouseManager()
{
    for (size_t i = 0; i < 31; ++i)
    {
        Guildhouse * gh;
        try
        {
            gh = new Guildhouse(i);
            if (gh->owner())
            {
                _gh_for_guild[gh->owner()] = i;
            }
        }
        catch (InvalidGH &)
        {
            gh = 0;
        }
        _gh.push_back(gh);
    }
}

GuildhouseManager::~GuildhouseManager()
{
    for (size_t i = 0; i < _gh.size(); ++i)
    {
        if (_gh[i] != 0)
        {
            delete _gh[i];
        }
    }
}
