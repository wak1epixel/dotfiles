#!/usr/bin/env bash
GREEN=0xff9ece6a
YELLOW=0xffe0af68
RED=0xfff7768e

cpu=$(top -l 2 -n 0 | grep -E "^CPU usage" | tail -1 | awk '{u=$3+0; s=$5+0; printf "%.0f", u+s}')
[ -z "$cpu" ] && exit 0

if [ "$cpu" -ge 70 ]; then COLOR=$RED
elif [ "$cpu" -ge 40 ]; then COLOR=$YELLOW
else COLOR=$GREEN; fi

sketchybar --set "$NAME" icon="󰻠" icon.color=$COLOR label="${cpu}%"
