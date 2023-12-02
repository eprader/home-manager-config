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

    if #split_path < predecessor_depth then
        local message =
            "`predecessor_depth` was set to be larger than this path is deep.\n"
            .. "  - `available_depth`: " .. #split_path .. "\n"
            .. "  - `predecessor_depth`: " .. predecessor_depth .. "\n"
            .. "\n"
            .. "Falling back to `available_depth`..."
        M._notify(message, "info")
    end

    local path = table.concat(split_path, "/", math.max(1, #split_path - predecessor_depth), #split_path)

    path = (with_icon and "󰈮" or "file") .. ": __" .. path .. "__"

    return path
end

function M._build_error_message(module_name, module_error)
    local info = debug.getinfo(4, "Sl")
    local module = (M.with_icons and "󰆦" or "module") .. ": __" .. module_name .. "__"
    local path = M._render_src_path(info.source, M.pred_depth, M.with_icons)

    return
        path .. " on line " .. info.currentline .. ".\n"
        .. module .. ".\n"
        .. "\n"
        .. "```vim\n"
        .. module_error
        .. "\n```"
end
return M
