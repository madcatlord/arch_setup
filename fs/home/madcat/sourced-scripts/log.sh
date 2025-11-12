#!/bin/bash


LOG_TO_FILE() {
	DIR=$(dirname "$1")
	if [ ! -d "$DIR" ]; then
		echo "ERROR: Logging failed, directory '$DIR' does not exist."
		exit 1
	fi

	MILIS=$(($(date +%s%N)/1000000))
	echo "[$(date +'%d.%m.%Y %H:%M:%S') - $MILIS] $2" >> "$1"
}

