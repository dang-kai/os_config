#!/bin/bash

STATE=`cat /home/dk/433/system/install_archlinux/toggle_touchpad/touchpad_status`

declare -i ID
ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
if [ $STATE -eq 0 ]
then
    xinput disable $ID
	notify-send -t 1000 "Touchpad" "Off" -i touchpad-indicator-dark-disabled;
else
    xinput enable $ID
	notify-send -t 1000 "Touchpad" "On" -i touchpad-indicator-dark-enabled;
fi
