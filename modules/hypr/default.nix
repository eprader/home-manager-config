{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings = { };
    extraConfig = builtins.readFile ./hyprland.lua;

    # INFO: https://wiki.hypr.land/Useful-Utilities/Systemd-start/#uwsm
    systemd.enable = false;

  };

  home.packages = with pkgs; [
    capitaine-cursors
  ];
  xdg.configFile."hypr/keybindings.lua".source = ./keybindings.lua;
  xdg.configFile."hypr/animations.lua".source = ./animations.lua;
  programs.hyprlock.enable = true;
}
