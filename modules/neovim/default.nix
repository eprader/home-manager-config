{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };

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

  eprader-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "eprader-nvim";
    src = ./nvim;
  };
in
{
  home = {
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
    defaultEditor = true; # sets $EDITOR variable
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      eprader-nvim # The lua config in ./config as a plugin

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

    /* NOTE: The eprader-config-nvim plugin is accessible via 'eprader'. 
      * This is the name of the subfolder in ./nvim/lua
    */
    extraConfig = ''
      lua require 'eprader'
    '';
  };
}
