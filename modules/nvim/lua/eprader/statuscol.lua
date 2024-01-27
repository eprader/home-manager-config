local statuscol = require "statuscol"
if not statuscol then return end

local builtin = require "statuscol.builtin"
statuscol.setup {
    -- relculright = true,
    segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
        },
        {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
    },
}
