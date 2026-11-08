-- Hyprland 0.57 Lua configuration. Paths are relative to ~/.config/hypr.
local home = os.getenv("HOME") or "/home/madcat"
local base = home .. "/.config/hypr/"
local terminal, browser, wallpaperManager = "alacritty", "firefox", "wpaperd"
local mainMod = "SUPER"
local saucePath = base .. "modules/"

-- The Pywal theme is still written to wal-theme.conf for hyprlock;
-- this Lua adapter reads those same colors on every config reload.
local colors = dofile(base .. "wal-theme.lua")

-- ====================================================================================
--                            HARDWARE
-- ====================================================================================
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})
hl.monitor({
	output = "desc:Microstep G272QPF E2 0x01010101",
	mode = "2560x1440@60.00",
	position = "auto-center-left",
	scale = 1.25,
})
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})
hl.workspace_rule({
	workspace = "1",
	monitor = "desc:Microstep G272QPF E2 0x01010101",
	default = true,
})
hl.workspace_rule({
	workspace = "11",
	monitor = "desc:Microstep G272QPF E2 0x01010101",
	default = true,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_SIZE", "16")

-- ====================================================================================
--                            BASIC CONFIG
-- ====================================================================================

hl.config({
	ecosystem = {
		enforce_permissions = true,
		no_update_news = true,
		no_donation_nag = true,
	},
	general = {
		gaps_in = 4,
		gaps_out = {
			top = 4,
			right = 8,
			bottom = 8,
			left = 8,
		},
		border_size = 2,
		col = {
			active_border = colors.color15,
			inactive_border = colors.color8,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 5,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = { enabled = true },
	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
	master = { new_status = "master" },
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		size_limits_tiled = true,
	},
	input = {
		kb_layout = "de,dk",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",
		repeat_rate = 40,
		repeat_delay = 400,
		follow_mouse = 2,
		sensitivity = 0,
		touchpad = { natural_scroll = true },
	},
	debug = { disable_logs = false },
	cursor = {
		no_warps = true,
		hide_on_key_press = true,
		no_hardware_cursors = 1,
		default_monitor = "DP-4",
	},
	opengl = { nvidia_anti_flicker = false },
	xwayland = { force_zero_scaling = true },
})

-- ====================================================================================
--                            CURVES
-- ====================================================================================

hl.curve("easeOutQuint", {
	type = "bezier",
	points = {
		{ 0.23, 1 },
		{ 0.32, 1 },
	},
})

hl.curve("easeInOutCubic", {
	type = "bezier",
	points = {
		{ 0.65, 0.05 },
		{ 0.36, 1 },
	},
})

hl.curve("linear", {
	type = "bezier",
	points = {
		{ 0, 0 },
		{ 1, 1 },
	},
})

hl.curve("almostLinear", {
	type = "bezier",
	points = {
		{ 0.5, 0.5 },
		{ 0.75, 1 },
	},
})

hl.curve("quick", {
	type = "bezier",
	points = {
		{ 0.15, 0 },
		{ 0.1, 1 },
	},
})

-- ====================================================================================
--                            ANIMATIONS
-- ====================================================================================

hl.animation({
	leaf = "global",
	enabled = true,
	speed = 10,
	bezier = "default",
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3,
	bezier = "default",
	style = "fade",
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5.39,
	bezier = "easeOutQuint",
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4.79,
	bezier = "easeOutQuint",
})

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4.1,
	bezier = "easeOutQuint",
	style = "popin 87%",
})

-- ====================================================================================
--                            WINDOW RULES
-- ====================================================================================

hl.window_rule({
	name = "clipse-master-mod",
	match = { class = "clipse" },
	size = { 622, 652 },
	float = true,
})
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = {
		"20",
		"monitor_h-120",
	},
	float = true,
})
hl.window_rule({
	name = "firefox-tiled-fileupload",
	match = {
		class = "^(firefox)$",
		title = "^(File Upload)(.*)$",
	},
	tile = true,
})
hl.window_rule({
	name = "obsidian-tiled",
	match = { initial_class = "^(obsidian)$" },
	tile = true,
})
hl.window_rule({
	name = "godot-float-debugger",
	match = {
		initial_title = "^(Godot)$",
		title = "^(.*)\\(DEBUG\\)(.*)$",
	},
	float = true,
})
hl.window_rule({
	name = "waydroid-fixed-size",
	match = { class = "^(Waydroid)|(waydroid.*)$" },
	float = true,
	move = {
		"monitor_w-320",
		"75",
	},
})
hl.window_rule({
	name = "android-studio-no-decorations",
	match = { class = "jetbrains-studio" },
	decorate = false,
})
hl.window_rule({
	name = "neovim-transparency",
	match = { title = "^(neovim)$" },
	opacity = "0.9",
})

-- ====================================================================================
--                            PERMISSIONS
-- ====================================================================================

hl.permission({
	binary = "/usr/bin/hyprlock",
	type = "screencopy",
	mode = "allow",
})
hl.permission({
	binary = "/usr/bin/grim",
	type = "screencopy",
	mode = "allow",
})

-- ====================================================================================
--                            LOAD SUB-CONFIGS
-- ====================================================================================

local app = dofile(saucePath .. "keybindings/apps.keys.lua")
dofile(saucePath .. "keybindings/system.keys.lua")
dofile(saucePath .. "keybindings/dietary.keys.lua")
dofile(saucePath .. "submaps/clipse.submap.lua")
dofile(saucePath .. "submaps/moveWindow.submap.lua")
dofile(saucePath .. "submaps/refresh.submap.lua")
dofile(saucePath .. "submaps/resize.submap.lua")

-- ====================================================================================
--                            ON STARTUP
-- ====================================================================================

-- exec-once -> hyprland.start; this is not run for config reloads.
hl.on("hyprland.start", function()
	hl.exec_cmd(base .. "scripts/second-monitor.sh")
	hl.exec_cmd("clipse -listen")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("sleep 1 && " .. home .. "/.config/waybar/scripts/count-updates.sh")
	hl.exec_cmd("waybar")
	hl.exec_cmd(wallpaperManager)
	hl.exec_cmd(terminal)
	hl.exec_cmd(home .. "/arch_setup/auto_backup.sh")
end)
