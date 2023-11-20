local with_icons = true
local pred_depth = 3
local with_notify = true

-- NOTE: Activate nvim-notify if available
if with_notify then
    local success, nvim_notify = pcall(require, 'notify')
    if success then vim.notify = nvim_notify end
end

local notify_options = {
    title = "prequire",
    on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    end,
}

local function notify(message, level)
    vim.schedule(function() vim.notify(message, level, notify_options) end)
end

local function render_src_path(full_path, predecessor_depth, with_icon)
    local split_path = vim.split(full_path, "/")

    if #split_path < predecessor_depth then
        local message =
            "`predecessor_depth` was set to be larger than this path is deep.\n"
            .. "  - `available_depth`: " .. #split_path .. "\n"
            .. "  - `predecessor_depth`: " .. predecessor_depth .. "\n"
            .. "\n"
            .. "Falling back to `available_depth`..."
        notify(message, "info")
    end

    local path = table.concat(split_path, "/", math.max(1, #split_path - predecessor_depth), #split_path)

    path = (with_icon and "󰈮" or "file") .. ": __" .. path .. "__"

    return path
end

local function build_error_message(modname, module_error)
    local info = debug.getinfo(3, "Sl")
    local module = (with_icons and "󰆦" or "module") .. ": __" .. modname .. "__"
    local path = render_src_path(info.source, pred_depth, with_icons)
    local line_preview = "11 local needen = prequire 'this.is_not_available"

    return "@ " .. path .. " on line " .. info.currentline .. ".\n"
        .. "```vim\n"
        .. module_error
        .. "\n```"
end

--- This function takes `modname` and returns the result of `require`
--- If require fails it will use `vim.notify` to display an expressive error message.
--- @param modname string -- The path to the module
--- @return table
local prequire = function(modname)
    local success, module = pcall(require, modname)
    if not success then
        local message = build_error_message(modname, module)
        notify(message, "error")
    end
    return module
end

return prequire
