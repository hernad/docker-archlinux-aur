#!/bin/bash

echo "build harbour mingw"

echo "/usr/include bothers mingw compilation"
sudo mv /usr/include /usr/include.orig 

source /set_mingw_cross_build.sh 
sudo chown docker -R /usr/i686-w64-mingw32 

cd /home/docker/harbour-core
make
make HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 install   
#mv /usr/i686-w64-mingw32/lib/win/mingw/* /usr/i686-w64-mingw32/lib/


