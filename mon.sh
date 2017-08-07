#!/bin/bash

if [ -z "$1" ]; then
  MONITOR_FILE=/tmp/.monitors
  COUNT=$(xrandr | grep " connected" | wc -l)

  [ ! -f "$MONITOR_FILE" ] && touch "$MONITOR_FILE"
  MONITOR_COUNT=$(cat "$MONITOR_FILE")
  if [ "$COUNT" == "$MONITOR_COUNT" ]; then
    exit
  else
    echo $COUNT > "$MONITOR_FILE"
    echo Detect Monitors: found $COUNT monitors, adjusting
  fi
fi

SF_OFFICE=$(hwinfo --monitor --short | grep "DELL U2713HM")
HOME_OFFICE=$(hwinfo --monitor --short | grep "DELL U3014")
OAK_OFFICE=

# We're in SF
if [ ! -z "$SF_OFFICE" ]; then
  echo "Switching to SF Office Monitor"
  xrandr --dpi 96
  echo "Xft.dpi: 96" | xrdb -merge
  xrandr --output DP-1 --auto --primary
  xrandr --output eDP-1 --off
elif [ ! -z "$HOME_OFFICE" ]; then
  echo "Switching to Home Office Monitor"
  xrandr --dpi 96
  echo "Xft.dpi: 96" | xrdb -merge
  xrandr --output DP-1 --auto --primary
  xrandr --output eDP-1 --off
# We're in OAK
elif [ ! -z "$OAK_OFFICE" ]; then
  # Just our little lady
  true
else
  echo "Switching to laptop"
  xrandr --dpi 192
  echo "Xft.dpi: 192" | xrdb -merge
  xrandr --output eDP-1 --auto --primary
  xrandr --output DP-1 --off
fi
