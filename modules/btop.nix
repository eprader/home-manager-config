{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      btop
    ];
    shellAliases = {
      top = "btop";
    };
  };
}
