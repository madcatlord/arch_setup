#!/bin/bash

# NOTE: This script is intended to be run after pressing enter on an entry in clipse. Per default, clipse just copies it to the clipboard, but I want it to immediately paste. This script makes sure that works as intended.

# If the active window is neovim, use the key combination to paste in normal mode rather than the normal paste combination
ACTIVE_WINDOW=$(hyprctl activewindow -j | jq -r '.title')

if [[ $ACTIVE_WINDOW == "neovim" ]]; then
	wtype -k p
elif [[ $ACTIVE_WINDOW == "Alacritty" ]]; then
	# This looks like much, but its just ctrl+shift+v, since thats what you need to do in the terminal. I also let it press the right arrow key afterwards, in order to remove the highlighting that Alacritty automaticall adds
	wtype -M ctrl -M shift -k v -m ctrl -m shift -k right
else
	wtype -M ctrl -k v -m ctrl
fi
