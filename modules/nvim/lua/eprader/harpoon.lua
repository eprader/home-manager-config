local harpoon = require "harpoon"
if not harpoon then return end

harpoon.setup {
    global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,
    },

    projects = {
        -- Yes $HOME works
        --[[ ["$HOME/personal/vim-with-me/server"] = {
      term = {
        cmds = {
          "./env && npx ts-node src/index.ts"
        }
      }
    } ]]
    }
}

-- KEYBINDS
require "eprader.mapleader"

local map = vim.keymap.set
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
map("n", "<leader>ha", harpoon_mark.add_file)
map("n", "<leader>hl", harpoon_ui.toggle_quick_menu)
map("n", "<C-j>", function() harpoon_ui.nav_file(1) end)
map("n", "<C-k>", function() harpoon_ui.nav_file(2) end)
map("n", "<C-l>", function() harpoon_ui.nav_file(3) end)
