#!/bin/bash

# Execute the update script, making sure that this repo is up to date
DIR=$(cd -- $(dirname -- ${BASH_SOURCE[0]}) && pwd)
. "$DIR/update_this.sh"
EC=$(echo $?)

# If update failed, terminate this
if [[ $EC -ne 0 ]]; then
	exit 1;
fi

# Update repo
git add "$DIR"
git commit -m "AUTO COMMIT"
git push

exit 0
