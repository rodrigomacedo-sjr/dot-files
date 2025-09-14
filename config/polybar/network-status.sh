#!/bin/bash

# A script to dynamically display network status for Polybar.
# Shows ethernet status if connected, otherwise shows Wi-Fi status.

# --- How to find your interface names ---
# Run `ip addr` in your terminal.
# Your ethernet interface will likely be something like 'enp2s0', 'eno1', or 'eth0'.
# Your Wi-Fi interface will likely be 'wlan0' or start with 'wlp'.

WIRED_INTERFACE="enp2s0"
WIRELESS_INTERFACE="wlo1"

# Check for a wired connection
# The `grep 'state UP'` check is a reliable way to see if the cable is plugged in and active.
if ip addr show $WIRED_INTERFACE | grep -q "state UP"; then
    IP_ADDR=$(ip -4 addr show $WIRED_INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo " $IP_ADDR"
# Check for a Wi-Fi connection
# `iwgetid -r` will successfully print the network name (ESSID) if connected.
elif iwgetid -r $WIRELESS_INTERFACE > /dev/null 2>&1; then
    ESSID=$(iwgetid -r $WIRELESS_INTERFACE)
    echo " $ESSID"
# If neither are connected
else
    echo " Disconnected"
fi


