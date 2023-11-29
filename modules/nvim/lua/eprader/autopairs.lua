local autopairs = require "eprader.prequire"("nvim-autopairs")

autopairs.setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
}
