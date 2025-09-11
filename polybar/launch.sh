#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
echo "---" | tee -a /tmp/polybar_main.log
polybar main >>/tmp/polybar_main.log 2>&1 &

echo "Bar launched..."
