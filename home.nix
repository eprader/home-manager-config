{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
  nodePackages = with pkgs.nodePackages; [
    pnpm
    typescript
  ];

  pythonPackages = p: with p; [
    pip

    pygments # NOTE: This is needed for latex minted to work

    scipy
    numpy
    # matplotlib # NOTE: collision on six.py. removed temporarily.
  ];

in
{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/kitty
    ./modules/lsd.nix
    ./modules/nvim
    ./modules/latex.nix
    ./modules/direnv.nix
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
      (python311.withPackages pythonPackages)

      poetry # python project management

      jetbrains.mps
      # Java
      jetbrains.idea-ultimate
      gradle
      maven
      jdk11

      # Haskell
      ghc

      # Javascript
      nodejs

      # AWS
      awscli2

      # Virtualisation
      virt-manager

      redis
    ] ++ nodePackages;

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

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $username$hostname( $shlvl)( $directory)( $git_branch$git_commit$git_state$git_status)( $cmd_duration)( $character) '';
      username = {
        format = "[$user]($style)";
        show_always = true;
      };
      hostname = {
        format = "[@$hostname]($style)";
        style = "bold green";
        ssh_only = false;
      };
      shlvl = {
        format = "[$shlvl]($style)";
        style = "bold cyan";
        threshold = 2;
        repeat = true;
      };
      cmd_duration = {
        format = "took [$duration]($style)";
      };
      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style))";
        style = "bold blue";
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      scan_timeout = 10;
      package.disabled = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "eprader";
    userEmail = "56026248+eprader@users.noreply.github.com";
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "uibk" = {
        user = "csaz9581";
        hostname = "zid-gpl.uibk.ac.at";
      };

      "lcc" = {
        user = "cb761119";
        hostname = "lcc2.uibk.ac.at";
      };
    };
  };


  programs.zathura.enable = true;

  programs.brave = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
  };

}
