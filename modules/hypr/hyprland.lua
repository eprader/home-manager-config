require("keybindings")
require("animations")
require("monitors")

dofile(os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua")

-- AUTOSTART
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar &")
	hl.exec_cmd("nm-applet --indicator &")
	hl.exec_cmd("blueman-applet &")
end)

-- https://wiki.hypr.land/Configuring/Basics/Variables/
-- https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types
hl.config({
	-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 1,

		col = {
			active_border = { colors = { "#b8bb26", "#d79921" }, angle = 45 },
			inactive_border = { colors = { "rgba(595959aa)" } },
		},
		--
		resize_on_border = true,
		layout = "dwindle",
	},
	-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
	decoration = {
		rounding = 5,
	},
	-- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
	dwindle = {
		preserve_split = true,
	},
	-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
	master = {
		new_status = "master",
	},
	-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		focus_on_activate = true,
	},
	-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
	input = {

		kb_layout = "de",

		follow_mouse = 1,

		sensitivity = 0.5,
		accel_profile = "flat",

		-- https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
		touchpad = {
			natural_scroll = true,
		},
	},
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
	name = "glorious-model-d",
	sensitivity = -0.5,
	accel_profile = "flat",
})

hl.window_rule({
	-- Ignore maximize requests from all apps.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "flameshot-multi-display-fix",
	match = { title = "^flameshot$" },
	rounding = 0,
	border_size = 0,
	float = true,
	pin = true,
	move = { 0, 0 },
	size = { "monitor_w", "monitor_h" },
})
