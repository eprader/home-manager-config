vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- TODO: Figure out a way to install treesitter parsers without plugin
-- NOTE: We need to manually start treesitter for each filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "<filetype>" },
    callback = function()
        vim.treesitter.start()
    end,
})
