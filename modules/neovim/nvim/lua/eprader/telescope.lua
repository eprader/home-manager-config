local prequire = require "eprader.prequire"
local telescope = prequire "telescope"
if not telescope then return end

telescope.setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            }
        },
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        -- Prompt configuration was mainly copied from NvChad: https://github.com/NvChad/NvChad
        prompt_prefix = "  | ",
        sorting_strategy = "ascending",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require "telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require "telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

telescope.load_extension "fzf"

-- KEYBINDS
prequire "eprader.mapleader"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>fs", ":Telescope current_buffer_fuzzy_find<cr>", opts)
map("n", "<leader>ff", ":Telescope find_files<cr>", opts)
map("n", "<leader>fd", ":Telescope diagnostics<cr>", opts)
map("n", ":h", ":Telescope help_tags<cr>", opts)

-- HIGHLIGHT GROUPS
local highlights = {
    TelescopeNormal = "Normal",
    TelescopeSelection = "CursorLine",

    TelescopeBorder = "NonText",

    -- TODO: Should be default as in the sourcecode of telescope...
    -- https://github.com/nvim-telescope/telescope.nvim/blob/18774ec7929c8a8003a91e9e1f69f6c32258bbfe/plugin/telescope.lua#L19
    TelescopePromptBorder = "TelescopeBorder",
    TelescopePreviewBorder = "TelescopeBorder",
    TelescopeResultsBorder = "TelescopeBorder",

    TelescopePromptTitle = "String",
    TelescopePromptPrefix = "TelescopePromptTitle",

    TelescopeResultsTitle = "Keyword",

    TelescopePreviewTitle = "Number",
    TelescopePreviewLine = "CursorLine",
}

for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, { link = v })
end
