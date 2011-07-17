#
# Copyright (C) 2008 - 2011 Trinity <http://www.trinitycore.org/>
#
# Copyright (C) 2010 - 2011 Myth Project <http://bitbucket.org/sun/myth-core/>
#
# Myth Project's source is based on the Trinity Project source, you can find the
# link to that easily in Trinity Copyrights. Myth Project is a private community.
# To get access, you either have to donate or pass a developer test.
# You can't share Myth Project's sources! Only for personal use.
#
# output generic information about the core and buildtype chosen

message("* Myth Core Revision   : ${rev_id_str} (${rev_hash_str})")
if( UNIX )
  message("* Build binaries in      : ${CMAKE_BUILD_TYPE} mode")
endif()
message("")

# output information about installation-directories and locations
if( UNIX )
  message("* Install core to        : ${CMAKE_INSTALL_PREFIX}")
  message("* Install libraries to   : ${LIBSDIR}")
  message("* Install configs to     : ${CONF_DIR}")
  message("")
endif()

# Show infomation about the options selected during configuration

if( SERVERS )
  message("* Build world/auth       : Yes (default)")
  set(USE_COREPCH 1)
  add_definitions(-DTRINITY_COREPCH)
else()
  message("* Build world/authserver : No")
  set(USE_COREPCH 0)
endif()

if( SCRIPTS )
  message("* Build with scripts     : Yes (default)")
  set(USE_SCRIPTPCH 1)
  add_definitions(-DSCRIPTS)
else()
  message("* Build with scripts     : No")
  set(USE_SCRIPTPCH 0)
endif()

if( TOOLS )
  message("* Build map/vmap tools   : Yes")
else()
  message("* Build map/vmap tools   : No  (default)")
endif()

if( WITH_WARNINGS )
  message("* Show all warnings      : Yes")
else()
  message("* Show compile-warnings  : No  (default)")
endif()

if( WITH_COREDEBUG )
  message("* Use coreside debug     : Yes")
  add_definitions(-DTRINITY_DEBUG)
else()
  message("* Use coreside debug     : No  (default)")
endif()

message("")