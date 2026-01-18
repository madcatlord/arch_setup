#!/bin/bash

source ~/sourced-scripts/get-path.sh

# Execute the update script, making sure that this repo is up to date
DIR=$(getScriptPath)
. "$DIR/update_this.sh"
EC=$(echo $?)

source ~/sourced-scripts/log.sh
LOG_TO_FILE "$DIR/backup.logs" "User performing actions: $USER, ID: $UID"
LOG_TO_FILE "$DIR/backup.logs" "UpdateThis exit code: $EC"
LOG_TO_FILE "$DIR/backup.logs" "Pubkey results: $(ssh -vT git@github.com 2>&1 | rg ": loaded pubkey")" # FIX: This shoud show whether or not ssh key works properly

# If update failed, terminate this
if [[ $EC -ne 0 ]]; then
	exit 1
fi

# Check for internet connection
if ! ping -c 1 8.8.8.8; then
	LOG_TO_FILE "$DIR/backup.logs" "No internet connection."
	exit 1
fi

# Update repo
git add "$DIR"
LOG_TO_FILE "$DIR/backup.logs" "'git add $DIR' exit code. $?"
git commit -m "AUTO COMMIT $(date +'%d.%m.%Y')"

if [[ $(echo $?) -eq 0 ]]; then
	git push
fi

exit 0
