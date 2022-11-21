local g = vim.g

g.mapleader = ' '

local o = vim.opt

o.hidden = true -- opening new buffer without writing old one
o.errorbells = false

o.number = true
o.relativenumber = true
o.termguicolors = true

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

o.cursorline = true
o.signcolumn = 'yes'
o.smartindent = true
o.autoindent = true
o.colorcolumn = '100'
o.undofile = true

o.clipboard = "unnamedplus"

vim.api.nvim_command("set noswapfile")

vim.cmd [[ 
colorscheme gruvbox
set noshowmode
]]

o.list = true
o.listchars = {
  trail = '·',
  extends = '>',
  precedes = '<',
  eol = '↴',
  tab = '~>'
}

vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=80})
augroup END
]]
