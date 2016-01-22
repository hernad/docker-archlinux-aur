# Arch Linux base docker container
# with base-devel group and yaourt installed for aur access
FROM l3iggs/archlinux
MAINTAINER l3iggs <l3iggs@live.com>

# install development packages
RUN pacman -S --noconfirm --needed base-devel

# no sudo password for users in wheel group
RUN sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

# create docker user
RUN useradd -m -G wheel docker
WORKDIR /home/docker

# install yaourt
RUN su -c "(bash <(curl aur.sh) -si --noconfirm package-query yaourt)" -s /bin/bash docker

# the default user is now "docker" and so commands requiring root permissions
# should be prefixed with sudo from now on
USER docker

# clean up
RUN sudo rm -rf /home/docker/*

RUN sudo pacman --noconfirm -S mingw-w64

RUN sudo pacman --noconfirm -S vim
#RUN alias makepkg='makepkg --skippgpcheck'


RUN mkdir /home/docker/.gnupg &&\
    echo "keyserver hkp://pgp.mit.edu" >> /home/docker/.gnupg/gpg.conf  &&\
    echo "keyserver-options auto-key-retrieve" >> /home/docker/.gnupg/gpg.conf &&\
    echo ok 
 
RUN gpg --recv-keys D9C4D26D0E604491  &&\
    yaourt --noconfirm -S mingw-w64-openssl

# install packer and update databases
RUN yaourt -Syyua --noconfirm --needed packer 


# https://aur.archlinux.org/packages/?K=mingw-w64

RUN sudo pacman --noconfirm -S libx11 pcre

RUN yaourt --noconfirm -S ncurses5-compat-libs 
RUN yaourt --noconfirm -S libtinfo

RUN sudo ln -s /usr/sbin/vim /usr/local/bin/vi
RUN sudo ln -s /usr/lib/libpcre.so.1.2.6 /usr/lib/libpcre.so.3

# https://wiki.archlinux.org/index.php/Building_32-bit_packages_on_a_64-bit_system

#RUN sed -e 's/Architecture=.*/Architecture=i686/g' -i /etc/packman.conf

RUN sudo su -c "echo 'EXPORT=2' >> /etc/yaourtrc"

RUN sudo mv /var/cache/pacman/pkg /var/cache/pacman/pkg.orig

RUN sudo mkdir -p /build/pkg && sudo chown docker -R /build
COPY pkg/* /build/pkg/

#RUN sudo pacman -U /var/cache/pacman/pkg/mingw-w64-libiconv-1.14-9-any.pkg.tar.xz
RUN ls /build/pkg ;\
    for f in $(ls -1 /build/pkg/mingw-w64*pkg.tar.xz) ; do sudo pacman --noconfirm -U $f ; done


RUN sudo pacman -S --noconfirm gettext mingw-w64-configure

RUN echo archlib AUR - yaourt

RUN for pkg in mingw-w64-zlib mingw-w64-termcap mingw-w64-libiconv mingw-w64-gettext mingw-w64-libxml2   mingw-w64-postgresql-libs; do \

     ( pacman -Q $pkg 2>/dev/null) || \
     ( echo build package === $pkg ==== ;\
      cd /home/docker ;\ 
     rm -rf $pkg ; yaourt -G $pkg ;\
     cd $pkg ;\
     sed -i -e 's/_architectures=.*/_architectures="i686-w64-mingw32"/g'  PKGBUILD ;\
     makepkg ;\
     if [ $pkg == mingw-w64-libxml2 ] ; then \
       # http://stackoverflow.com/questions/15852677/static-and-dynamic-shared-linking-with-mingw \
       # we want static libxml2.a, but mingw takes first libxml2.dll.a if exists \
       sudo rm /usr/i686-w64-mingw32/lib/libxml2.dll.a ;\
     fi &&\
     sudo pacman --noconfirm -U *.pkg.tar.xz) || \
     exit 1 ;\
    done
    
