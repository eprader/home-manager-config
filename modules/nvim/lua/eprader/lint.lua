local lint = require "lint"
if not lint then return end

lint.linters_by_ft = {
    -- markdown = { "vale" },
    python = { "ruff" },
}

-- NOTE: We kind of want to mimic LSP diagnostic behaviour during typing.
vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("NvimLintTrigger", { clear = true }),
    callback = function()
        require("lint").try_lint()
    end,
})
