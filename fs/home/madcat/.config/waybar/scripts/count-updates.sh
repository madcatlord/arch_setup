#!/bin/bash

### ATTRIBUTES
DATA_FILEPATH_RELATIVE="data/updates.json"
TIMEOUT=5



# Getting the absolute path of this script and defining the path to the file, that will contain the results of this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DATA_FILEPATH="$SCRIPT_DIR/$DATA_FILEPATH_RELATIVE"

# Create data dir if it doesnt exist
if [ ! -f "$DATA_FILEPATH" ]; then
	mkdir -p $(dirname "$DATA_FILEPATH")
fi

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
}

# sends the update signal to waybar, which triggers the re-reading of the data file
updateModule() {
	pkill -RTMIN+1 waybar
}

# Printing temporary LOADING data to storage
toJSON 'loading' '' '' 'loading' ''
updateModule

### DATA FETCHING ###
OFFICIAL=$(timeout $TIMEOUT checkupdates --nocolor)
OFFICIAL_EXIT=$(echo $?)

AUR=$(timeout $TIMEOUT yay -Qua)
AUR_EXIT=$(echo $?)

# Making sure the request was successful
# NOTE AUR_EXIT exits with 1 if nothing was found
if [[ OFFICIAL_EXIT -eq 1 || AUR_EXIT -gt 1 ]]; then
	TOOLTIP="EXIT_CODE_PAC: $OFFICIAL_EXIT\nEXIT_CODE_AUR: $AUR_EXIT"

	toJSON "ERR" "" "$TOOLTIP" "error" ""
	updateModule

	exit 1
fi

# NOTE subtracting 1 because there always is a final newline which is counted as well
AMT_OFFICIAL=$(($(echo "$OFFICIAL" | wc -l) - 1))
AMT_AUR=$(($(echo "$AUR" | wc -l) - 1))

# Getting all the major versions. Every second entry is the new major version
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

if [[ $(($AMT_OFFICIAL + $AMT_AUR)) -gt 30 ]]; then
	CLASS="rec-update"
fi


# Output final result
toJSON "$TEXT" "$ALT" "$TOOLTIP" "$CLASS" "$PERCENTAGE"
updateModule
exit 0
