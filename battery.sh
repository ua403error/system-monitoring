#!/bin/bash
sess_id=`pgrep -u $LOGNAME gnome-session | head -n1`
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$sess_id/environ)";

per=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}'`
percentage=${per::-1}
state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{print $2}'`

if [ $percentage -gt 95 ] && [ $state == "charging" ]; then
    DISPLAY=:0 /usr/bin/notify-send -u normal -t 5000 -i battery-full-symbolic "Battery is full."
fi


