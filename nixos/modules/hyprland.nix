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
          --theme '${
            builtins.concatStringsSep ";" [
              "text=cyan"
              "time=blue"
              "container=black"
              "border=yellow"
              "title=yellow"
              "greet=orange"
              "prompt=green"
              "input=red"
              "action=magenta"
              "button=grey"
            ]
          }' \
          --asterisks \
          --asterisks-char O
        '';
      };
    };
  };
  # NOTE: Setting this fixes the pollution of the login screen by preboot log messages.
  systemd.services.greetd.serviceConfig = {
    # TODO: See if `journal` might be a better fit... ref: https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#StandardOutput=
    StandardOutput = "tty";
  };
}
