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

# Don't use laptop display at work

if [[ $HOSTNAME = 'trecker' ]]; then
  echo 'trecker'
  xrandr --output eDP-1 --off
fi

# Start devmon for automounting
devmon --exec-on-drive "notify-send '%f has been mounted'" --exec-on-unmount "notify-send '%f has been unmounted'" --exec-on-remove "notify-send '%f has been removed'" &

# Start dunst
dunst -config ~/.dunstrc &

# Set backlight to 50
tee /sys/class/backlight/intel_backlight/brightness <<< 500

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
