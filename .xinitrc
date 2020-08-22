#!/bin/sh

if [ $(xrandr | grep VGA-1 | cut -d ' ' -f 2) = "connected" ]; then
  xrandr --output VGA-1 --auto --output LVDS-1 --off
  xset s off 			  # prevent the screen to switch off after some time ###
  xset -dpms 				# prevent the screen to switch off after some time ###
  xset b off 				# disable beep sound in xorg
  chromium &
  sleep 1
fi

setxkbmap -model thinkpad60 -layout br
setxkbmap -option caps:swapescape	# swap caps and esc

redshift &
$HOME/.fehbg &
mpd &
ibus-daemon -drx &

compton --config $HOME/.config/compton/compton.conf -b

exec dwmblocks &
exec dwm
