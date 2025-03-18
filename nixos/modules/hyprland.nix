{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        hyprland = unstable.hyprland;
      })
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };

  hardware = {
    opengl.enable = true;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "de";
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
      };
    };
    # serviceConfig = {
    #   Type = "idle";
    #   StandardInput = "tty";
    #   StandardOutput = "tty";
    #   StandardError = "journal";
    #   TTYReset = true;
    #   TTYHangup = true;
    #   TTYVTDisallocate = true;
    # };
  };
}
