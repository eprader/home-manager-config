/*
  NOTE: This module is an alternative to the homemanager module until
  there is support for silencing direnv just like the nixos module does.
*/
{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    direnv
    nix-direnv
  ];

  programs.bash = {
    enable = true;

    # NOTE: The export will silence direnv output
    initExtra = ''
      export DIRENV_LOG_FORMAT=
      eval "$(direnv hook bash)"
    '';
  };

}
