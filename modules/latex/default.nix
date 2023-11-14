{ pkgs, ... }:
let
  # TODO: Python packages can not be merged that easily look into how to do so.
  pythonPackages = p: with p; [
    pygments
  ];
in
{
  home.packages = with pkgs; [
    # LSP
    texlab

    # Engine
    # tectonic
  ];

  # Viewer
  programs.zathura.enable = true;

  programs.neovim = {
    extraConfig = '' 
      luafile ${../nvim/lua/eprader/vimtex.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      vimtex
    ];
  };
}
