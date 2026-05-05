{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;

    # INFO: https://wiki.hypr.land/Useful-Utilities/Systemd-start/#uwsm
    systemd.enable = false;

  };

  home.packages = with pkgs; [
    capitaine-cursors
  ];

  programs.hyprlock.enable = true;
}
