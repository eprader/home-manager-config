local with_icons = true
local number_of_dirs = 9

local function render_src_path(full_path, with_icon, dir_depth)
    --- Matches `/foobarbaz` dir_depth times
    --- @type string
    local dir_regex = string.rep("/[%a%d_.-]+", dir_depth, "")
    --- Matches `foo.b.arbaz` or `/foo.b.arbaz` if `dir_depth > 1`
    --- @type string
    local file_regex = (dir_depth > 0 and "/" or "") .. "[%a%d.-]+.[%a%d]+"

    --- A Regular Expression to match the file name and file extention at the end of a path.
    --- Example: "/lua/eprader/`init.lua`" or "nvim/`lua/eprader/init.lua`"
    --- @type string
    local regex = "(".. dir_regex .. file_regex ..")$"

    -- local path = string.match(full_path, regex)

    path = (with_icon and "󰈮" or "file") .. "__: " .. path .. "__"

    return path
end



local function build_error_message(modname, module_error)
    local info = debug.getinfo(3, "Sl")
    local module = (with_icons and "󰆦" or "module") .. "__: " .. modname .. "__"
    local path = render_src_path(info.source, with_icons, number_of_dirs)

    return "Unable to load " .. module .. ".\n"
        .. "in " .. path .. " on line "
        .. info.currentline .. ".\n"
        .. "```lua\n"
        .. "\n```"
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
