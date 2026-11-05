local terminal, browser = "alacritty", "firefox"
local base = (os.getenv("HOME") or "/home/madcat") .. "/.config/hypr/"
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
-- Open Firefox on workspace 11 only if no instance is there already.
hl.bind("SUPER + B", hl.dsp.exec_cmd("python " .. base .. "modules/keybindings/scripts/browser.py " .. browser .. " 11"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + G", hl.dsp.exec_cmd("godot --display-driver wayland"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
