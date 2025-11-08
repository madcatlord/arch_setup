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
	local SRC=$1
	local DST=$2

	rsync -a --delete "$SRC" "$DST"
}



### Updating the packages installed from the official repo and AUR
# NOTE this is done via a pacman hook and thus doesn't need to be done here



### Updating pacman stuffs
mkdir -p "$FS_DIR/etc/pacman.d"
backup "/etc/pacman.d/hooks" "$FS_DIR/etc/pacman.d"
backup "/etc/pacman.conf" "$FS_DIR/etc"



### Updating .bashrc and .bash_profile
mkdir -p "$FS_HOME"
backup "$HOME/.bashrc" "$FS_HOME"
backup "$HOME/.bash_profile" "$FS_HOME"



### Updating .config configs. Doing it one by one, as .config contains a lot of default configs, which I have never touched. I dont want those to conflict with the potentially changed, newer default configs of a later install
mkdir -p "$FS_HOME/.config"
backup "$HOME/.config/alacritty" "$FS_HOME/.config/alacritty"
backup "$HOME/.config/clipse" "$FS_HOME/.config"
backup "$HOME/.config/hypr" "$FS_HOME/.config"
backup "$HOME/.config/nvim" "$FS_HOME/.config"
backup "$HOME/.config/waybar" "$FS_HOME/.config"
backup "$HOME/.config/wpaperd" "$FS_HOME/.config"



### Updating the hyprland launch script for login-managers
mkdir -p "$FS_HOME/.local/bin"
backup "$HOME/.local/bin/hypr-wrapped" "$FS_HOME/.local/bin/"
