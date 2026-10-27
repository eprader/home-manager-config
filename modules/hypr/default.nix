{ pkgs, ... }:
{
  # INFO: Portal config lives here, not in the NixOS module, so it also works on
  # non-NixOS systems. The Hyprland module adds the hyprland backend itself.
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = "*";
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
      };
    };
  };

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
  xdg.configFile."hypr/monitors.lua".source = ./monitors.lua;
  xdg.configFile."hypr/scaling.lua".source = ./scaling.lua;
  programs.hyprlock.enable = true;
}
