#!/bin/bash

# IMPORTS
source ~/sourced-scripts/log.sh
source ~/sourced-scripts/get-path.sh

### ATTRIBUTES
DATA_FILEPATH_RELATIVE="tmp/updates.json"
TIMEOUT=5
MIN_TOTAL_UPDATES=50



# Getting the absolute path of this script and defining the path to the file, that will contain the results of this script
SCRIPT_DIR=$(getScriptPath)
DATA_FILEPATH="$SCRIPT_DIR/$DATA_FILEPATH_RELATIVE"

# Create data dir if it doesnt exist
if [ ! -f "$DATA_FILEPATH" ]; then
	mkdir -p $(dirname "$DATA_FILEPATH")
fi

# TEMPORARY log function for debugging purposes
log() {
	LOG_TO_FILE "$SCRIPT_DIR/tmp/count-updates.log" "$1"
}

# The template which is gonna be filled by jq later
OUTPUT_TEMPLATE='{"text": $text, "alt": $alt, "tooltip": $tt, "class": $class, "percentage": $p}'

### This transforms the given arguments to a single line string of json format, which waybar uses to display the module
toJSON() {
	local JSON=$(\
		jq -n --unbuffered --compact-output \
		--arg text "$1" \
		--arg alt "$2" \
		--arg tt "$3" \
		--arg class "$4" \
		--arg p "$5" \
		"$OUTPUT_TEMPLATE" 
	)
	echo -e "$JSON" > "$DATA_FILEPATH"
	log "Updated JSON data: Processes exited with: $?"
	log "DATA: $JSON"
}

# sends the update signal to waybar, which triggers the re-reading of the data file
# NOTE TEMPORARY FIX: If waybar does not already run, it will be started. This is neccessary, because for some god forsaken reason the `pkill -RTMIN+1 waybar` command right as waybar is starting kills it. This TEMPORARY fix will make sure that when the update is run the second time, waybar is restarted
updateModule() {
	pgrep waybar > /dev/null
	local EC=$(echo $?)
	log "Updating Waybar: Process needs to be started: $EC"

	if [[ $EC -eq 0 ]]; then
		pkill -RTMIN+1 waybar
		log "Updating Waybar: Signal send"
	else
		waybar &
		log "Updating Waybar: Restarting waybar"
	fi
}

# Printing temporary LOADING data to storage
toJSON 'loading' '' '' 'loading' ''
updateModule

### DATA FETCHING ###
log "Fetching Data: Start"
OFFICIAL=$(timeout $TIMEOUT checkupdates --nocolor)
OFFICIAL_EXIT=$(echo $?)

if [[ $OFFICIAL_EXIT -eq 1 ]]; then
	log "ERROR: Fetching Data of official repository exited with Code $OFFICIAL_EXIT. The resulting message will be logged in the following."
	log "ERROR: $OFFICIAL"
fi

AUR=$(timeout $TIMEOUT yay -Qua)
AUR_EXIT=$(echo $?)

if [[ $AUR_EXIT -gt 1 ]]; then
	log "ERROR: Fetching Data of AUR exited with Code $AUR_EXIT. The resulting message will be logged in the following."
	log "ERROR: $AUR"
fi

log "Fetching Data: Done"

# Making sure the request was successful
# NOTE AUR_EXIT exits with 1 if nothing was found
if [[ OFFICIAL_EXIT -eq 1 || AUR_EXIT -gt 1 ]]; then
	TOOLTIP="EXIT_CODE_PAC: $OFFICIAL_EXIT\nEXIT_CODE_AUR: $AUR_EXIT"

	toJSON "ERR" "" "$TOOLTIP" "error" ""
	updateModule

	log "ERROR: Data fetching was unsuccessful. Exiting with Code 1"
	exit 0 # NOTE: Trying to exit with 0, since for some reason waybar doesnt boot up when we exit with 1
fi

# NOTE subtracting 1 because there always is a final newline which is counted as well
log "Calculating: Package counts"
AMT_OFFICIAL=$(($(echo "$OFFICIAL" | wc -l) - 1))
AMT_AUR=$(($(echo "$AUR" | wc -l) - 1))
log "Calculating: Done"

# Getting all the major versions. Every second entry is the new major version
log "Calculating: Major Versions"
MAJ_OFFICIAL=$(echo "$OFFICIAL" | rg -P -o '(?<= )\d+')
MAJ_OFFICIAL_AMT=0
LINE_CNT=1
PREV_NUM=""

while IFS= read -r line; do
	if [[ $(($LINE_CNT % 2)) -eq 1 ]]; then
		PREV_NUM="$line"
	else
		if [[ $PREV_NUM -lt $line ]]; then
			((MAJ_OFFICIAL_AMT++))
		fi
	fi

	((LINE_CNT++))
done <<< "$MAJ_OFFICIAL"
log "Calculating: Done"

### Putting the Output together ###
TEXT="$AMT_OFFICIAL 󰮯 | $AMT_AUR "
ALT=""
TOOLTIP="\
MAJOR UPDATES\n\
PAC: $MAJ_OFFICIAL_AMT\n\
AUR: TODO\
"
CLASS=""
PERCENTAGE=""

if [[ $(($AMT_OFFICIAL + $AMT_AUR)) -gt $MIN_TOTAL_UPDATES ]]; then
	CLASS="rec-update"
fi


# Output final result
toJSON "$TEXT" "$ALT" "$TOOLTIP" "$CLASS" "$PERCENTAGE"
updateModule
exit 0
