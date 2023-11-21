--[[
 NOTE: Make sure this file is sourced before any other of your files that
 makes use of `vim.notify`.
]]
local prequire = require 'eprader.prequire'

local notify = prequire 'notify'
if not notify then return end

vim.opt.termguicolors = true -- INFO: Required to support opacity changes.
vim.notify = notify

--[[
 HACK: Notify requires the `NotifyBackground` highlight group to have a `background` highlight.
 By default `NotifyBackground` is linked to `Normal`.
 For Neovim (v0.9.1) `:colorscheme default` `Normal.background` is `nil`
 Requiring a colorscheme should set that value.
]]
prequire 'eprader.colorscheme'

local colors = {
    black = '#282828',
    dark_grey = '#928374',
    dark_red = '#cc241d',
    red = '#fb4934',
    dark_green = '#98971a',
    green = '#b8bb26',
    dark_yellow = '#d79921',
    yellow = '#fabd2f',
    dark_blue = '#458588',
    blue = '#83a598',
    dark_magenta = '#b16286',
    magenta = '#d3869b',
    dark_cyan = '#689d6a',
    cyan = '#8ec07c',
    light_grey = '#a89984',
    white = '#ebdbb2',
    dark_orange = '#d65d0e',
    orange = '#fe8019'
}

local notify_hlgroup_colors = {
    NotifyERRORBorder = { fg = colors.dark_red },
    NotifyERRORIcon = { fg = colors.dark_red },
    NotifyERRORTitle = { fg = colors.red },

    NotifyWARNBorder = { fg = colors.dark_yellow },
    NotifyWARNIcon = { fg = colors.dark_yellow },
    NotifyWARNTitle = { fg = colors.yellow },

    NotifyINFOBorder = { fg = colors.dark_blue },
    NotifyINFOIcon = { fg = colors.dark_blue },
    NotifyINFOTitle = { fg = colors.blue },

    NotifyDEBUGBorder = { fg = colors.dark_magenta },
    NotifyDEBUGIcon = { fg = colors.dark_magenta },
    NotifyDEBUGTitle = { fg = colors.magenta },

    NotifyTRACEBorder = { fg = colors.dark_cyan },
    NotifyTRACEIcon = { fg = colors.dark_cyan },
    NotifyTRACETitle = { fg = colors.cyan },
}

for hl_group_name, hl_group_colors in pairs(notify_hlgroup_colors) do
    vim.api.nvim_set_hl(0, hl_group_name, hl_group_colors)
end

notify.setup {
    background_colour = "NotifyBackground",
    fps = 60,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 0, -- Display all notifications
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 5000,
    top_down = true
}
