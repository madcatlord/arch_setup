#!/bin/bash

getScriptPath() {
	local SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[-1]}")" &> /dev/null && pwd)
	echo "$SCRIPT_DIR"
}

