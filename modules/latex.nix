{ pkgs, ... }:
let
  # TODO: Python packages can not be merged that easily look into how to do so.
  pythonPackages = with pkgs.python311Packages; [
    pygments
  ];
in
{
  home.packages = with pkgs; [
    # LSP
    texlab

    # Engine
    tectonic # NOTE: This also does package managing for latex packages
  ];

  # Viewer
  programs.zathura.enable = true;

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vimtex
    ];

    extraConfig = '' 
      lua require 'eprader.vimtex'
    '';
  };
}
