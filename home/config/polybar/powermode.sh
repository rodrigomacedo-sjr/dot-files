#!/bin/bash

## Rofi Power Profile Selector

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Rofi menu options with icons
performance=" Performance"
balanced=" Balanced"
saver=" Power Saver"

# Show Rofi menu and get user selection
chosen=$(echo -e "$performance\n$balanced\n$saver" | rofi -dmenu -p "Power Profile" -mesg "Current: $current_profile" -i)

# Set the new power profile based on selection
case "$chosen" in
    "$performance")
        powerprofilesctl set performance
        notify-send "Power Profile" "Switched to Performance mode."
        ;;
    "$balanced")
        powerprofilesctl set balanced
        notify-send "Power Profile" "Switched to Balanced mode."
        ;;
    "$saver")
        powerprofilesctl set power-saver
        notify-send "Power Profile" "Switched to Power Saver mode."
        ;;
esac
