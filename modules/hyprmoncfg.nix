{
  config,
  lib,
  pkgs,
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

  hyprmonPkg = unstable.buildGoModule {
    pname = "hyprmoncfg";
    version = "main";

    src = pkgs.fetchFromGitHub {
      owner = "crmne";
      repo = "hyprmoncfg";
      rev = "main";
      hash = "sha256-lGB64QWhlZ/BE7YK+eod+Ev9M+MFqILQLsqd/BowQho=";
    };

    vendorHash = "sha256-gQbjvdKtO0hCXrs9RnWo1s0YeHf5W9t+8AgS2ELXlPo=";
    doCheck = false;

    ldflags = [
      "-s"
      "-w"
    ];
    postInstall = ''
      install -D packaging/systemd/hyprmoncfgd.local.service $out/lib/systemd/user/hyprmoncfgd.service

      substituteInPlace $out/lib/systemd/user/hyprmoncfgd.service \
        --replace "/usr/bin/hyprmoncfgd" "$out/bin/hyprmoncfgd" \
        --replace "ExecStart=hyprmoncfgd" "ExecStart=$out/bin/hyprmoncfgd"
    '';

    meta = {
      description = "Terminal-first monitor configurator for Hyprland";
      homepage = "https://github.com/crmne/hyprmoncfg";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };
in
{
  options.services.hyprmoncfg = {
    enable = mkEnableOption "hyprmoncfg daemon for Hyprland";
    package = mkOption {
      type = types.package;
      default = hyprmonPkg;
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
