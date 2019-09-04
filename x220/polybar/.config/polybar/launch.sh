#!/usr/bin/env bash

# Terminate already running bar intances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar Bar -c ~/.config/polybar/config &

echo "Bars launched.."