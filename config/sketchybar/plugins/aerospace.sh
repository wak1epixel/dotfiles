#!/usr/bin/env bash
export PATH="/opt/homebrew/bin:$PATH"

ITEM_BG=0xff24283b
FOCUS_BG=0xffbb9af7   # purple
GREY=0xff565f89
DARK=0xff1a1b26

# On a switch event AeroSpace hands us $FOCUSED_WORKSPACE; otherwise ask it.
if [ "$SENDER" = "aerospace_workspace_change" ]; then
  focused="$FOCUSED_WORKSPACE"
else
  focused="$(aerospace list-workspaces --focused)"
fi

for sid in 1 2 3 4 5; do
  if [ "$sid" = "$focused" ]; then
    sketchybar --set space.$sid background.color=$FOCUS_BG icon.color=$DARK
  else
    sketchybar --set space.$sid background.color=$ITEM_BG icon.color=$GREY
  fi
done
