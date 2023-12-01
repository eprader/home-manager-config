local M = {}

M._real_require = _G.require

function M._proxy_require(modname)
    return M._real_require(modname)
end

function M.set_proxy_require()
    _G.require = M._proxy_require
end

function M.remove_proxy_require()
    _G.require = M._real_require
end

M.set_proxy_require()
return M
