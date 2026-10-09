{ pkgs, ... }:
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
    lfs.enable = true; # installs git-lfs and runs `git lfs install --global` for you
  };

  home.packages = with pkgs; [
    git-filter-repo
  ];
}
