local overseer = require "overseer"
if not overseer then return end

local toggleterm = require "toggleterm"
if toggleterm then
    overseer.setup {
        strategy = "toggleterm",
    }
    return
end

overseer.setup {}
