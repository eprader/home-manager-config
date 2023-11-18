local settings = {
    hidden = true, -- opening new buffer without writing old one
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

-- nvim-notify
vim.notify = require 'notify'

vim.api.nvim_command("set noswapfile")

vim.g.gruvbox_contrast_dark = 'medium'

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
vim.cmd [[
colorscheme gruvbox
set noshowmode
]]



if (vim.g.colors_name == "gruvbox") then
    vim.api.nvim_set_hl(0, '@parameter.python', { link = 'GruvboxYellowBold' })
    vim.api.nvim_set_hl(0, 'Delimiter', { link = 'GruvboxGray' })
end

vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=80})
augroup END
]]
