{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      libnotify
    ];
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(300, 600)";
        height = "(0, 300)";

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
    };
  };
}


