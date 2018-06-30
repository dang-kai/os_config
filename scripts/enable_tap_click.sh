#!/bin/bash

declare -i ID
ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`

declare -i TAP
TAP=`xinput list-props $ID | grep -Eo 'Tapping Enabled \([0-9]{3}\)' | grep -Eo '[0-9]{3}'`
declare -i SRO
SRO=`xinput list-props $ID | grep -Eo 'Natural Scrolling Enabled \([0-9]{3}\)' | grep -Eo '[0-9]{3}'`

xinput set-prop $ID $TAP 1
xinput set-prop $ID $SRO 0

