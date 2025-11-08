#!/bin/bash

killall waybar

# Optionally open the GTK_INSPECTOR along with waybar
if [[ $1 -eq 1 ]]; then
	GTK_DEBUG=interactive waybar
else
	waybar
fi

