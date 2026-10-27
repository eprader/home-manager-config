-- Base values are based on a 1080p-equivalent (logical) screen.
local BASE = { gaps_in = 4, gaps_out = 8, border_size = 1, rounding = 5 }
local REF_HEIGHT = 1080

-- Scale factor from logical height (physical height / monitor scale).
-- Height rather than width, so ultrawides don't blow the values up.
local function factor(mon)
	return math.max(0.75, (mon.height / mon.scale) / REF_HEIGHT)
end

local function px(base, f, min)
	return math.max(min or 0, math.floor(base * f + 0.5))
end

local function apply()
	for _, monitor in ipairs(hl.get_monitors()) do
		local f = factor(monitor)
		local self = "m[" .. monitor.name .. "]" -- all workspaces on this monitor

		hl.workspace_rule({
			workspace = self,
			gaps_in = px(BASE.gaps_in, f, 1),
			gaps_out = px(BASE.gaps_out, f, 1),
		})

		hl.window_rule({
			name = "scale-" .. monitor.name,
			match = { workspace = self },
			border_size = px(BASE.border_size, f, 1),
			rounding = px(BASE.rounding, f),
		})
	end
end

apply()
hl.on("monitor.layout_changed", apply)
