{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = unstable.hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  home.packages = with pkgs; [
    capitaine-cursors
  ];
}
