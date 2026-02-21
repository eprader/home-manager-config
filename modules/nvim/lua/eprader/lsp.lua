local cmp_lsp = require "cmp_nvim_lsp"
if not cmp_lsp then return end

vim.filetype.add {
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        [".*/templates/.*%.txt"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml.gotmpl"] = "helm",
        ["values.*%.yaml"] = "yaml.helm-values",
    },
    filename = {
        ["Chart.yaml"] = "yaml.helm-chartfile",
    },
}

-- Set the capabilities for every lsp using the `*` wildcard
vim.lsp.config("*", {
    capabilities = cmp_lsp.default_capabilities(),
})

vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    virtual_text = {
        prefix = "≫",
        spacing = 2,
    },
    float = {
        focusable = true,
        source = "if_many",
        header = "",
        prefix = "",
    },
}

-- KEYBINDS
require "eprader.mapleader"
local map = vim.keymap.set

vim.api.nvim_create_autocmd("LSPAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function()
        -- INFO: See `:help vim.lsp.*` for documentation on any of the below functions.
        local opts = { noremap = true, silent = true }

        opts.desc = "Show documentation"
        map("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Show diagnostics in float"
        map("n", "<leader>e", vim.diagnostic.open_float, opts)
        opts.desc = "Rename under cursor"
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Goto Definition"
        map("n", "gd", vim.lsp.buf.definition, opts)
        opts.desc = "Goto Declaration"
        map("n", "gD", vim.lsp.buf.declaration, opts)
        opts.desc = "Goto implementation"
        map("n", "gi", vim.lsp.buf.implementation, opts)
        opts.desc = "Show available code actions"
        map("n", "<leader>a", vim.lsp.buf.code_action, opts)
        opts.desc = "List all references"
        map("n", "<leader>ref", vim.lsp.buf.references, opts)
        opts.desc = "Format file"
        map("n", "<C-f>", vim.lsp.buf.format, opts)
        opts.desc = "Goto next diagnotsic"
        map("n", "[d", function()
            vim.diagnostic.jump { count = 1, float = true }
        end, opts)
        opts.desc = "Goto previous diagnotsic"
        map("n", "]d", function()
            vim.diagnostic.jump { count = -1, float = true }
        end, opts)
    end,
})

vim.lsp.enable {
    "lua_ls",
    "nil_ls",
    "yamlls",
    "helm_ls",
    "tsgo",
}
