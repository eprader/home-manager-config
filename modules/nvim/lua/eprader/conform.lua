local conform = require "conform"
if not conform then return end

conform.setup {
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
    },
}
