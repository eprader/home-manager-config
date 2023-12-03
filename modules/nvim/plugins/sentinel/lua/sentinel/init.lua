local M = {}

M._real_require = _G.require

function M._proxy_require(modname)
    local success, module = pcall(M._real_require, modname)
    if not success then
        local ok, notifyer = pcall(M._real_require, "sentinel.notifyer")
        if not ok then
            vim.schedule(function()
                vim.notify(
                    "Unable to load `sentinel.notifyer`",
                    "error",
                    { title = "Sentinel internal" }
                )
            end)
            return
        end
        notifyer.notify(modname, module)
    end
    return module
end

function M.start()
    _G.require = M._proxy_require
end

function M.stop()
    _G.require = M._real_require
end

M.start()
return M
