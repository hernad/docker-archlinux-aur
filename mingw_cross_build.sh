#!/bin/bash

sudo mkdir  -p /opt/knowhowERP/hbwin
sudo chown docker -R /opt/knowhowERP


export MINGW=i686-w64-mingw32
export CC=$MINGW-gcc
export CXX=$MINGW-g++
export CPP=$MINGW-cpp
export AR=$MINGW-ar
export RANLIB=$MINGW-ranlib
export ADD2LINE=$MINGW-addr2line
export AS=$MINGW-as
export WINDRES=$MINGW-windres
export LD=$MINGW-ld
export NM=$MINGW-nm
export STRIP=$MINGW-strip
export MINGW32_LIBS=/usr/$MINGW/lib/
export MINGW32_INCLUDES=/usr/$MINGW/include/
export PATH="/usr/$MINGW/bin:$PATH" 
export CROSS_COMPILE=$MINGW-
export HB_PLATFORM=win
export HB_INSTALL_PREFIX=/opt/knowhowERP/hbwin
export HB_COMPILER=mingw
export HB_HOST_BIN_DIR=/usr/bin
export HB_CCPREFIX=$MINGW-
export HB_WITH_OPENSSL=/usr/$MINGW/include
export HB_STATIC_OPENSSL=yes
export HB_WITH_PGSQL=/usr/$MINGW/include

#make HB_HOST_BIN_DIR=/usr/bin HB_BUILD_VERBOSE=1 HB_BUILD_CONTRIBS="hbct hbpgsql sddpg hbgt hbnetio hbmysql hbrun" -C contrib


export HB_USER_CFLAGS="-m32 -I/usr/$MINGW/include"
#export HB_USER_DFLAGS="-m32 -L/usr/lib32"
export HB_USER_LDFLAGS="-m32 -L/usr/$MINGW/lib"
#export HB_WITH_QT=/usr/include/qt5
