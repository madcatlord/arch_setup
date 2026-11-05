-- Prepare workspace layout for DIETARY development.
local base = (os.getenv("HOME") or "/home/madcat") .. "/.config/hypr/"
hl.bind("SUPER + O", hl.dsp.exec_cmd(base .. "modules/keybindings/scripts/dietary.sh"))
