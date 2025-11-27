#!/bin/bash

source ~/sourced-scripts/get-path.sh

SEARCH=$1
ROOT=$(getScriptPath)

# Checks if the search Term is found in a given file
lookForHit() {
    local FILE="$1"

    local HITS=$(cat "$FILE" | rg -C 3 --pretty "$SEARCH")

    if [[ "$HITS" != "" ]]; then
        echo "$FILE:"
        echo "$HITS"
        echo
    fi
}



lookForHit "$ROOT/init.lua"

# Iterate over every file in the ./lua/plugins directory
while IFS= read -r -d '' file; do
    lookForHit "$file"
done < <(find "$ROOT/lua/plugins" -maxdepth 1 -type f -print0)

