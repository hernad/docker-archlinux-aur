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


# install packer and update databases
RUN yaourt -Syyua --noconfirm --needed packer

RUN sudo pacman --noconfirm -S mingw-w64

RUN sudo pacman --noconfirm -S vim
#RUN alias makepkg='makepkg --skippgpcheck'


RUN mkdir /home/docker/.gnupg &&\
    echo "keyserver hkp://pgp.mit.edu" >> /home/docker/.gnupg/gpg.conf  &&\
    echo "keyserver-options auto-key-retrieve" >> /home/docker/.gnupg/gpg.conf &&\
    echo ok 
 
RUN gpg --recv-keys D9C4D26D0E604491  &&\
    yaourt --noconfirm -S mingw-w64-openssl


# https://aur.archlinux.org/packages/?K=mingw-w64
RUN yaourt --noconfirm -S mingw-w64-postgresql-libs

RUN pacman --noconfirm -S libx11 pcre

RUN yaourt --noconfirm -S ncurses5-compat-libs 
RUN yaourt --noconfirm -S libtinfo

RUN ln -s /usr/sbin/vim /usr/local/bin/vi
RUN ln -s /usr/lib/libpcre.so.1.2.6 /usr/lib/libpcre.so.3

RUN sudo su -c "echo 'EXPORT=2' >> /etc/yaourtrc"

RUN sudo mv /var/cache/pacman/pkg /var/cache/pacman/pkg.orig

ADD pkg/* /build/pkg/
RUN sudo mkdir -p /build ; sudo ln -s /build/pkg /var/cache/pacman/pkg 
RUN sudo pacman -U /var/cache/pacman/pkg/mingw-w64-libiconv-1.14-9-any.pkg.tar.xz

