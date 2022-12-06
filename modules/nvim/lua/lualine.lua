--Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore
local colors = {
  black = '#282828',
  dark_grey = '#928374',

  darg_red = '#cc241d',
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
  white = 'ebdbb2',

  dark_orange = '#d65d0e',
  orange = '#fe8019';
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.white, bg = colors.black } },
      inactive = { c = { fg = colors.white, bg = colors.black } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return ' '
  end,
}

ins_left {
  -- mode component
  function()
    return '⌨'
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.dark_green,
      v = colors.dark_blue,
      ['␖'] = colors.blue,
      V = colors.dark_blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      ['␓'] = colors.orange,
      ic = colors.yellow,
      R = colors.dark_magenta,
      Rv = colors.dark_magenta,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

--[[ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}]]

ins_left {
  function()
    return ' '
  end,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.dark_blue, gui = 'bold' },
  path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
}

ins_left {
  'location',
  color = { fg = colors.dark_grey, gui = 'bold' },
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = " ", warn = " ", hint = " ", info = " " };
  diagnostics_color = {
    color_error = { fg = colors.dark_red },
    color_warn = { fg = colors.dark_yellow },
    color_info = { fg = colors.dark_cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  'branch',
  icon = '',
  color = { fg = colors.dark_magenta, gui = 'bold' },
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.dark_green },
    modified = { fg = colors.dark_cyan },
    removed = { fg = colors.dark_red },
  },
  cond = conditions.hide_in_width,
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.dark_green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.dark_green, gui = 'bold' },
}

ins_right {
  'filetype',
  fmt = string.lower,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.dark_grey, gui = 'bold' },
}

ins_right {
  -- Lsp server name .
  function()
    local msg = '∅'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = '',
  color = { fg = colors.dark_yellow, gui = 'bold' },
}



-- Now don't forget to initialize lualine
lualine.setup(config)
