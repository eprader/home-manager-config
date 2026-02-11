{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

  # function for importing git repository directly
  fromGit = name: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = name;
    version = "2023-14-11";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };

  nodePackages = with pkgs.nodePackages; [
    prettier
    typescript-language-server
  ];

  eprader-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "eprader-nvim";
    src = ./.;
    doCheck = false;
  };

  sentinel-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "sentinel-nvim";
    src = ./plugins/sentinel;
    doCheck = false;
  };
in
{
  home = {
    packages = with pkgs; [
      tree-sitter

      #for Telescope
      ripgrep
      fd

      lldb

      # formatters
      nixpkgs-fmt

      stylua

      pyright
      yapf
      black
      isort

      # linters
      vale

      # LSP
      nil
      nixd
      ccls
      lua-language-server
      haskell-language-server
      tailwindcss-language-server
      yaml-language-server
      helm-ls
    ] ++ nodePackages;
  };

  # NOTE: Install neovim from `unstable` channel.
  nixpkgs.overlays = [
    (self: super: {
      neovim-unwrapped = unstable.neovim-unwrapped;
    })
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true; # sets $EDITOR variable
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      eprader-nvim # The lua config in ./config as a plugin
      sentinel-nvim # local prequire plugin

      plenary-nvim
      nvim-treesitter.withAllGrammars
      nvim-notify

      #Eyecandy
      gruvbox-community
      nvim-web-devicons
      todo-comments-nvim
      dressing-nvim
      nvim-colorizer-lua
      nvim-ufo
      markview-nvim

      #Git
      gitsigns-nvim

      #Telescope
      telescope-nvim
      telescope-fzf-native-nvim

      #HTML autotags
      nvim-ts-autotag

      #LSP
      lspkind-nvim
      nvim-lspconfig
      lspsaga-nvim
      trouble-nvim

      # lint
      nvim-lint

      # formatting
      conform-nvim

      #Completion
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp-signature-help
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
      # (fromGit "neotest" "nvim-neotest/neotest")
      # (fromGit "neotest-vim-test" "nvim-neotest/neotest-vim-test")
      # vim-test

      #Helpful
      comment-nvim

      #Terminal
      toggleterm-nvim

      # Tasks / code runner
      # (fromGit "overseer" "stevearc/overseer.nvim")
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
