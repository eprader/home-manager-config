local M = {}

M._real_require = _G.require

function M._proxy_require(modname)
    local success, module = pcall(M._real_require, modname)
    if not success then
        local notifyer = M._real_require "sentinel.notifyer"
        notifyer.notify(modname, module)
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
