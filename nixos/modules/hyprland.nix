{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # INFO: This option hints electron apps to use wayland
    NIXOS_OXOZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
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
