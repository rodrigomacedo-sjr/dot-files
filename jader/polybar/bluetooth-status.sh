#!/bin/bash

status=$(bluetoothctl show | grep "Powered: yes")
connected=$(bluetoothctl info | grep "Connected: yes")

if [ -z "$status" ]; then
    echo " off"
elif [ -n "$connected" ]; then
    echo " on"
else
    echo " idle"
fi

