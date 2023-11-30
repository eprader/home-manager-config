-- PERF: This enables the experimental loader of nvim >=v.0.9
-- See https://neovim.io/doc/user/lua.html#vim.loader
-- Improved startup time by about 25%!
if vim.loader then vim.loader.enable() end

-- WARN: Removing this might lead to a breaking config.
-- This check ensures that protected require is available.
local success, require = pcall(require, "eprader.prequire")
if not success then
    vim.notify("From `init.lua`: `prequrie` failed to load.\n"
        .. "Aborted loading configuration...\n"
        .. require)
    return
end

-- NOTE: Load `notify` first to handle future `vim.notify` calls.
require "eprader.notify"

require "eprader.settings"
require "eprader.keymaps"
require "eprader.treesitter"
require "eprader.autopairs"
require "eprader.comment"

require "eprader.telescope"
require "eprader.lsp"
require "eprader.cmp"
require "eprader.harpoon"
require "eprader.gitsigns"

require "eprader.appearance"

require "eprader.toggleterm"
require "eprader.overseer"

require "eprader.dap"
require "eprader.dapui"

require "eprader.nvim-r"
require "eprader.java"
