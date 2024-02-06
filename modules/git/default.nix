{ ... }:
{
  programs.git = {
    enable = true;
    userName = "eprader";
    userEmail = "56026248+eprader@users.noreply.github.com";
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

