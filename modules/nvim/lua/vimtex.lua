vim.g.vimtex_view_general_viewer = 'SumatraPDF'
vim.g.vimtex_compiler_method = 'tectonic'

local map = vim.keymap.set
map('n', '<leader>ll', ":VimtexCompile<cr>")
map('n', '<leader>lv', ":VimtexView<cr>")
map('n', '<leader>lt', ":VimtexTocToggle<cr>")
