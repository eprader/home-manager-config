{ ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
    };
    extraConfig = builtins.readFile ./btop.conf;
  };

  home.shellAliases = {
    top = "btop";
    htop = "btop";
  };
}
