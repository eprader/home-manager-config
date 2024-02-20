local settings = {
    hidden = true, -- opening new buffer without writing old one
    clipboard = "unnamedplus", -- Sync with system clipboard

    number = true,
    relativenumber = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    smartindent = true,
    autoindent = true,

    signcolumn = "yes",
    colorcolumn = "80",
    wrap = true,
    showmode = false,

    swapfile = false,
    backup = false,
    undofile = true,

    errorbells = false,
    cursorline = true,

    list = true,
    listchars = {
        trail = "·",
        extends = ">",
        precedes = "<",
        eol = "↴",
        tab = "~>",
    },

    hlsearch = false,
    incsearch = true,

    termguicolors = true,

    scrolloff = 8,
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end
-- TODO: check if system is WSL and apply condigional settings

--[[ add to vim.cmd for clipboard in WSL
let g:clipboard = {
\   "name": "WslClipboard",
\   "copy": {
\      "+": "clip.exe",
\      "*": "clip.exe",
\    },
\   "paste": {
\      "+": "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))",
\      "*": "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))",
\   },
\   "cache_enabled": 0,
\ }
]]
local api = vim.api
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank {
            higroup = vim.fn["hlexists"] "HighlightedyankRegion" > 0 and "HighlightedyankRegion"
                or "IncSearch",
            timeout = 100,
        }
    end,
})

-- vim.api.nvim_create_autocmd({ "Filetype" }, {
--     group = vim.api.nvim_create_augroup("HelpNewBuffer", { clear = true }),
--     pattern = "help",
--     callback = function()
--         if vim.b.already_opened == nil then
--             vim.b.already_opened = true
--
--             -- close the original window
--             local original_win = vim.fn.win_getid(vim.fn.winnr "#")
--             local help_win = vim.api.nvim_get_current_win()
--             if original_win ~= help_win then vim.api.nvim_win_close(original_win, false) end
--
--             -- put the help buffer in the buffer list
--             vim.bo.buflisted = true
--         end
--     end,
-- })
