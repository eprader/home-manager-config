require 'telescope'.setup {
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
    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
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

require 'telescope'.load_extension('fzf')

local map = vim.keymap.set
map('n', '<leader>fs', ":Telescope current_buffer_fuzzy_find<cr>")
map('n', '<leader>ps', ":Telescope find_files<cr>")
map('n', '<leader>ld', ":Telescope diagnostics<cr>")

local colors = {
  black = '#1d2021',
  black2 = '#3c3836',
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

vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = colors.black })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = colors.black2 })

vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.black2, bg = colors.black2 })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.black, bg = colors.dark_magenta })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = colors.white, bg = colors.black2 })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.dark_red, bg = colors.black2 })

vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = colors.black, bg = colors.black })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = colors.black, bg = colors.blue })

vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = colors.black, bg = colors.black })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = colors.black, bg = colors.black })

vim.api.nvim_set_hl(0, 'TelescopeResultsDiffAdd', { fg = colors.dark_green })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffChange', { fg = colors.dark_cyan })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffDelete', { fg = colors.dark_red })
