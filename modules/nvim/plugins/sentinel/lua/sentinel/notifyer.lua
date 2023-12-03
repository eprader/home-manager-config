local M = {}
M.with_icons = true
M.pred_depth = 2

-- NOTE: Activate nvim-notify if available
local notify_options = {
    title = "require",
    on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    end,
}

function M.notify(module_name, module_error)
    local message = M._build_error_message(module_name, module_error)
    vim.schedule(function() vim.notify(message, "error", notify_options) end)
end

function M._render_src_path(full_path, predecessor_depth, with_icon)
    local split_path = vim.split(full_path, "/")
    -- print("split")

    if #split_path < predecessor_depth then
        local message =
            "`predecessor_depth` was set to be larger than this path is deep.\n"
            .. "  - `available_depth`: " .. #split_path .. "\n"
            .. "  - `predecessor_depth`: " .. predecessor_depth .. "\n"
            .. "\n"
            .. "Falling back to `available_depth`..."
        vim.schedule(function() vim.notify(message, "info", notify_options) end)
    end

    local path = table.concat(split_path, "/", math.max(1, #split_path - predecessor_depth), #split_path)

    path = (with_icon and "󰈮" or "file") .. ": __" .. path .. "__"

    return path
end

function M._build_error_message(module_name, module_error)
    local debug_info = M._get_debug_info(5, "Sl")
    local module = (M.with_icons and "󰆦" or "module") .. ": __" .. module_name .. "__"
    local path = M._render_src_path(debug_info.source, M.pred_depth, M.with_icons)

    return
        path .. " on line " .. debug_info.currentline .. ".\n"
        .. module .. ".\n"
        .. "\n"
        .. "```vim\n"
        .. module_error
        .. "\n```"
end

-- BUG: some function stack levels lead to strange debug_info.
-- They appear as path = [C] and currentline = -1
-- For an error in `.../eprader/init.lua` it can be reproduced with f = 6
function M._get_debug_info(f, what)
    local debug_info = debug.getinfo(f, what)
    if debug_info then
        return debug_info
    end
    return M._get_debug_info(f - 1, what)
end

return M
