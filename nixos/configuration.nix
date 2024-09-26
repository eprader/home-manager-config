{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/hyprland.nix
    ./modules/thunar.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = false;
  };

  networking = {
    hostName = "ENVY-EP";
    networkmanager.enable = true;
  };
  users.extraGroups.networkmanager.members = [ "root" "eprader" ];

  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_AT.UTF-8";
      LC_IDENTIFICATION = "de_AT.UTF-8";
      LC_MEASUREMENT = "de_AT.UTF-8";
      LC_MONETARY = "de_AT.UTF-8";
      LC_NAME = "de_AT.UTF-8";
      LC_NUMERIC = "de_AT.UTF-8";
      LC_PAPER = "de_AT.UTF-8";
      LC_TELEPHONE = "de_AT.UTF-8";
      LC_TIME = "de_AT.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  environment = {
    # systemPackages = with pkgs; [
    # ];
    interactiveShellInit = ''
      alias nrs="sudo nixos-rebuild switch"
    '';
  };

  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.docker_26;
      # BUG: Not working with `k3d` due to `cgroup` issue
      # rootles = {
      #     enable = true;
      #     setSocketVariable = true;
      # };
    };
    # virtualbox.host.enable = true;
  };
  # users.extragroups.vboxusers.members = [ "eprader" ];

  services = {
    pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    openssh.enable = true;
  };

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    nix-ld = {
      enable = true;
      # libraries = with pkgs; [
      #   stdenv.cc.cc.lib
      # ];
    };
  };

  users = {
    # INFO: `mutableUsers` allows to change password dynamically.
    mutableUsers = true;
    users.eprader = {
      isNormalUser = true;
      description = "Emanuel Prader";
      extraGroups = [ "wheel" ];
      # INFO:
      # This password will only be set during the initial creation of this user.
      # Make sure to change the password using `passwd`
      password = "42";
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

