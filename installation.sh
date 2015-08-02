#!/bin/bash

# clone necessary files
git clone https://github.com/daxadax/dotfiles.git
cd dotfiles
./dotfiles_init.sh


# install all default packages
for i in $(cat $HOME/.default_packages | xargs -L1); do sudo pacman -S $i; done

# update pkgfile cache
pkgfile --update

# turn off pcspeaker beep
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

# add udiskie permissions for 'wheel' members
mkdir - p /etc/polkit-1/localauthority/50-local.d/
local udiskie_file='/etc/polkit-1/localauthority/50-local.d/10-udiskie.pkla'
echo '[udiskie]' >> udiskie_file
echo 'Identity=unix-group:wheel' >> udiskie_file
echo
'Action=org.freedesktop.udisks.filesystem-mount;org.freedesktop.udisks.drive-eject;org.freedesktop.udisks.drive-detach' >> udiskie_file
echo 'ResultAny=yes' >> udiskie_file

# create vim directories
mkdir $HOME/.vim/backup
mkdir $HOME/.vim/undo

# install rvm
curl -sSL https://get.rvm.io | bash -s stable

# update pkgfile
pkgfile --update
