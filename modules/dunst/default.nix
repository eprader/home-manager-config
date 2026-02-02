{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      libnotify
    ];
  };

  services.dunst = {
    enable = true;
    settings =
      {
        global = {
          width = "(300, 600)";
          height = "(0, 300)";
          offset = "(16, 16)";

          frame_width = 1;
          frame_color = "#ebdbb2";
          foreground = "#ebdbb2";
          background = "#282828";
          corner_radius = 5;
          corners = "all";
          font = "Fira Code Nerd Font Mono 12";
          gap_size = 8;

          notification_limit = 5;

        };

        # black = "#282828",
        # dark_grey = "#928374",
        #
        # dark_red = "#cc241d",
        # red = "#fb4934",
        #
        # dark_green = "#98971a",
        # green = "#b8bb26",
        #
        # dark_yellow = "#d79921",
        # yellow = "#fabd2f",
        #
        # dark_blue = "#458588",
        # blue = "#83a598",
        #
        # dark_magenta = "#b16286",
        # magenta = "#d3869b",
        #
        # dark_cyan = "#689d6a",
        # cyan = "#8ec07c",
        #
        # light_grey = "#a89984",
        # white = "#ebdbb2",
        #
        # dark_orange = "#d65d0e",
        # orange = "#fe8019",

        urgency_low = {
          frame_color = "#83a598";
        };
        urgency_normal = {
          frame_color = "#98971a";
        };
        urgency_critical = {
          frame_color = "#cc241d";
        };
      };
  };
}


