#!/bin/bash

MONFILE=$HOME/.mon
xrandr=xrandr
OPEN=$(cat /proc/acpi/button/lid/LID0/state | grep "open")
EXTRA=
if [ -z "$OPEN" ]; then
  EXTRA="|RXN49"
fi

check_monitors() {
  if [ ! -e $MONFILE ]; then
    touch $MONFILE
  fi

  DIFF=$(diff $MONFILE <(hwinfo --monitor --short | grep -Ev "monitor:$EXTRA"))
  if [ -n "$DIFF" ]; then
    MONCOUNT=$(wc -l <(hwinfo --monitor --short | grep -Ev "monitor:$EXTRA") | awk '{ print $1 }')
    return $MONCOUNT
  fi
  return 0
}

update_monitors() {
  MONCOUNT=$1
  while read line; do
    match_monitor $MONCOUNT "$line"
  done < <(hwinfo --monitor --short | grep -Ev "monitor:$EXTRA")

  if [ -n "$OPEN" ]; then
    if [ $MONCOUNT -eq 1 ]; then
      enable_laptop_primary
      disable_external
    else
      enable_laptop_left
    fi
  else
    disable_laptop
  fi
}

match_monitor() {
  MONCOUNT=$1
  MONITOR=$2
  echo $MONITOR
  case "$MONITOR" in
    "DELL U3014")
      enable_enable
      ;;
    "DELL U2715H")
      enable_twentyseven
      ;;
    "DELL U2713HM")
      enable_twentyseven
      ;;
    "Lenovo LEN T2424pA")
      enable_twentyfour
      ;;
  esac
}

disable_external() {
  echo "Disable External"
  $xrandr --output DP-1 --off
}

disable_laptop() {
  echo "Disable Laptop"
  $xrandr --output eDP-1 --off
}

enable_laptop_primary() {
  echo "Enable Laptop Primary"
  $xrandr --dpi 192
  echo "Xft.dpi: 192" | xrdb -merge
  $xrandr --output eDP-1 --auto --primary
}

enable_laptop_left() {
  echo "Enable Laptop Left"
  $xrandr --output eDP-1 --auto --left-of DP-1
}

enable_thirty() {
  echo "Enable Dell 30"
  $xrandr --dpi 96
  echo "Xft.dpi: 96" | xrdb -merge
  $xrandr --output DP-1 --auto --primary
}

enable_twentyseven() {
  echo "Enable Dell 27"
  $xrandr --dpi 96
  echo "Xft.dpi: 96" | xrdb -merge
  $xrandr --output DP-1 --auto --primary
}

enable_twentyfour() {
  echo "Enable Lenovo 24"
  $xrandr --dpi 96
  echo "Xft.dpi: 96" | xrdb -merge
  $xrandr --output DP-1 --auto --primary
}

remember_monitors() {
  hwinfo --monitor --short | grep -Ev "monitor:$EXTRA" > $HOME/.mon
}


if [ -n "$1" ]; then
  rm $MONFILE
fi

check_monitors
result=$?
if [ $result -eq 0 ]; then
  exit 0
fi

set -e
update_monitors $result

remember_monitors
