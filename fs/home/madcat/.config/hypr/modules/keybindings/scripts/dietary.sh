#!/bin/bash

FRONT="$HOME/code/dietary/mobile"
BACK="$HOME/code/dietary/backend/"

# Get list of non-empty workspaces
NON_EMPTY_WORKSPACES=$(hyprctl clients -j \
| jq -r '.[].workspace.id' \
| sort -n \
| uniq)

# Check if the relevant workspaces are in there
echo "$NON_EMPTY_WORKSPACES" | grep -qx 3
W3E=$?
echo "$NON_EMPTY_WORKSPACES" | grep -qx 4
W4E=$?

# If relevant workspaces are already used, exit
if (( W3E == 0 || W4E == 0 )); then
	notify-send "Setting up DIETARY failed, workspaces 3 and/or 4 are not empty." -u critical -t 3000
	exit 1
fi

# Shortcut
ALA_FRONT="alacritty --working-directory $FRONT"

# NOTE: This makes sure the terminal can be used normally after it's initial command is done
tmpy() {
	WID=$1
	START=$2
	CMD=$3

	hyprctl dispatch exec [workspace "$WID" silent] \
		"$START -e bash -ic \"$CMD; exec bash -i\""
}

# Setting up workspace 1 terminal
hyprctl dispatch exec [workspace 1 silent] "$ALA_FRONT"

# Starting metro dev server
tmpy 3 "$ALA_FRONT" "npm start -- --reset-cache"

# Starting waydroid and running bundler
tmpy 3 "$ALA_FRONT" "npm run waydroid"

# Starting backend
# FIX: Cant execute the startServer script because direnv only loads the VENV variables after this is done, meaning we do not have access to the fastapi command
tmpy 4 "alacritty" "cd $BACK && dcp up -d"
tmpy 4 "alacritty" "cd $BACK"

# Preparing terminal to access db
tmpy 5 "alacritty" "cd $BACK && source ./scripts/enterDb.sh"
