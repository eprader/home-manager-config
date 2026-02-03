--[[
 NOTE: Make sure this file is sourced before any other of your files that
 makes use of `vim.notify`.
]]
local notify = require "notify"
if not notify then return end

vim.opt.termguicolors = true -- INFO: Required to support opacity changes.
vim.notify = notify

local highlights = {
    NotifyERRORTitle = "DiagnosticFloatingError",
    NotifyERRORBorder = "NotifyERRORTitle",
    NotifyERRORIcon = "NotifyERRORBorder",

    NotifyWARNTitle = "DiagnosticFloatingWarn",
    NotifyWARNBorder = "NotifyWARNTitle",
    NotifyWARNIcon = "NotifyWARNBorder",

    NotifyINFOTitle = "DiagnosticFloatingInfo",
    NotifyINFOBorder = "NotifyINFOTitle",
    NotifyINFOIcon = "NotifyINFOBorder",

    NotifyDEBUGTitle = "DiagnosticFloatingHint",
    NotifyDEBUGBorder = "NotifyDEBUGTitle",
    NotifyDEBUGIcon = "NotifyDEBUGBorder",

    NotifyTRACETitle = "DiagnosticFloatingHint",
    NotifyTRACEBorder = "NotifyTRACETitle",
    NotifyTRACEIcon = "NotifyTRACEBorder",
}

for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, { link = v })
end
notify.setup {
    background_colour = "#282828",
    fps = 60,
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
    level = 0, -- Display all notifications
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 5000,
    top_down = false,
}

-- Telescope extension
local telescope = require "telescope"
if telescope then telescope.load_extension "notify" end
