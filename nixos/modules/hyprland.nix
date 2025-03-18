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
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --sessions ${pkgs.hyprland}/share/wayland-sessions \
          --time \
          --remember \
          --remember-session \
          --theme 'text=cyan;time=blue;container=black;border=yellow;title=yellow;greet=orange;prompt=green;input=red;action=magenta;button=grey;' \
          --asterisks \
          --asterisks-char O
        '';
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
