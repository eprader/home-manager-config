local prequire = require "eprader.prequire"
local overseer = prequire "overseer"
if not overseer then return end

local toggleterm = prequire "toggleterm"
if toggleterm then
    overseer.setup {
        strategy = "toggleterm",
    }
    return
end

overseer.setup {}
