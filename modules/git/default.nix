{ ... }:
{
  programs.git = {
    enable = true;
    userName = "eprader";
    userEmail = "56026248+eprader@users.noreply.github.com";
    # INFO: Deprecated and will be removed
    # extraConfig = builtins.readFile ./.gitconfig;
    extraConfig = {
      pull = {
        rebase = true;
        prune = true;
      };
      fetch = {
        prune = true;
      };
    };
  };
}

