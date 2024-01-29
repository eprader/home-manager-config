--Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")
if not lualine then
	return
end

-- Color table for highlights
local colors = {
	black = "#282828",
	dark_grey = "#928374",

	dark_red = "#cc241d",
	red = "#fb4934",

	dark_green = "#98971a",
	green = "#b8bb26",

	dark_yellow = "#d79921",
	yellow = "#fabd2f",

	dark_blue = "#458588",
	blue = "#83a598",

	dark_magenta = "#b16286",
	magenta = "#d3869b",

	dark_cyan = "#689d6a",
	cyan = "#8ec07c",

	light_grey = "#a89984",
	white = "ebdbb2",

	dark_orange = "#d65d0e",
	orange = "#fe8019",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local filename = {
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.blue, ui = "bold" },
	path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local mode = {
	-- mode component
	function()
		return "⌨"
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.dark_magenta,
			i = colors.dark_green,
			v = colors.dark_yellow,
			["␖"] = colors.blue,
			V = colors.dark_yellow,
			c = colors.dark_red,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			["␓"] = colors.orange,
			ic = colors.yellow,
			R = colors.dark_magenta,
			Rv = colors.dark_magenta,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { left = 2, right = 1 },
}

local location = {
	"location",
	color = { fg = colors.dark_grey, gui = "bold" },
}

local lspname = {
	-- Lsp server name .
	function()
		local msg = "∅"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = "",
	color = { fg = colors.dark_yellow, gui = "bold" },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", hint = " ", info = " " },
	colored = true,
	always_visible = true,
}
--
local branch = {
	"branch",
	icon = "",
	color = { fg = colors.dark_magenta, gui = "bold" },
}

local diff = {
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳", removed = " " },
	diff_color = {
		added = { fg = colors.dark_green },
		modified = { fg = colors.dark_cyan },
		removed = { fg = colors.dark_red },
	},
	cond = conditions.hide_in_width,
}

local encoding = {
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I"m not sure why it"s upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.dark_green, gui = "bold" },
}

local fileformat = {
	"fileformat",
	fmt = string.upper,
	icons_enabled = true, -- I think icons are cool but Eviline doesn"t have them. sigh
	color = { fg = colors.dark_green, gui = "bold" },
}

local filetype = {
	"filetype",
	fmt = string.lower,
	icons_enabled = true, -- I think icons are cool but Eviline doesn"t have them. sigh
	color = { fg = colors.dark_grey, gui = "bold" },
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_c = { mode, filename, branch, diff, location },
		lualine_x = { lspname, diagnostics },
		lualine_y = { spaces, filetype, fileformat, encoding },
		lualine_z = {},
	},
}
-- Now don"t forget to initialize lualine
lualine.setup(config)
