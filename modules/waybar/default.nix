{ pkgs, lib, ... }:
{

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
    nerd-fonts.fira-code
  ];

  programs.waybar = {
    enable = true;
    settings = lib.importJSON ./config.json;
    style = ./style.css;
  };
}

