#!/bin/bash

# Get the current timestamp for the filename
window_class_name=$(hyprctl activewindow | grep 'class:' | awk '{print $2}')
screenshot_filename="$HOME/Pictures/screenshots/$(date +"%d-%m-%Y-%H%S")-$window_class_name.png"

# Capture the selected region using slurp and save it
grim -g "$(slurp)" "$screenshot_filename"

# Copy the screenshot to the clipboard
if [ -e "$screenshot_filename" ]; then
  notify-send -i "$screenshot_filename" "Grim" " Screenshot Saved \n $screenshot_filename"
  wl-copy <"$screenshot_filename"
fi
