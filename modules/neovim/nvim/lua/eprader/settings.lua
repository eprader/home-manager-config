local settings = {
    hidden = true,             -- opening new buffer without writing old one
    clipboard = "unnamedplus", -- Sync with system clipboard

    number = true,
    relativenumber = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    smartindent = true,
    autoindent = true,

    wrap = false,
    colorcolumn = "80",

    swapfile = false,
    backup = false,
    undofile = true,

    errorbells = false,
    cursorline = true,

    signcolumn = "yes",

    list = true,
    listchars = {
        trail = "·",
        extends = ">",
        precedes = "<",
        eol = "↴",
        tab = "~>"
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
\ } ]]
local api = vim.api
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank {
            higroup = vim.fn["hlexists"]("HighlightedyankRegion") > 0
                and "HighlightedyankRegion"
                or "IncSearch",
            timeout = 100
        }
    end
})
