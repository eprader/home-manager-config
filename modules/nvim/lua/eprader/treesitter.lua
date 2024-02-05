local treesitter_configs = require "nvim-treesitter.configs"
if not treesitter_configs then return end

-- NOTE: To enable folding:
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

treesitter_configs.setup {
    -- INFO: The grammars are managed by the home-manager module.
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}
