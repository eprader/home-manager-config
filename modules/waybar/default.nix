{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
  ];

  programs.waybar = {
    enable = true;
    settings = lib.importJSON ./config.jsonc;
    style = ./style.css;
  };
}

