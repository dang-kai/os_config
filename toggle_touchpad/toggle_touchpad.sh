#!/bin/bash

declare -i ID
ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
declare -i STATE
STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`
if [ $STATE -eq 1 ]
then
    xinput disable $ID
    echo 0 > /home/dk/433/work/warp/toggle_touchpad/touchpad_status
	notify-send -t 1000 "Touchpad" "Off" -i touchpad-indicator-dark-disabled
else
    xinput enable $ID
    echo 1 > /home/dk/433/work/warp/toggle_touchpad/touchpad_status
	notify-send -t 1000 "Touchpad" "On" -i touchpad-indicator-dark-enabled
fi
