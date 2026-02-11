-- PERF: This enables the experimental loader of nvim >=v.0.9
-- See https://neovim.io/doc/user/lua.html#vim.loader
-- Improved startup time by about 25%!
if vim.loader then
    vim.loader.enable()
else
    vim.notify("`vim.loader` not found.", vim.log.levels.INFO)
end

-- WARN: Removing this might lead to a breaking config.
-- This check ensures that protected require is available.
local success, sentinel = pcall(require, "sentinel")
if not success then
    vim.notify(
        "From `init.lua`: `sentinel` failed to load.\n"
            .. "Aborted loading configuration...\n"
            .. sentinel
    )
    return
end

-- NOTE: Load `notify` first to handle future `vim.notify` calls.
require "eprader.notify"

require "eprader.settings"
require "eprader.keymaps"
require "eprader.treesitter"

require "eprader.telescope"
require "eprader.lsp"
vim.lsp.enable {
    "lua_ls",
    "nil_ls",
    "yamlls",
    "helm_ls",
}
require "eprader.lint"
require "eprader.conform"
require "eprader.cmp"
require "eprader.harpoon"
require "eprader.autopairs"
require "eprader.comment"

require "eprader.gitsigns"
require "eprader.appearance"
require "eprader.ufo"

require "eprader.toggleterm"
-- require "eprader.overseer"

-- require "eprader.dap"
-- require "eprader.dapui"
