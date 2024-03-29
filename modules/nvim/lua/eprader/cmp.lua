local cmp = require "cmp"
if not cmp then return end

local sentinel = require "sentinel"
--[[
 INFO:
 Fixed in `https://github.com/L3MON4D3/LuaSnip/commit/b5e73afc82c5e0bf074a7cb47954d9432b2dde82`
 Module `luasnip-jsregexp` not available. Handled by pcall so it is safe to stop sentinel
]]
sentinel.stop()
local luasnip = require "luasnip"
if not luasnip then return end

require("luasnip.loaders.from_vscode").lazy_load()
sentinel.start()

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
if cmp_autopairs then cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()) end

local kind_icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
}

cmp.setup {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Tab>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = ({
                buffer = "",
                nvim_lsp = "",
                nvim_lua = "",
                luasnip = "",
                path = "",
                emoji = "",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer" },
        { name = "path" },
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
        { name = "cmp_nvim_lsp_signature_help" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- cmp.setup {
--     sources = {
--         { name = "nvim_lsp_signature_help" },
--     },
-- }
