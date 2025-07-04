#!/bin/bash

active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
screenshot_filename="$HOME/Pictures/screenshots/$(date +"%d-%m-%Y-%H%S")-$active_window_class.png"

hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "$screenshot_filename"

if [ -e "$screenshot_filename" ]; then
  notify-send -i "$screenshot_filename" "Grim" "Active Window Screenshot Saved \n $screenshot_filename"
  wl-copy <"$screenshot_filename"
fi
