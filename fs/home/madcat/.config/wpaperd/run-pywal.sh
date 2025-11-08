#!/bin/bash

MONITOR=$1	# Name of Monitor
WALLPAPER=$2	# Path to current wallpaper

# -q Executes wal in quiet mode, meaning it'll print nothing
# -n Prevents wal from attempting to set the wallpaper (fails anyways)
# -i <PATH> defines which image to generate the color scheme from
wal -q -n -i "$WALLPAPER"
source "~/.cache/wal/colors.sh"
