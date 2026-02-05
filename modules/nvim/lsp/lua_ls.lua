---@type vim.lsp.Config
return {
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, { ".stylua.toml", "stylua.toml" }, ".git" },
    -- INFO: For settings see:
    -- https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
}
