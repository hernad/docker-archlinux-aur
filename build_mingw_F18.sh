#!/bin/bash

echo "build F18 mingw"

cd /build/F18_knowhow/
source scripts/linux.sh 
source /set_mingw_cross_build.sh 

export HB_ARCHITECTURE=win
export HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 
hbmk2 F18_string.hbp 
hbmk2 F18_narudzbenica.hbp 
hbmk2 F18.hbp
#wine F18.exe --version
VERSION=`cat VERSION`
scripts/build_gz.sh 
