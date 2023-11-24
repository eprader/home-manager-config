-- PERF: This enables the experimental loader of nvim >=v.0.9
-- See https://neovim.io/doc/user/lua.html#vim.loader
-- Improved startup time by about 25%!
if vim.loader then vim.loader.enable() end

-- WARN: Removing this might lead to a breaking config.
-- This check ensures that protected require is available.
local success, prequire = pcall(require, 'eprader.prequire')
if not success then
    vim.notify("From `init.lua`: `prequrie` failed to load.\n"
        .. "Aborted loading configuration...\n"
        .. prequire)
    return
end

-- NOTE: Load `notify` first to handle future `vim.notify` calls.
prequire 'eprader.notify'

prequire 'eprader.settings'
prequire 'eprader.keymaps'
prequire 'eprader.colorscheme'
prequire 'eprader.treesitter'
prequire 'eprader.autopairs'
prequire 'eprader.comment'

prequire 'eprader.telescope'
prequire 'eprader.lsp'
prequire 'eprader.cmp'
prequire 'eprader.harpoon'

prequire 'eprader.gitsigns'
prequire 'eprader.dressing'
prequire 'eprader.trouble'
prequire 'eprader.todo-comments'
prequire 'eprader.lualine'

prequire 'eprader.toggleterm'
prequire 'eprader.overseer'

prequire 'eprader.dap'
prequire 'eprader.dapui'

prequire 'eprader.nvim-r'
prequire 'eprader.java'
