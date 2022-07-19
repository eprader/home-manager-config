require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      layout_config = {
        prompt_position = "top",
        prompt_prefix = "🔍>",
        --sorting_strategy = "ascending"
      },
    },
    current_buffer_fuzzy_find = {
      layout_config = {
        prompt_position = "top",
        prompt_prefix = "🔍>",
        --sorting_strategy = "ascending"
      },
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

local map = vim.keymap.set
map('n', '<leader>fs', ":Telescope current_buffer_fuzzy_find<cr>")
map('n', '<leader>ps', ":Telescope find_files<cr>")
map('n', '<leader>ld', ":Telescope diagnostics<cr>")
