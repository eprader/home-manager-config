{ pkgs, ... }:
let
  unstable = import <nixos-unstable> {};

  # function for importing git repository directly
  fromGit = name: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = name;
    version = "2023-14-11";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };

  nodePackages = with pkgs.nodePackages; [
    pyright
    prettier
    typescript-language-server
    svelte-language-server
    # grammarly-languageserver
  ];

  # TODO: find out a way to only need init.lua for nvim config to work (require should be able to load other modules)

  # NOTE: this did not work as it seems like nvim only looks for .lua files in specific folders.
  # Seems like custom files only end up in those folders with luafile syntax
  nvim-config = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-config";
    src = ./.;
  };
in
{
  imports = [
  ];

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      tree-sitter
      lldb
      # formatter
      yapf

      # LSP
      rnix-lsp
      nil
      unstable.nixd
      ccls
      sumneko-lua-language-server
      haskell-language-server
      ltex-ls # language-tool / spelling
      sqls
      #jdt-language-server
    ] ++ nodePackages;
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true; # sets $EDITOR variable

    #luafile ${./lua/neotest.lua}
     extraConfig = '' 
      luafile ${./lua/eprader/settings.lua}
      luafile ${./lua/eprader/keymaps.lua}
      luafile ${./lua/eprader/telescope.lua}
      luafile ${./lua/eprader/treesitter.lua}
      luafile ${./lua/eprader/lsp.lua}
      luafile ${./lua/eprader/dressing.lua}
      luafile ${./lua/eprader/cmp.lua}
      luafile ${./lua/eprader/harpoon.lua}
      luafile ${./lua/eprader/autopairs.lua}
      luafile ${./lua/eprader/gitsigns.lua}
      luafile ${./lua/eprader/dap.lua}
      luafile ${./lua/eprader/dapui.lua}
      luafile ${./lua/eprader/lualine.lua}
      luafile ${./lua/eprader/notify.lua}
      luafile ${./lua/eprader/nvim-r.lua}
      luafile ${./lua/eprader/java.lua}
      luafile ${./lua/eprader/trouble.lua}
      luafile ${./lua/eprader/todo-comments.lua}
      luafile ${./lua/eprader/comment.lua}
      luafile ${./lua/eprader/toggleterm.lua}
      luafile ${./lua/eprader/overseer.lua}
      luafile ${./lua/eprader/vimtex.lua}
      ''; 
    /*extraConfig = ''
      luafile ${./init.lua}
    '';*/

    plugins = with pkgs.vimPlugins; [
      #nvim-config

      #Eyecandy
      gruvbox-community
      # tokyonight-nvim
      # (fromGit "one-monokai" "cpea2506/one_monokai.nvim")
      # (fromGit "catpuccin" "catppuccin/nvim")
      # onedark-nvim
      nvim-web-devicons
      todo-comments-nvim
      nvim-notify
      dressing-nvim

      #Git
      gitsigns-nvim
      git-blame-nvim

      #Telescope
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      #TreeSitter
      nvim-treesitter

      #HTML autotags
      nvim-ts-autotag

      #LSP
      nvim-lspconfig
      lspsaga-nvim
      trouble-nvim
      ltex_extra-nvim

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

