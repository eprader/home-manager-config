{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      lsd
    ];

    shellAliases = {
      ls = "lsd";
      ll = "lsd -alF";
      la = "lsd -A";
      tree = "lsd --tree";
    };
  };
}
