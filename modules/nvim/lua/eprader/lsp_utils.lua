require "eprader.mapleader"
local capabilities =
    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "<leader>e", vim.diagnostic.open_float, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
    map("n", "<space>q", vim.diagnostic.setloclist, opts)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map("n", "gD", vim.lsp.buf.declaration, bufopts)
    map("n", "gd", vim.lsp.buf.definition, bufopts)
    map("n", "K", vim.lsp.buf.hover, bufopts)
    map("n", "gi", vim.lsp.buf.implementation, bufopts)
    map("n", "<leader>sh", vim.lsp.buf.signature_help, bufopts)
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    map("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
    map("n", "gr", vim.lsp.buf.references, bufopts)
    map("n", "<C-f>", vim.lsp.buf.format, bufopts)
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

return {
    capabilities = capabilities,
    map = map,
    opts = opts,
    on_attach = on_attach,
    lsp_flags = lsp_flags,
}
