#!/bin/bash
function restart {
  if  ps x | rg  $1 | awk '{print $1}'; then
    pkill -f $1
  fi
  $1 $2 $3 $4 &
}

restart dbus-launch --sh-syntax
restart dunst
greenclip daemon &!
restart betterlockscreen -w
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
restart /usr/lib/xfce-polkit/xfce-polkit
restart udiskie -as
sleep 1s;restart picom

if [ -f "$HOME/.local-machine" ] ; then
  source ~/.local-machine
fi
notify-send "Welcome Back" &
