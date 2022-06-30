#!/bin/sh

## Start KDE

export DESKTOP_SESSION=plasma
exec startplasma-x11

## Start AwesomeWM

# Applications that needs dbus session (like flameshot)
#export $(dbus-launch)

#echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode # use functions keys by default on keychron k2

#xset s off 			  # prevent the screen to switch off after some time
#xset -dpms 				# prevent the screen to switch off after some time
#xset b off 				# disable beep sound in xorg

##dunst &
##redshift &
###ibus-daemon -drx &
#picom --config $HOME/.config/picom/picom.conf --xrender-sync-fence -b
#xrdb ~/.Xresources

#fcitx5 &
#exec ~/.xrequire &
#exec /usr/bin/awesome >> ~/.cache/awesome/stdout.log 2>> ~/.cache/awesome/stderr.log
