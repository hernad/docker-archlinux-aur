#!/bin/bash

echo "build harbour mingw"

source /set_mingw_cross_build.sh 
sudo chown docker -R /usr/i686-w64-mingw32 

cd /home/harbour/harbour-core
make
make HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 install   
mv /usr/i686-w64-mingw32/lib/win/mingw/* /usr/i686-w64-mingw32/lib/


