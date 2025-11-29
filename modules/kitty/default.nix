{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        /*
          NOTE: Sometimes the remote server does not know how to handle TERM=xterm-kitty.
          Therefore we set the TERM variable on the remote server to 
          xterm-256color which should be more widely supported.
        */
        setEnv = { TERM = "xterm-256color"; };
      };
    };
  };
}
