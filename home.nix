{ pkgs, ... }:

{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/git
    ./modules/kitty
    ./modules/starship
    ./modules/lsd.nix
    ./modules/lazygit
    ./modules/nvim
    ./modules/latex.nix
    ./modules/hypr
    ./modules/kanshi
    ./modules/waybar
    ./modules/direnv.nix
    ./modules/btop.nix
  ];

  home = {
    username = "eprader";
    homeDirectory = "/home/eprader";

    sessionVariables = {
      VISUAL = "$EDITOR";
    };

    shellAliases = {
      hms = "home-manager switch";
    };

    packages = with pkgs; [
      wl-clipboard
      rofi-wayland
      # neo4j-desktop

      zip
      unzip
      curl
      wget
      jq

      discord-ptb

      jetbrains.idea-oss
    ];
  };

  # xdg.desktopEntries.neo4j-desktop = {
  #   name = "Neo4j Desktop (Wayland)";
  #   exec = "env NIXOS_OZONE_WL=1 QT_QPA_PLATFORM=wayland SDL_VIDEODRIVER=wayland WAYLAND_DISPLAY=wayland-0 neo4j-desktop %U";
  #   icon = "neo4j-desktop";
  #   categories = [ "Development" ];
  # };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true; # INFO: Sets `XCURSOR_THEME` and `XCURSOR_SIZE`
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  programs.bash = {
    enable = true;
    # INFO:
    # `.profile` include is needed for `home.sessionVariables` to work.
    initExtra = /* bash */ ''
      [[ -f ~/.profile ]] && . ~/.profile
    '';
  };

  # trace: warning: `programs.ssh` default values will be removed in the future.
  # Consider setting `programs.ssh.enableDefaultConfig` to false,
  # and manually set the default values you want to keep at
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      # "*" =
      # {
      # ForwardAgent = false;
      # AddKeysToAgent = false;
      #
      # ServerAliveInterval = 30;
      # ServerAliveCountMax = 2;
      #
      # Compression = false;
      # HashKnownHosts no
      # UserKnownHostsFile ~/.ssh/known_hosts
      # ControlMaster no
      # ControlPath ~/.ssh/master-%r@%n:%p
      # ControlPersist no
      # };
      "uibk" = {
        user = "csaz9581";
        hostname = "zid-gpl.uibk.ac.at";
        # extraOptions = {
        #   ChallengeResponseAuthentication = "yes";
        #   GSSAPIAuthentication = "yes";
        # };
      };
      "lcc3" = {
        user = "cb761029";
        hostname = "login.lcc3.uibk.ac.at";
      };
    };
  };

  programs.hyprshot.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "oldceeleldhonbafppcapldpdifcinji"; } # languagetool
      { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # grammarly

    ];
  };

  # services.flameshot = {
  #   enable = true;
  # settings = {
  #   General = {
  #     buttons = "@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\x4\\0\\0\\0\\x2\\0\\0\\0\\x3\\0\\0\\0\\x5\\0\\0\\0\\x6)";
  #     contrastOpacity = 188;
  #     contrastUiColor = "#282828";
  #     showSidePanelButton = true;
  #     uiColor = "#b6b2b7";
  #     undoLimit = 95;
  #   };
  #   Shortcuts = {
  #     TYPE_COPY = "Return";
  #   };
  # };
  # };

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
