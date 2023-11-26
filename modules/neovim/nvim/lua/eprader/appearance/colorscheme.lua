local prequire = require "eprader.prequire"
--local gruvbox = prequire "gruvbox_community"

vim.cmd.colorscheme('gruvbox')
vim.g.gruvbox_contrast_dark = 'medium'

local api = vim.api
if (vim.g.colors_name == "gruvbox") then
    local treesitter = prequire "nvim-treesitter"
    if treesitter then
        api.nvim_set_hl(0, '@parameter.python', { link = 'GruvboxYellowBold' })
    end

    api.nvim_set_hl(0, 'Delimiter', { link = 'GruvboxGray' })
end
