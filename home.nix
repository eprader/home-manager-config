{ pkgs, ... }:
let
  # unstable = import <nixos-unstable> { };
  nodePackages = with pkgs.nodePackages; [
    pnpm
    typescript
  ];

  pythonPackages = p: with p; [
    pip

    pygments # NOTE: This is needed for latex minted to work.
  ];

in
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
    ./modules/nvim
    ./modules/latex.nix
    ./modules/direnv.nix
    ./modules/lazygit
  ];

  home = {
    username = "eprader";
    homeDirectory = "/home/eprader";
    stateVersion = "23.05";

    sessionVariables = {
      VISUAL = "$EDITOR";
    };

    packages = with pkgs; [
      #Desktop Environment
      # wayland
      # hyprland
      xclip # clipboard
      tmux

      # programs
      vscode
      discord-ptb
      spotify
      whatsapp-for-linux

      # Tools
      zip
      unzip
      htop
      curl
      wget

      # C
      gnumake
      gcc
      libclang

      # Python
      (python310.withPackages pythonPackages)

      # Java
      jetbrains.idea-ultimate
      plantuml

      # Haskell
      ghc

      # Virtualisation
      virt-manager
    ];

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Virtualisation / VMs
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      hms = "home-manager switch";

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      idea = "runbg idea-ultimate";
    };
    # NOTE:Add for WSl `source $HOME/.nix-profile/etc/profile.d/nix.sh`
    initExtra = ''
      source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh export XDG_DATA_DIRS="/home/your_user/.nix-profile/share:$XDG_DATA_DIRS"
      runbg () {
        "$@" >/dev/null 2>&1 &
      }
    '';
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        buttons = "@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\x4\\0\\0\\0\\x2\\0\\0\\0\\x3\\0\\0\\0\\x5\\0\\0\\0\\x6)";
        contrastOpacity = 188;
        contrastUiColor = "#282828";
        showSidePanelButton = true;
        uiColor = "#b6b2b7";
        undoLimit = 95;
      };
      Shortcuts = {
        TYPE_COPY = "Return";
      };
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "uibk" = {
        user = "csaz9581";
        hostname = "zid-gpl.uibk.ac.at";
      };

      "lcc" = {
        user = "cb761224";
        hostname = "login.lcc3.uibk.ac.at";
      };
    };
  };

  programs.zathura.enable = true;

  programs.brave.enable = true;
}
