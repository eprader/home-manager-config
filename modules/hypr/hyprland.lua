require("monitors")
dofile(os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua")
require("keybindings")
require("animations")

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

-- Flameshot composites its capture over the whole desktop bounding box, so its
-- overlay must be anchored on the leftmost monitor and span all of them;
-- otherwise the image is offset (shifted left + strip of the neighbour shown).
-- monitor_w/monitor_h only cover one monitor, and hyprmoncfg can change the
-- layout at runtime, hence re-apply on layout change (same pattern as scaling.lua).
-- shortcut: assumes all monitors start at the leftmost monitor's top edge (y),
-- upgrade if a monitor is ever positioned higher/lower than another.
local function flameshot_rule()
	local base = nil
	for _, m in ipairs(hl.get_monitors()) do
		if not base or m.x < base.x then base = m end
	end
	local w, h = base.width, base.height
	for _, m in ipairs(hl.get_monitors()) do
		w = math.max(w, m.x + m.width - base.x)
		h = math.max(h, m.y + m.height - base.y)
	end
	hl.window_rule({
		name = "flameshot-multi-display-fix",
		match = { title = "^flameshot$" },
		rounding = 0,
		border_size = 0,
		float = true,
		pin = true,
		monitor = base.name,
		move = { 0, 0 },
		size = { w, h },
	})
end

flameshot_rule()
hl.on("monitor.layout_changed", flameshot_rule)
