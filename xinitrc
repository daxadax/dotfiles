#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start udiskie for automounting usb devices
udiskie &

# Source bashrc
. ~/.bashrc &

# Add key for ssh-agent
exec eval ssh-agent -s &
exec ssh-add ~/.ssh/neo & 
exec ssh-add ~/.ssh/id_rsa.pub &

# Start mysql server
exec mysql start &

# Start desktop environment
exec i3 -c ~/.i3config
