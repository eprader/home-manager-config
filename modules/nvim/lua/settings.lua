vim.g.mapleader = ' '

local settings = {
  hidden = true, -- opening new buffer without writing old one
  errorbells = false,
  number = true,
  relativenumber = true,
  termguicolors = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  cursorline = true,
  scrolloff = 2^3,
  signcolumn = 'yes',
  smartindent = true,
  autoindent = true,
  colorcolumn = '100',
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
vim.cmd [[
colorscheme gruvbox
set noshowmode
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
  \ }
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
