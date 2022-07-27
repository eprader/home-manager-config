{ config, pkgs, lib, ... }:
let
  nvim = ~/home-manager-config/modules/nvim;


in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home = {
    username = "emanuel";
    homeDirectory = "/home/emanuel";
    stateVersion = "22.05";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
    };

    packages = [
      (pkgs.nerdfonts.override {
        fonts = [
          "SourceCodePro"
        ];
      })

      pkgs.gnumake
      pkgs.gcc
      pkgs.jdk
      pkgs.gradle
    ];
  };

  imports = [
    (import "${nvim}")
  ];

  programs.bash = {
    enable = true;

    shellAliases = {
      vi = "nvim";
      hms = "systemctl --user reset-failed && home-manager switch";
      cat = "bat";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
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

  programs.dircolors = {
    enable = true;
    settings = {
      DIR = "01;34";
      ".sh" = "01;32";
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
    };
  };

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";
        padding = {
          x = 2;
          y = 2;
        };
        opacity = 1.0;
      };

      font = {
        normal.family = "SourceCodePro Nerd Font";
        size = 11.0;
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

      shell.program = "${pkgs.bash}/bin/bash";

    };
  };

}
