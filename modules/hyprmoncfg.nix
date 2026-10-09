{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.services.hyprmoncfg;
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  options.services.hyprmoncfg = {
    enable = mkEnableOption "hyprmoncfg daemon for Hyprland";
    package = mkOption {
      type = types.package;
      default = unstable.hyprmoncfg;
      description = "The hyprmoncfg package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    systemd.user.services.hyprmoncfgd = {
      Unit = {
        Description = "Hyprland monitor profile daemon (hyprmoncfgd)";
        After = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/hyprmoncfgd";
        Restart = "on-failure";
        RestartSec = 2;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
