-- Keymaps
local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end

  vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
end

map('<leader>db', require 'dap'.toggle_breakpoint, "continue")
map("<leader>dB", function()
  require 'dap'.set_breakpoint(vim.fn.input "[DAP] Condition : ")
end)
map('<leader>dj', require 'dap'.continue, "continue")
map('<leader>dk', require 'dap'.step_back, "step_back")
map('<leader>di', require 'dap'.step_into, "step_into")
map('<leader>ds', require 'dap'.step_over, "step_over")
map('<leader>do', require 'dap'.step_out, "step_out")

-- Icons
vim.fn.sign_define('DapStopped', { text = 'ඞ ', texthl = 'GruvboxGreenSign', linehl = 'CursorLine', numhl = '' })
vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'GruvboxRedSign', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'GruvboxRedSign', numhl = '' })

-- C++ and C
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/home/emanuel/.nix-profile/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:
dap.configurations.c = dap.configurations.cpp
