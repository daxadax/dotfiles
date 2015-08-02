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

# Start devmon for automounting
devmon &

# Start dunst
dunst -config ~/.dunstrc

# Turn on numlock
numlockx &

# Source bashrc
. ~/.bashrc &

# Start mysql server
connect_to_mysql &

# Start screen locker
xautolock -time 10 -locker "i3lock -c 000000" &

# Start desktop environment
exec i3 -c ~/.i3config -V >> ~/.i3log 2>&1
