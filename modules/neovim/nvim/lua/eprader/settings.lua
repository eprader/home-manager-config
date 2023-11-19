local vim_api = vim.api

local settings = {
    hidden = true, -- opening new buffer without writing old one
    swapfile = false,
    showmode = false,
    errorbells = false,
    number = true,
    relativenumber = true,
    termguicolors = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    cursorline = true,
    signcolumn = 'yes',
    smartindent = true,
    autoindent = true,
    colorcolumn = '80',
    undofile = true,
    clipboard = "unnamedplus",
    list = true,
    listchars = {
        trail = '·',
        extends = '>',
        precedes = '<',
        eol = '↴',
        tab = '~>'
    }
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end

vim.cmd.colorscheme('gruvbox')
vim.g.gruvbox_contrast_dark = 'medium'

if (vim.g.colors_name == "gruvbox") then
    vim_api.nvim_set_hl(0, '@parameter.python', { link = 'GruvboxYellowBold' })
    vim_api.nvim_set_hl(0, 'Delimiter', { link = 'GruvboxGray' })
end

-- nvim-notify
vim.notify = require 'notify' -- NOTE: Requires the plugin, not the personal `.lua` config

-- TODO: check if system is WSL and apply condigional settings

--[[ add to vim.cmd for clipboard in WSL
let g:clipboard = {
\   'name': 'WslClipboard',
\   'copy': {
\      '+': 'clip.exe',
\      '*': 'clip.exe',
\    },
\   'paste': {
\      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
\      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
\   },
\   'cache_enabled': 0,
\ } ]]

vim_api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank {
            higroup = vim.fn["hlexists"]('HighlightedyankRegion') > 0
                and 'HighlightedyankRegion'
                or 'IncSearch',
            timeout = 100
        }
    end
})
