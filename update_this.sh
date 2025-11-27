#!/bin/bash

########## PURPOSE OF THIS SCRIPT ##########
# ... is to update the contents of this
# repository to include the up-to-date
# versions of every file required to setup
# arch, since symlinks and hardlinks usually
# do not work.
# It should be run regularly, f.x. on every
# shutdown. It also automatically updates
# the git repository, if possible
############################################



### ATTRIBUTES
ROOT_DIR="$HOME/arch_setup"
FS_DIR="$ROOT_DIR/fs"		# dir that mimics the filesystem
FS_HOME="$FS_DIR$HOME"



### FUNCTIONS

# Makes sure the files at DST are the same as the ones at SRC (which includes deleting those that are present at DST, but not longer are at SRC, which is something cp wouldn't do)
backup() {
	local SRC="$1"
	local SRC_DIR=$(dirname "$SRC")

	rsync -a --delete "$SRC" "$FS_DIR/$SRC_DIR/"
}



### Updating the packages installed from the official repo and AUR
# NOTE this is done via a pacman hook and thus doesn't need to be done here



### Updating pacman stuffs
mkdir -p "$FS_DIR/etc/pacman.d"
backup "/etc/pacman.d/hooks"
backup "/etc/pacman.conf"



### Updating NetworkManager scripts
mkdir -p "$FS_DIR/etc/NetworkManager/dispatcher.d"
backup "/etc/NetworkManager/dispatcher.d/09-timezone.sh"



### Updating systemd stuff
mkdir -p "$FS_DIR/etc/systemd"
backup "/etc/systemd/logind.conf"



### Updating modprobe.d
mkdir -p "$FS_DIR/etc/modprobe.d"
backup "/etc/modprobe.d/iwlwifi.conf"



### Updating .bashrc and .bash_profile
mkdir -p "$FS_HOME"
backup "$HOME/.bashrc"
backup "$HOME/.bash_profile"



### Updating sourced-scripts
mkdir -p "$FS_HOME/sourced-scripts"
backup "$HOME/sourced-scripts/log.sh"
backup "$HOME/sourced-scripts/get-path.sh"



### Updating .config configs. Doing it one by one, as .config contains a lot of default configs, which I have never touched. I dont want those to conflict with the potentially changed, newer default configs of a later install
mkdir -p "$FS_HOME/.config"
backup "$HOME/.config/alacritty"
backup "$HOME/.config/clipse"
backup "$HOME/.config/hypr"
backup "$HOME/.config/nvim"
backup "$HOME/.config/waybar"
backup "$HOME/.config/wpaperd"



### Updating the hyprland launch script for login-managers
mkdir -p "$FS_HOME/.local/bin"
backup "$HOME/.local/bin/hypr-wrapped"
