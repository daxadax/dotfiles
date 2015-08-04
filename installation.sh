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

# create vim directories
mkdir $HOME/.vim/backup
mkdir $HOME/.vim/undo

# conditionally install rvm
# see possible implementation here 
# http://stackoverflow.com/a/21128172/2128691
#
#curl -sSL https://get.rvm.io | bash -s stable
