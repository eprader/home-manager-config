local ufo = require("ufo")
if not ufo then
	return
end

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- INFO: ufo provider needs a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- INFO: Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)

ufo.setup({
	close_fold_kinds = { "imports", "comment" },
	provider_selector = function()
		return { "lsp", "indent" }
	end,
})
