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
devmon --exec-on-drive "notify-send '%f has been mounted'" --exec-on-unmount "notify-send '%f has been unmounted'" --exec-on-remove "notify-send '%f has been removed'" &

# Start dunst
dunst -config ~/.dunstrc &

# Set backlight to 50
tee /sys/class/backlight/intel_backlight/brightness <<< 500 &

# Turn on numlock
numlockx &

# Start ibus daemon for input switching
ibus-daemon -drxR &

# Source bashrc
. ~/.bashrc &

# set up monitors on desktop
HOSTNAME=$(whoami)
if [ $HOSTNAME == "hagbard" ];
then
  xrandr --output DVI-I-1 --rotate right
  xrandr --output HDMI-0 --auto --right-of DVI-I-1
fi

## start planetary rulers script
ruby ~/programming/scripts/planetary_rulers.rb &

# Start screen locker
xautolock -time 20 -locker "i3lock -c 000000" &

# Start desktop environment
exec i3 -c ~/.i3config
