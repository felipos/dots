#!/bin/sh

if [ $(xrandr | grep VGA-1 | cut -d ' ' -f 2) = "connected" ]; then
  xrandr --output VGA-1 --auto --output LVDS-1 --off
  xset s off 			  # prevent the screen to switch off after some time
  xset -dpms 				# prevent the screen to switch off after some time
  xset b off 				# disable beep sound in xorg
  firefox-bin &
  telegram &
  sleep 1
  notify-send -t 10000 "Appointments" "$(calcurse -r7 --output-datefmt '%a, %d' --format-apt ' - %m (%S to %E)\n' --format-recur-apt ' - %m (%S to %E)\n')"
  sleep 10
fi

bash $HOME/.config/scripts/birthdays

setxkbmap -model thinkpad60 -layout br
setxkbmap -option caps:swapescape	# swap caps and esc

redshift &
$HOME/.fehbg &
mpd &
ibus-daemon -drx &
st -e tmux &
headphone-bluetooth connect &
xrdb ~/.Xresources

compton --config $HOME/.config/compton/compton.conf -b
numlockx on
sudo cpupower frequency-set -u 1200Mhz && notify-send "CPU Clock" "Maximum frequency setted to 1200Mhz"

# prevent Android Studio from showing blank screens
export _JAVA_AWT_WM_NONREPARENTING=1
# required for applications that needs dbus session
export $(dbus-launch)

exec dwmblocks &
exec dwm 2> ~/.config/dwm/dwm.log
