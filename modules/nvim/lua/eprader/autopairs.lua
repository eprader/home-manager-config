local autopairs = require "nvim-autopairs"
if not autopairs then return end

autopairs.setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
}
