{ pkgs, ... }:
{
  programs.waybar.enable = true;

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
  ];
}

