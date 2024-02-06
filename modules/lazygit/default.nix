{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        timeFormat = "2006-01-02";
        shortTimeFromat = "13:52";
      };
    };
  };
}
