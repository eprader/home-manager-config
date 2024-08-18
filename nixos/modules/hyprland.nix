{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # INFO: This option hints electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    # INFO:
    # As of 2024/09/18: The Discord launch script checks for both `QT_QPA_PLATFORM` and `WAYLAND_DISPLAY`.
    # https://github.com/NixOS/nixpkgs/blob/5c82cc835ae9d7d7aed8e338d577c3241e60cdcd/pkgs/applications/networking/instant-messengers/discord/linux.nix#L108
    WAYLAND_DISPLAY = "";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
  };

  hardware = {
    opengl.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
