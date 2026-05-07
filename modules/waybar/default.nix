{ pkgs, lib, ... }:
{

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
  ];

  services.blueman-applet.enable = true;

  programs.waybar = {
    enable = true;
    settings = lib.importJSON ./config.json;
    style = ./style.css;
  };
}
