-- in WSl: vim.g.vimtex_view_general_viewer = "/mnt/c/Users/emanu/AppData/Local/SumatraPDF/SumatraPDF.exe"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_compiler_tectonic = {
	options = {
		"--keep-logs",
		"--synctex",
		"-Zshell-escape", -- NOTE: Needed to allow the minted package to call pygments
	},
}
vim.g.vimtex_compiler_method = "tectonic"

-- KEYBINDS
-- local require = require "sentinel"
require("eprader.mapleader")

local map = vim.keymap.set
map("n", "<leader>ll", ":VimtexCompile<cr>")
map("n", "<leader>lv", ":VimtexView<cr>")
map("n", "<leader>lt", ":VimtexTocToggle<cr>")
