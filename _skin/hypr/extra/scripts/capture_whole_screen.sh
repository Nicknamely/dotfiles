#!/bin/bash

# Get the current timestamp for the filename
active_workspace=$(hyprctl monitors | grep "active workspace" | awk '{print $3}')
screenshot_filename="$HOME/Pictures/screenshots/$(date +"%d-%m-%Y-%H%S")-$active_workspace.png"
# Capture the entire screen and save it
grim "$screenshot_filename"

# Copy the screenshot to the clipboard

if [ -e "$screenshot_filename" ]; then
  notify-send -i "$screenshot_filename" "Grim" "Workspace Saved \n $screenshot_filename"
  wl-copy <"$screenshot_filename"
fi
