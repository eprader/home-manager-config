require 'neotest'.setup({
  adapters = {
    require 'neotest-vim-test' ({
    }),
  },

  icons = {
    passed = "✔",
    running = "",
    failed = "✖",
    skipped = "ﰸ",
    unknown = "?",
    non_collapsible = "─",
    collapsed = "─",
    expanded = "╮",
    child_prefix = "├",
    final_child_prefix = "╰",
    child_indent = "│",
    final_child_indent = " ",
  },
  highlights = {
    passed = "GruvboxGreenSign",
    running = "GruvboxYellowSign",
    failed = "GruvboxRedSign",
    skipped = "GruvboxAquaSign",
    test = "GruvboxFg0",
    namespace = "GruvboxPurple",
    focused = "NeotestFocused",
    file = "GruvboxAqua",
    dir = "GruvboxBlue",
    border = "NeotestBorder",
    indent = "NeotestIndent",
    expand_marker = "NeotestExpandMarker",
    adapter_name = "GruvboxOrange",
    select_win = "NeotestWinSelect",
    marked = "NeotestMarked",
    target = "NeotestTarget",
    unknown = "GruvboxFg0",
  },
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
})

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>ta', ":lua require 'neotest'.run.run(vim.fn.expand(\" % \"))<cr>", opts)
map('n', '<leader>ts', ":lua require 'neotest'.summary.toggle()<cr>", opts)
