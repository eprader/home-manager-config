{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "eprader";
        email = "56026248+eprader@users.noreply.github.com";
      };
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

