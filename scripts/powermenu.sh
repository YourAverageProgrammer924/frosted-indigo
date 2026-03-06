#!/bin/bash

# Define the options with Nerd Font icons
entries="󰐥 Power Off\n󰜉 Reboot\n󰤄 Suspend\n󰍃 Logout\n󰗼 Cancel"

# Pipe them into wofi with your glassy theme
selected=$(echo -e "$entries" | wofi --dmenu --cache-file /dev/null --prompt "Power Menu" --width 400 --height 250)

# Execute based on selection
case $selected in
  *Power\ Off)
    systemctl poweroff ;;
  *Reboot)
    systemctl reboot ;;
  *Suspend)
    systemctl suspend ;;
  *Logout)
    hyprctl dispatch exit 0 ;;
  *Cancel)
    exit 0 ;;
esac
