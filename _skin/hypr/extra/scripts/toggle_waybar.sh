#!/bin/bash
# script to toggle waybar

if pgrep -x "waybar" >/dev/null; then
  pkill waybar
else
  waybar &
fi
