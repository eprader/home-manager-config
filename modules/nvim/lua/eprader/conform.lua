local conform = require "conform"
if not conform then return end

conform.setup {
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
    },
    formatters_by_ft = {
        nix = { "nixfmt" },
        lua = { "stylua" },
        -- python = { "isort", "black" },
        python = { "ruff_fix", "ruff_format" },
        javascript = { "prettier" },
    },
}
