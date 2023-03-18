{ config, pkgs, lib, ... }:
let
  nvim = ~/home-manager-config/modules/nvim;

 # setfont = import ./setfont.nix { };

  pythonPackages = p: with p; [
    numpy
    pip
    pyyaml
    requests
    psycopg2 # python postgresql
  ];

  nodePackages = with pkgs.nodePackages; [
    prettier
    pnpm

    typescript
    typescript-language-server

    svelte-check
    svelte-language-server

    pyright
  ];

in
{
  # for desktop icons on non nixos
  # TODO: does not seem to work
  #xdg.enable = true;
  #xdg.mime.enable = true;
  #targets.genericLinux.enable = true;
  home = {
    username = "eprader";
    homeDirectory = "/home/eprader";
    stateVersion = "22.05";

    sessionVariables = {
      /* The terminal variable does not seem to work...
        installing kitty using the distros package manager and setting the default terminal with 
        sudo update-alternatives --config x-terminal-emulator
        will use the nix configwuration
      */
     # TERMINAL = "nixGL alacritty";
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
    };


    packages = with pkgs; [
      #(pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      lsd

      (python310.withPackages pythonPackages)
      #pre-commit # pre commit hooks

      gnumake
      gcc
      libclang

      #jdk11

      gradle
      maven

      #pandoc

      #fp
      ghc


      #js / ts
      nodejs
      yarn

      tree
    ] ++ nodePackages;

  };

  imports = [
    (import "${nvim}")
  ];

  #fonts.fontconfig.enable = true;

  #virtualisation.docker.enable = true;
  #users.eprader.extraGroups = [ "docker" ];

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

      vi = "nvim";
      hms = "systemctl --user reset-failed && home-manager switch";
      cat = "bat";

    };

    # The second line is needed for 'home-manager switch' to work in kitty
    #  (export TERMINFO_DIRS="$HOME/.nix-profile/share/terminfo":/lib/terminfo) 
    # third line for yed
    # fourth line for icons on Desktop
    initExtra = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
      export XDG_DATA_DIRS="/home/your_user/.nix-profile/share:$XDG_DATA_DIRS"
    '';
  };

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
    };
  };
  /*
    programs.kitty = {
    enable = true;
    settings = {
    font_size = "14.0";
    font_family = "SourceCodePro Nerd Font Mono";
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
  */
  /*programs.zathura.enable = true;

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
