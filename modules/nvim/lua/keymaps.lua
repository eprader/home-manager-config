local map = vim.keymap.set

--Move code block
map('n', '<A-j>', ":m .+1<CR>==" )
map('n', '<A-k>', ":m .-2<CR>==" )
map('i', '<A-j>', "<esc>:m .+1<cr>==gi")
map('i', '<A-k>', "<esc>:m .-2<cr>==gi")
map('v', '<A-j>', ":m '>+1<cr>gv=gv")
map('v', '<A-k>', ":m '<-2<cr>gv=gv")
