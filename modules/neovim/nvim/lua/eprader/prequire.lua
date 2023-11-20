local function render_src_path(path, depth, with_icon)
    --- A Regular Expression to match the file and its two predecessor directories.
    --- Example: "/foo/bar`/lua/eprader/init.lua`"
    local regex = "(/[%a%d_.-]+/[%a%d_.-]+/[%a%d.-]+.[%a%d]+)$"

    --- A Regular Expression to match the file name and file extention at the end of a path.
    --- Example: "/lua/eprader/`init.lua`"
    local file = "([%a%d.-]+.[%a%d]+)$"

    local rendered_path = string.match(path, regex)

    return rendered_path
end

local function build_error_message(modname, module_error)
    local info = debug.getinfo(3, "Sl")
    return "Unable to load module: \"" .. modname .. "\".\n"
        .. "in " .. render_src_path(info.source, 3, true) .. " on line "
        .. info.currentline .. "\n"
        .. "```lua\n" .. "\n```"
end

--- This function takes `modname` and returns the result of `require`
--- If require fails it will use `vim.notify` to display an expressive error message.
--- @param modname string -- The path to the module
--- @return table
return function(modname)
    local success, module = pcall(require, modname)
    if not success then
        local error_message = build_error_message(modname, module)
        vim.schedule(function()
            vim.notify(error_message, "error", {
                title = "prequire",
                on_open = function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                end,
            })
        end)
    end
    return module
end
