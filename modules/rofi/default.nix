{ ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    modes = [ "drun" ];
    theme = ./theme.rasi;
    extraConfig = {
      display-drun = "";
      hide-scrollbar = true;
      sidebar-mode = false;
    };
  };
}
