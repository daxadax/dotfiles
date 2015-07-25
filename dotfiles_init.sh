#!/bin/bash
#dotfiles_init.sh

### Variables ###

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

files="bash_profile gitconfig i3status.conf screenrc bashrc i3config profile
xinitrc vimrc default_packages gemrc"   

folders="vim aliases"

###

echo -n "Creating $olddir for backup of any existing dotfiles in home directory"
mkdir -p $olddir
echo "done"

cd $dir

echo "Backing up and creating symlinks to the following files:"

for file in $files; do
  mv ~/.$file ~/dotfiles_old/
  echo "$file"
  ln -s $dir/$file ~/.$file
done

echo "Done.  Beginning directories"

for folder in $folders; do 
  cp -r ~/.$folder/ ~/dotfiles_old/
  rm -rf ~/.$folder
  echo "Creating symlink to $folder in home directory"
  ln -s $dir/$folder ~/.$folder
done

echo "Done.  Backups can be found in $olddir"
