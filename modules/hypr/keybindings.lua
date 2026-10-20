-- https://wiki.hypr.land/Configuring/Basics/Binds/

-- $browser = brave
-- # NOTE: flameshot has issues with screens might in the future be solved by:
-- # https://github.com/flameshot-org/flameshot/pull/4498
-- # Used to counteract the scaling of the screens... laptop screen is scaled with 1.25
-- $screenshot = QT_SCALE_FACTOR=0.8 flameshot gui
--
-- $volumeUp10 = wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+
-- $volumeDown10 = wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-
-- $toggleAudioSourceMute = wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
-- $toggleAudioSinkMute = wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
--
-- $brightnessUp10 = brightnessctl set $(( ($(brightnessctl get) * 100 / $(brightnessctl max) + 10) / 10 * 10 ))%
-- $brightnessDown10 = brightnessctl set $(( ($(brightnessctl get) * 100 / $(brightnessctl max) - 10) / 10 * 10 ))%

hl.bind("SUPER + Q", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with SUPER + vi movements
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- Mic mute + Discord mute
-- TODO: Maybe move this into the .nix code which guarantees wirePlumber to exist...
-- NOTE: Use regex to also match `discord-ptb` or others.
-- Two actions on one key: in Lua this is one function that dispatches both.
hl.bind("SUPER + M", function()
	hl.dispatch(hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
	hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "m", window = "class:^(discord)$" }))
end)

-- NOTE: flameshot has issues with screens might in the future be solved by:
-- https://github.com/flameshot-org/flameshot/pull/4498
-- Used to counteract the scaling of the screens... laptop screen is scaled with 1.25
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("flameshot gui"))

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl set $(( ($(brightnessctl get) * 100 / $(brightnessctl max) + 10) / 10 * 10 ))%"),
	{ repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl set $(( ($(brightnessctl get) * 100 / $(brightnessctl max) - 10) / 10 * 10 ))%"),
	{ repeating = true }
)

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"),
	{ repeating = true }
)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })

-- Default workspace positioning
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })

for i = 1, 10 do
	local key = i % 10 -- workspace 10 is on key 0
	-- Switch workspaces with SUPER + [0-9]
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
	-- Move active window to a workspace with SUPER + SHIFT + [0-9]
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i), follow = true }))
end

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Your original had movewindow on both buttons; 273 is probably meant to be resize.
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.drag(), { mouse = true })

-- 3 Finger horizontal swipe to switch workspaces
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
