#!/bin/sh

if [ $(xrandr | grep VGA-1 | cut -d ' ' -f 2) = "connected" ]; then
  xrandr --output VGA-1 --auto --output LVDS-1 --off
  xset s off 			  # prevent the screen to switch off after some time ###
  xset -dpms 				# prevent the screen to switch off after some time ###
  xset b off 				# disable beep sound in xorg
  chromium &
  telegram &
  sleep 1
  notify-send -t 10000 "Appointments" "$(calcurse -r7 --output-datefmt '%a, %d' --format-apt ' - %m (%S to %E)\n' --format-recur-apt ' - %m (%S to %E)\n')"
fi

setxkbmap -model thinkpad60 -layout br
setxkbmap -option caps:swapescape	# swap caps and esc

redshift &
$HOME/.fehbg &
mpd &
ibus-daemon -drx &

compton --config $HOME/.config/compton/compton.conf -b
headphone-bluetooth connect

# Prevent Android Studio from showing blank screens
export _JAVA_AWT_WM_NONREPARENTING=1

exec dwmblocks &
exec dwm
