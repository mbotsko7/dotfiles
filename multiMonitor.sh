#!/bin/bash
EXTERNAL_OUTPUT1="DP-1"
EXTERNAL_OUTPUT2="DP-2"
INTERNAL_OUTPUT="eDP-1"

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT1 --auto --output $EXTERNAL_OUTPUT2 --auto --right-of $EXTERNAL_OUTPUT1
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT1 --off --output $EXTERNAL_OUTPUT2 --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT1 --auto --same-as $INTERNAL_OUTPUT --output $EXTERNAL_OUTPUT2 --auto --same-as $INTERNAL_OUTPUT
else
        monitor_mode="all"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT1 --auto --right-of $INTERNAL_OUTPUT --output $EXTERNAL_OUTPUT2 --auto --right-of $EXTERNAL_OUTPUT1
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
