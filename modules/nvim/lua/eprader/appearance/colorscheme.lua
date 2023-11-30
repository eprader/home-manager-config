local require = require "eprader.prequire"

vim.cmd.colorscheme("gruvbox")
vim.g.gruvbox_contrast_dark = "medium"

local api = vim.api
if (vim.g.colors_name == "gruvbox") then
    local treesitter = require "nvim-treesitter"
    if treesitter then
        api.nvim_set_hl(0, "@parameter.python", { link = "GruvboxYellowBold" })
    end

    api.nvim_set_hl(0, "Delimiter", { link = "GruvboxGray" })
end
