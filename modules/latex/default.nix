{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # LSP
    texlab

    # Engine
    tectonic

    # Viewer
    zathura
  ];

  programs.neovim = {
    enable = true;
    extraConfig = '' 
      luafile ${../nvim/lua/vimtex.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      vimtex
    ];
  };
}
