#!/bin/bash

# Give Hyprland a moment to initialize the monitors
sleep 1

# If there is more than one monitor, move the laptops screen to display workspace 9
if (( $(hyprctl monitors -j | jq length) > 1 )); then
    hyprctl dispatch focusmonitor eDP-1
    hyprctl dispatch workspace 9
fi
