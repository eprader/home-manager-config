{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lsd
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "lsd";
      ll = "lsd -alF";
      la = "lsd -A";
      tree = "lsd --tree";
    };
  };
}
