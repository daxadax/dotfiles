#!/bin/sh
#
# ~/.xinitrc
#
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start devmon for automounting
devmon  --exec-on-drive "notify-send '%f has been mounted'" \
        --exec-on-unmount "notify-send '%f has been unmounted'" \
        --exec-on-remove "notify-send '%f has been removed'" &

# Start dunst
dunst -config ~/.dunstrc &

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
elif [ $HOSTNAME == "corwin" ];
then
  xrandr --output DP-1 --rotate right
  xrandr --auto --output HDMI-1-2 --mode 2560x1440 --primary --right-of DP-1
fi

## start planetary rulers script
ruby ~/programming/scripts/planetary_rulers.rb &

# Start desktop environment
exec i3 -c ~/.config/i3/config
