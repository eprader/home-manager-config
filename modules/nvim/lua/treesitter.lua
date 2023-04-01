-- following two lines were needed as treesitter needed to be installed at read write location...
--local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
--vim.fn.mkdir(parser_install_dir, "p")
require 'nvim-treesitter.configs'.setup {

    -- autotag completion
    autotag = {
        enable = true,
    },
    -- A list of parser names, or "all"
    ensure_installed = {},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    indent = {
        enable = true
    },

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { 'latex' },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    -- needed for install location
    parser_install_dir = "~/treesitter/parsers" -- https://github.com/NixOS/nixpkgs/issues/189838
}

vim.opt.runtimepath:append("~/treesitter/parsers")
