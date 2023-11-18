local colors = {
    black = '#282828',
    dark_grey = '#928374',
    dark_red = '#cc241d',
    red = '#fb4934',
    dark_green = '#98971a',
    green = '#b8bb26',
    dark_yellow = '#d79921',
    yellow = '#fabd2f',
    dark_blue = '#458588',
    blue = '#83a598',
    dark_magenta = '#b16286',
    magenta = '#d3869b',
    dark_cyan = '#689d6a',
    cyan = '#8ec07c',
    light_grey = '#a89984',
    white = '#ebdbb2',
    dark_orange = '#d65d0e',
    orange = '#fe8019'
}

vim.api.nvim_set_hl(0, 'NotifyERRORBorder', { fg = colors.dark_red })
vim.api.nvim_set_hl(0, 'NotifyERRORIcon', { fg = colors.dark_red })
vim.api.nvim_set_hl(0, 'NotifyERRORTitle', { fg = colors.red })

vim.api.nvim_set_hl(0, 'NotifyWARNBorder', { fg = colors.dark_yellow })
vim.api.nvim_set_hl(0, 'NotifyWARNIcon', { fg = colors.dark_yellow })
vim.api.nvim_set_hl(0, 'NotifyWARNTitle', { fg = colors.yellow })

vim.api.nvim_set_hl(0, 'NotifyINFOBorder', { fg = colors.dark_blue })
vim.api.nvim_set_hl(0, 'NotifyINFOIcon', { fg = colors.dark_blue })
vim.api.nvim_set_hl(0, 'NotifyINFOTitle', { fg = colors.blue })

vim.api.nvim_set_hl(0, 'NotifyDEBUGBorder', { fg = colors.dark_magenta })
vim.api.nvim_set_hl(0, 'NotifyDEBUGIcon', { fg = colors.dark_magenta })
vim.api.nvim_set_hl(0, 'NotifyDEBUGTitle', { fg = colors.magenta })

vim.api.nvim_set_hl(0, 'NotifyTRACEBorder', { fg = colors.dark_cyan })
vim.api.nvim_set_hl(0, 'NotifyTRACEIcon', { fg = colors.dark_cyan })
vim.api.nvim_set_hl(0, 'NotifyTRACETitle', { fg = colors.cyan })
