#!/bin/sh

# NOTE this is not required
#if [ $EUID -ne 0 ];then
#	echo "ERROR: Hook '$0' could not be executed: No Root Priviliges"
#	exit 1
#fi

BACKUP_DIR="/home/madcat/arch_setup/pkgs"
OFFICIAL_FILENAME="official.txt"
AUR_FILENAME="aur.txt"

mkdir -p "$BACKUP_DIR"
pacman -Qqetn > "$BACKUP_DIR/$OFFICIAL_FILENAME"
pacman -Qqem > "$BACKUP_DIR/$AUR_FILENAME"

exit 0
