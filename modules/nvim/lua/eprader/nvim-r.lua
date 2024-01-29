require("eprader.mapleader")

local map = vim.keymap.set
map("n", "<leader>rs", "<Plug>RStart")
map("n", "<leader>rc", "<Plug>RSaveClose")
map("n", "<leader>rl", "<Plug>RSendLine")
map("n", "<leader>rv", "<Plug>RSendSelection")
map("n", "<leader>rf", "<Plug>RSendFile")
map("n", "<leader>ro", "\ro")
