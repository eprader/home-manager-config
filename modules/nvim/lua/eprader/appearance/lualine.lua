local lualine = require "lualine"
if not lualine then return end

-- Color table for highlights
local colours = {
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
    white = "#ebdbb2",

    dark_orange = "#d65d0e",
    orange = "#fe8019",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand "%:p:h"
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local function icon_component(icon, fg, bg)
    return {
        function()
            return icon
        end,
        padding = 0,
        color = { fg = fg, bg = bg },
        separator = { left = "", right = "" },
    }
end

local mode = {
    -- mode component
    function()
        return "  "
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colours.dark_magenta,
            i = colours.dark_green,
            v = colours.dark_yellow,
            ["␖"] = colours.blue,
            V = colours.dark_yellow,
            c = colours.dark_red,
            no = colours.red,
            s = colours.orange,
            S = colours.orange,
            ["␓"] = colours.orange,
            ic = colours.yellow,
            R = colours.dark_magenta,
            Rv = colours.dark_magenta,
            cv = colours.red,
            ce = colours.red,
            r = colours.cyan,
            rm = colours.cyan,
            ["r?"] = colours.cyan,
            ["!"] = colours.red,
            t = colours.red,
        }
        return { fg = colours.black, bg = mode_color[vim.fn.mode()] }
    end,
    separator = { left = "", right = "" },
}

local whitespace = {
    function()
        return " "
    end,
    padding = 0,
}

local filetype = {
    "filetype",
    icon_only = true,
    padding = 0,
    color = { bg = colours.black },
    separator = { left = "", right = "" },
}

local filename = {
    "filename",
    cond = conditions.buffer_not_empty,
    path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    hide_filename_extension = true,
    symbols = {
        modified = "",
        readonly = "", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "∅", -- Text to show for unnamed buffers.
        newfile = "", -- Text to show for newly created file before first write
    },
    padding = 1,
    color = { fg = colours.dark_blue, bg = "#1b3536", gui = "bold" },
    separator = { left = "", right = "" },
}

local lsp_icon = icon_component("", "#563d0d", colours.dark_yellow)

local lspname = {
    function()
        local active_clients = vim.lsp.get_active_clients()
        if #active_clients == 0 then return "∅" end

        local active_clients_names = {}
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        for _, client in ipairs(active_clients) do
            local filetypes = client.config.filetypes
            -- NOTE: Only LSPs for the current filetype should be displayed.
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                table.insert(active_clients_names, client.name)
            end
        end

        return table.concat(active_clients_names, ", ") .. ":"
    end,
    padding = 1,
    color = { fg = colours.dark_yellow, bg = "#563d0d", gui = "bold" },
    separator = { left = "", right = "" },
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", hint = " ", info = " " },
    colored = true,
    always_visible = true,
    color = { bg = "#563d0d" },
    separator = { left = "", right = "" },
}

local branch_icon = icon_component("", "#492435", colours.dark_magenta)

local branch = {
    "branch",
    icons_enabled = false,
    color = { fg = colours.dark_magenta, bg = "#492435", gui = "bold" },
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    symbols = { added = " ", modified = " ", removed = " " },
    color = { bg = "#492435" },
    separator = { left = "", right = "" },
}

local fileformat = {
    "fileformat",
    fmt = string.upper,
    icons_enabled = true,
    padding = 0,
    color = { fg = "#44430b", bg = colours.dark_green },
    separator = { left = "", right = "" },
}

local encoding = {
    "o:encoding", -- option component same as &encoding in viml
    fmt = string.upper, -- I"m not sure why it"s upper case either ;)
    cond = conditions.hide_in_width,
    separator = { left = "", right = "" },
    color = { fg = colours.dark_green, bg = "#44430b", gui = "bold" },
}

lualine.setup {
    options = {
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            whitespace,
            mode,
            whitespace,
            filetype,
            filename,
            whitespace,
            lsp_icon,
            lspname,
            diagnostics,
            whitespace,
            branch_icon,
            branch,
            diff,
        },
        lualine_x = { fileformat, encoding, whitespace },
        lualine_y = {},
        lualine_z = {},
    },
}
