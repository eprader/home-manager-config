local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map('n', '<leader>e', vim.diagnostic.open_float, opts)
    map('n', '[d', vim.diagnostic.goto_prev, opts)
    map('n', ']d', vim.diagnostic.goto_next, opts)
    map('n', '<space>q', vim.diagnostic.setloclist, opts)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', '<leader>sh', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    map('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', '<C-f>', vim.lsp.buf.format, bufopts)
    -- formatting on save
    --vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]

    -- this capability check does not seem to work so the command was added outside...
    --if client.server_capabilities.documentFormattingProvider then
    -- vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]
    --end
end


local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local lsconfig = require 'lspconfig'
-- Server setup
lsconfig.rnix.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

lsconfig.ccls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    lsp = { codelens = { enable = true } }
}

lsconfig.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

lsconfig.hls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

lsconfig.tsserver.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

lsconfig.svelte.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-- lsconfig.tailwindcss.setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
--   capabilities = capabilities,
-- }

lsconfig.pyright.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

lsconfig.ltex.setup {
    on_attach = function(client, bufnr)
        require 'ltex_extra'.setup {
            -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
            -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
            load_langs = { "en-US", "de-DE" }, -- en-US as default
            -- boolean : whether to load dictionaries on startup
            init_check = true,
            -- string : relative or absolute path to store dictionaries
            -- e.g. subfolder in the project root or the current working directory: ".ltex"
            -- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
            path = "", -- project root or current working directory
            -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
            log_level = "none",
            -- table : configurations of the ltex language server.
            -- Only if you are calling the server from ltex_extra
            server_opts = nil
        }
        on_attach()
    end,
    flags = lsp_flags,
    settings = {
        ltex = {
            language = { 'en-GB', 'de-DE' },
            disabledRules = {
                ['en-GB'] = { 'PROFANITY' },
            },
        },
    },
}

lsconfig.sqlls.setup {
    on_attach = function(client, bufnr)
        require 'sqls'.on_attach(client, bufnr)
        on_attach()

        map({ 'n', 'v' }, '<leader>eq', ":SqlsExecuteQuery<cr>", opts)
        map('n', '<leader>sd', ":SqlsSwitchDatabase<cr>", opts)
        map('n', '<leader>sc', ":SqlsSwitchConnection<cr>", opts)
    end,

    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { "sqls", "-config", "/home/eprader/.config/sqls/config.yml" }
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = '≫',
            spacing = 2,
        },
        signs = true,
        update_in_insert = true,
        severity_sort = true,
    })

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local config = {
    virtual_text = true, -- disable virtual text
    signs = {
        active = signs,  -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        severity_sort = true,
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.cmd [[highlight link NormalFloat Normal]]

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

vim.diagnostic.config(config)
