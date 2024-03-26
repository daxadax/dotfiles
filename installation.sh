#!/bin/bash

cd dotfiles
./dotfiles_init.sh

# this is important to bring the system up to date
system_update

# install all default packages
for i in $(cat $HOME/.default_packages | xargs -L1); do
  sudo pacman --noconfirm -S $i;
done

# update pkgfile cache
sudo pkgfile --update

# turn off pcspeaker beep
sudo rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

# create vim directories
mkdir $HOME/.vim/backup
mkdir $HOME/.vim/undo

# install solarized colors for gnome-terminal
cd ~
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./install.sh


# install rvm
cd
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
