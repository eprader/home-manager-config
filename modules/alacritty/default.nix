{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        startup_mode = "Maximized";
        title = "Terminal";
        decorations = "full";
        dynamic_padding = true;
        dimensions = {
          columns = 90;
          lines = 30;
        };
        padding = {
          x = 1;
          y = 1;
        };
        opacity = 1;
      };

      font = {
        normal.family = "FiraCode Nerd Font Mono";
        size = 12;
        bold = { style = "Bold"; };
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
          white =
            "0xa89984";
        };
        bright = {
          black = "0x928374";
          red = "0xfb4934";
          green = "0xb8bb26";
          yellow = "0xfabd2f";
          blue = "0x83a598";
          magenta = "0xd3869b";
          cyan = "0x8ec07c";
          white =
            "0xebdbb2";
        };
      };

      # shell.program = "${pkgs.bash}/bin/bash";

    };
  };

  programs.ssh = {
    matchBlocks = {
      "*" = {
        /* NOTE: Sometimes the remote server does not know how to handle TERM=alacritty.
          * Therefore we set the TERM variable on the remote server to 
          * xterm-256color which should be more widely supported.
        */
        setEnv = { TERM = "xterm-256color"; };
      };
    };
  };
}
