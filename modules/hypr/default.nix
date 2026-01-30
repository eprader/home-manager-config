{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = unstable.hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;

    # INFO: https://wiki.hypr.land/Useful-Utilities/Systemd-start/#uwsm
    systemd.enable = false;

  };

  home.packages = with pkgs; [
    capitaine-cursors
  ];
}
