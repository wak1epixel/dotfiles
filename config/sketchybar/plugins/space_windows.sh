#!/usr/bin/env bash
export PATH="/opt/homebrew/bin:$PATH"
CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/plugins/icon_map.sh"

FOCUS_BG=0xffe3d18a
ITEM_BG=0xff191c2c
DIM=0xff9d8f63
DARK=0xff0e101a

[ -z "$FOCUSED_WORKSPACE" ] && FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"

for sid in 1 2 3 4 5; do
  apps="$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null)"
  icon_strip=""
  if [ -n "$apps" ]; then
    while read -r app; do
      [ -z "$app" ] && continue
      __icon_map "$app"
      icon_strip+=" $icon_result"
    done <<< "$apps"
  fi

  if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set space.$sid background.color=$FOCUS_BG icon.color=$DARK label="$icon_strip" label.color=$DARK
  else
    sketchybar --set space.$sid background.color=$ITEM_BG icon.color=$DIM label="$icon_strip" label.color=$DIM
  fi
done
