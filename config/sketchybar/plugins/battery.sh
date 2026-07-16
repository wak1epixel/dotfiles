#!/usr/bin/env bash
GREEN=0xff9ece6a
YELLOW=0xffe0af68
RED=0xfff7768e
CYAN=0xff7dcfff

PERCENT="$(pmset -g batt | grep -Eo '[0-9]+%' | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep -c 'AC Power')"

[ -z "$PERCENT" ] && exit 0

ICON="󰁹"
if [ "$PERCENT" -ge 60 ]; then COLOR=$GREEN
elif [ "$PERCENT" -ge 30 ]; then COLOR=$YELLOW
else COLOR=$RED; fi

if [ "$CHARGING" -ge 1 ]; then ICON="󰂄"; COLOR=$CYAN; fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PERCENT}%"
