#!/bin/bash


CARD1_NAME="Speakers"
CARD2_NAME="Headphones"

CARD1_SINK="alsa_output.usb-Burr-Brown_from_TI_USB_Audio_DAC-00.analog-stereo"
CARD2_SINK="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"

DEFAULT_SINK=$(pactl get-default-sink)

CARD1_INDEX=$(pactl list short sinks | grep $CARD1_SINK | awk '{ print $1 }')
CARD2_INDEX=$(pactl list short sinks | grep $CARD2_SINK | awk '{ print $1 }')


CURRENT=CARD1

if [[ "$DEFAULT_SINK" == "$CARD2_SINK" ]]; then
  CURRENT=CARD2
fi

current_index_var=${CURRENT}_INDEX
current_name_var=${CURRENT}_NAME
CURRENT_INDEX=${!current_index_var}
CURRENT_NAME=${!current_name_var}


function set_sink() {
  TARGET_SINK=$1
  index=${TARGET_SINK}_INDEX
  name=${TARGET_SINK}_NAME
  pactl set-default-sink ${!index}
  notify-send --transient --expire-time=1000 "Sound:" "Sink: ${!name}"
}

function toggle_sink() {
  if [[ "$CURRENT" == "CARD1" ]]; then
    set_sink CARD2
  else
    set_sink CARD1
  fi
}

function volume_up() {
  pactl set-sink-volume $CURRENT_INDEX +5%
  VOL=$(pactl get-sink-volume $CURRENT_INDEX | grep Volume | awk '{print $5}')
  notify-send --transient --expire-time=1000 "Sound:" "$CURRENT_NAME: $VOL"
}

function volume_down() {
  pactl set-sink-volume $CURRENT_INDEX -5%
  VOL=$(pactl get-sink-volume $CURRENT_INDEX | grep Volume | awk '{print $5}')
  notify-send --transient --expire-time=1000 "Sound:" "$CURRENT_NAME: $VOL"
}

function toggle_mute() {
  pactl set-sink-mute $CURRENT_INDEX toggle
  MUTED=$(pactl get-sink-mute $CURRENT_INDEX | awk '{print $2}')
  if [[ "$MUTED" == "no" ]]; then
    msg="unmuted"
  else
    msg="muted"
  fi
  notify-send --transient --expire-time=1000 "Sound:" "$CURRENT_NAME: $msg"
}

if [[ "$1" == "toggle_sink" ]]; then
  toggle_sink
elif [[ "$1" == "volume_up" ]]; then
  volume_up
elif [[ "$1" == "volume_down" ]]; then
  volume_down
elif [[ "$1" == "toggle_mute" ]]; then
  toggle_mute
fi
