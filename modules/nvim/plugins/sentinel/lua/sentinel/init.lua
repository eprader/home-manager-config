local M = {}

M._real_require = _G.require

function M._proxy_require(modname)
    local success, module = pcall(M._real_require, modname)
    if not success then
        -- TODO: import messaging

        --[[ local message = build_error_message(modname, module)
        notify(message, "error") ]]
    end
    return module
end

function M.set_proxy_require()
    _G.require = M._proxy_require
end

function M.remove_proxy_require()
    _G.require = M._real_require
end

M.set_proxy_require()
return M
