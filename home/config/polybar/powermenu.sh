#!/bin/bash

## Rofi Power Menu

# Options with icons
logout="⏏ Logout"
lock=" Lock"
suspend="⏸︎ Suspend"
reboot="↻ Reboot"
shutdown=" Shutdown"

# Get user selection
chosen=$(echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | rofi -dmenu -p "Power Menu" -i)

# Execute the chosen command
case "$chosen" in
    "$lock")
        betterlockscreen -l
        ;;
    "$logout")
        i3-msg exit
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$reboot")
        sudo reboot
        ;;
    "$shutdown")
        sudo shutdown -r now
        ;;
esac
