{ config, pkgs, lib, ... }:
let

  nvim = ~/home-manager-config/modules/nvim;

  pythonPackages = p: with p; [
    pip

    # math
    numpy
    scipy
    matplotlib

    pyyaml
    requests
    opencv4
  ];

  nodePackages = with pkgs.nodePackages; [
    pnpm
    typescript
  ];

in
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home = {
    username = "eprader";
    homeDirectory = "/home/eprader";
    stateVersion = "23.05";

    sessionVariables = {
      TERMINAL = "xterm-kitty";
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
    };

    packages = with pkgs; [
      #Desktop Environment
      wayland
      hyprland
      xclip # clipboard
      (nerdfonts.override {
        fonts = [ "FiraCode" "SourceCodePro" ];
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
      pre-commit # pre commit hooks
      valgrind
      docker

      # C
      gnumake
      gcc
      llvmPackages.openmp # openmp support
      libclang
      cmake

      # Python
      (python311.withPackages pythonPackages)
      poetry # python project management


      # Java
      gradle
      maven
      #jdk11

      # Latex
      tectonic

      # Haskell
      ghc

      # Javascript
      nodejs
      yarn

      # AWS
      awscli2

    ] ++ nodePackages;

  };

  imports = [
    (import "${nvim}")
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "lsd -alF";
      la = "lsd -A";
      l = "lsd -F";
      ls = "lsd";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";
      sudop = "sudo env PATH=$PATH"; #sudo preserving user path

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      hms = "systemctl --user reset-failed && home-manager switch";
      nrs = "sudo nixos-rebuild switch";
      vi = "nvim";
      cat = "bat";

    };

    #  add to initExtra for WSl source $HOME/.nix-profile/etc/profile.d/nix.sh
    initExtra = ''
      source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      export XDG_DATA_DIRS="/home/your_user/.nix-profile/share:$XDG_DATA_DIRS"
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

  /* services.network-manager-applet = {
    enable = true;
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
        $username$hostname( $shlvl)( $directory)( $git_branch$git_commit$git_state$git_status)( $cmd_duration)( $character)
      '';
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
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family = "IosevkaTerm";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background = "#282828";
      foreground = "#ebdbb2";
      selection_foreground = "#93a1a1";
      selection_background = "#002b36";
      cursor = "#a89984";

      color0 = "#282828";
      color1 = "#cc241d";
      color2 = "#98971a";
      color3 = "#fabd2f";
      color4 = "#458588";
      color5 = "#b16286";
      color6 = "#8ec07c";
      color7 = "#a89984";

      color8 = "#928374";
      color9 = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#ebdbb2";

    };
  };

  programs.zathura.enable = true;

  programs.brave = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
  };

  /*
    programs.alacritty = {
    enable = true;

    settings = {
    window = {
    title = "Terminal";
    padding = {
    x = 1;
    y = 1;
    };
    opacity = 1;
    };

    font = setfont "FiraCode Nerd Font" // {
    size = 14.0;
    };


    colors = {
    primary = {
    background = "0x282828";
    foreground = "0xebdbb2";
    };
    cursor = {
    text = "0x282828";
    cursor = "0xa89984";
    };
    normal = {
    black = "0x282828";
    red = "0xcc241d";
    green = "0x98971a";
    yellow = "0xd79921";
    blue = "0x458588";
    magenta = "0xb16286";
    cyan = "0x689d6a";
    white = "0xa89984";
    };
    bright = {
    black = "0x928374";
    red = "0xfb4934";
    green = "0xb8bb26";
    yellow = "0xfabd2f";
    blue = "0x83a598";
    magenta = "0xd3869b";
    cyan = "0x8ec07c";
    white = "0xebdbb2";
    };
    };

    # shell.program = "${pkgs.bash}/bin/bash";

    };
    };
  */
}
