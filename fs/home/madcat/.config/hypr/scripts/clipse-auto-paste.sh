#!/bin/bash

# NOTE: This script is intended to be run after pressing enter on an entry in clipse. Per default, clipse just copies it to the clipboard, but I want it to immediately paste. This script makes sure that works as intended.

# If the active window is neovim, use the key combination to paste in normal mode rather than the normal paste combination
ACTIVE_WINDOW=$(hyprctl activewindow -j | jq -r '.title')

if [[ $ACTIVE_WINDOW == "neovim" ]]; then
	wtype -k p
else
	wtype -M ctrl -k v -m ctrl
fi
