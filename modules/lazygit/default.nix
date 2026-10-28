{ ... }:
let
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  programs.lazygit = {
    package = unstable.lazygit;
    enable = true;
    # Replace the home-manager alias function since it leads to cds to the project root on every exit.
    # https://github.com/jesseduffield/lazygit/issues/5083
    enableBashIntegration = false;
    settings = {
      gui = {
        timeFormat = "2020-12-28";
        shortTimeFromat = "13:52";
      };
    };
  };

  programs.bash.initExtra = /* bash */ ''
    function lg() {
      local new_dir_file="$HOME/.lazygit/newdir"
      local repo_root
      repo_root=$(git rev-parse --show-toplevel 2>/dev/null)

      LAZYGIT_NEW_DIR_FILE="$new_dir_file" command lazygit "$@"

      if [ -f "$new_dir_file" ]; then
        local new_dir
        new_dir=$(cat "$new_dir_file")
        rm -f "$new_dir_file"

        # lazygit auto-chdirs to the repo root. Only follow real repo/worktree switches (upstream #5083).
        if [ -n "$new_dir" ] && [ "$(realpath "$new_dir")" != "$(realpath "$repo_root")" ]; then
          cd "$new_dir"
        fi
      fi
    }
  '';
}
