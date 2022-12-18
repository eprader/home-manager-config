{ pkgs, lib, ... }:
let
  #nixos-unstable = import <nixos-unstable> { };

  # function for importing git repository directly
  fromGit = name: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = name;
    version = "2022-10-28";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };

in
{
  #nixpkgs.overlays = [ (import (builtins.fetchTarball { url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #}))
  #];

  home.packages = with pkgs; [
    tree-sitter

    # LSP
    rnix-lsp
    ccls
    lldb
    sumneko-lua-language-server
    haskell-language-server
    #jdt-language-server
    sqls # SQL
  ];

  programs.neovim = {
    enable = true;
    #viAlias = true; vimAlias = true;

    extraConfig = '' 
      luafile ${./lua/settings.lua}
      luafile ${./lua/keymaps.lua}
      luafile ${./lua/telescope.lua}
      luafile ${./lua/treesitter.lua}
      luafile ${./lua/lsp.lua}
      luafile ${./lua/dressing.lua}
      luafile ${./lua/cmp.lua}
      luafile ${./lua/autopairs.lua}
      luafile ${./lua/gitsigns.lua}
      luafile ${./lua/dap.lua}
      luafile ${./lua/dapui.lua}
      luafile ${./lua/lualine.lua}
      luafile ${./lua/neotest.lua}
      luafile ${./lua/nvim-r.lua}
      luafile ${./lua/java.lua}
      luafile ${./lua/trouble.lua}
      luafile ${./lua/todo-comments.lua}
      luafile ${./lua/comment.lua}
      luafile ${./lua/toggleterm.lua}
      luafile ${./lua/overseer.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      #Eyecandy
      gruvbox-community
      tokyonight-nvim
      nvim-web-devicons
      gitsigns-nvim
      todo-comments-nvim
      nvim-notify
      dressing-nvim

      #Telescope
      plenary-nvim
      telescope-nvim

      #TreeSitter
      nvim-treesitter

      #LSP
      nvim-lspconfig
      lspsaga-nvim
      trouble-nvim

      nvim-jdtls

      #Completion
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp

      nvim-autopairs

      #Snippets
      luasnip
      cmp_luasnip
      friendly-snippets

      #Statusline
      lualine-nvim

      #Harpoon by the CEO of TheStartup™ ThePrimeagen
      harpoon

      #DAP
      nvim-dap
      nvim-dap-ui
      telescope-dap-nvim
      nvim-dap-virtual-text

      #Testing
      (fromGit "neotest" "nvim-neotest/neotest")
      (fromGit "neotest-vim-test" "nvim-neotest/neotest-vim-test")
      vim-test

      #Helpful
      comment-nvim

      #Terminal
      toggleterm-nvim

      #Tasks / code runner
      (fromGit "overseer" "stevearc/overseer.nvim")

      #Language specifics
      (fromGit "nvim-r" "jalvesaq/nvim-r")
      (fromGit "sqls-nvim" "nanotee/sqls.nvim")
      #(fromGit "typescript.nvim" "jose-elias-alvarez/typescript.nvim")

    ];
  };
}

