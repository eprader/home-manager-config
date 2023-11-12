{ pkgs, ... }:
let
  nodePackages = with pkgs.nodePackages; [
    pnpm
    typescript
  ];

  pythonPackages = p: with p; [
    pip

    # math
    scipy
    # numpy
    matplotlib

    pyyaml
    requests
    opencv4
    redis

    pygments
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./modules/nvim
    ./modules/latex
    ./modules/terminals/kitty
    # ./modules/terminals/alacritty
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
      wayland
      hyprland
      xclip # clipboard
      (nerdfonts.override {
        fonts = [ "FiraCode" ];
      })

      # programs
      discord-ptb
      spotify
      whatsapp-for-linux
      station
      franz
      jetbrains.idea-ultimate

      # TERMINAL
      lsd
      tree

      # Tools
      zip
      unzip
      pre-commit
      valgrind
      docker
      htop
      linuxKernel.packages.linux_zen.perf
      strace

      # C
      gnumake
      gcc
      llvmPackages.openmp
      libclang
      cmake

      # Python
      (python311.withPackages pythonPackages)
      poetry # python project management


      # Java
      gradle
      maven
      #jdk11

      # Haskell
      ghc

      # Javascript
      nodejs
      yarn

      # AWS
      awscli2

      # Virtualisation
      virt-manager

      apptainer
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
      ll = "lsd -alF";
      la = "lsd -A";
      l = "lsd -F";
      ls = "lsd";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      hms = "systemctl --user reset-failed && home-manager switch";
      nrs = "sudo nixos-rebuild switch";
      cat = "bat";

    };

    #  add to initExtra for WSl source $HOME/.nix-profile/etc/profile.d/nix.sh
    initExtra = '' source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh export XDG_DATA_DIRS="/home/your_user/.nix-profile/share:$XDG_DATA_DIRS"
    '';
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        buttons = "@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\x6\\0\\0\\0\\t\\0\\0\\0\\x10\\0\\0\\0\\n\\0\\0\\0\\v\\0\\0\\0\\x17\\0\\0\\0\\f)";
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

  /* services.network-manager-applet = { enable = true;
    }; */

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
    };
  };

  programs.dircolors = {
    enable = true;
    settings = {
      ".sh" = "01;32";
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
      "*" = {
        /* NOTE: Sometimes the remote server does not know how to handle TERM=xterm-kitty or TERM=alacritty.
          * Therefore we set the TERM variable on the remote server to 
          * xterm-256color which should be more widely supported.
        */
        setEnv = { TERM = "xterm-256color"; };
      };

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
