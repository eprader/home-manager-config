{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family = "FiraCode Nerd Font Mono";
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

  programs.ssh = {
    matchBlocks = {
      "*" = {
        /* NOTE: Sometimes the remote server does not know how to handle TERM=xterm-kitty.
          * Therefore we set the TERM variable on the remote server to 
          * xterm-256color which should be more widely supported.
        */
        setEnv = { TERM = "xterm-256color"; };
      };
    };
  };
}
