#!/bin/bash

source ~/sourced-scripts/log.sh
source ~/sourced-scripts/get-path.sh

SCRIPT_DIR=$(getScriptPath)

JSON=$(cat "$SCRIPT_DIR/tmp/updates.json")
EC=$(echo $?)

LOG_TO_FILE "$SCRIPT_DIR/tmp/count-updates.log" "READING: Waybar has finished reading updates.json with Exit Code $EC"

echo "$JSON"
exit 0
