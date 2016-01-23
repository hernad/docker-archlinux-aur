    1  source /mingw_cross_build.sh 
    2  set
    3  cd /build/hbwin
    4  ls
    5  ls /usr/i686-w64-mingw32/
    6  make DEST=/usr/i686-w64-mingw32 install
    7  make HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 install
    8  sudo make HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 install
    9  sudo chown docker -R /usr/i686-w64-mingw32 
   10  make HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 install
   11  cd ..
   12  cd F18_knowhow/
   13  ls
   14  source scripts/linux.sh 
   15  hbmk2 F18_string.hbp 
   16  export HB_INSTALL_PREFIX=/usr/i686-w64-mingw32 
   17  hbmk2 F18_string.hbp 
   18  source /mingw_cross_build.sh 
   19  hbmk2 F18_string.hbp 
   20  hbmk2 F18_narudzbenica.hbp 
   21  hbmk2 F18.hbp
   22  ls /i686-w64-mingw32/
   23  ls /usr/i686-w64-mingw32/
   24  ls /usr/i686-w64-mingw32/lib
   25  ls /usr/i686-w64-mingw32/lib/win
   26* ls /usr/i686-w64-mingw32/lib/win/mingw/*
   27  mv /usr/i686-w64-mingw32/lib/win/mingw/* /usr/i686-w64-mingw32/lib/
   28  hbmk2 F18.hbp
   29  wine F18.exe
   30  history
