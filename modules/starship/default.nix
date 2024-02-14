{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $username$hostname( $shlvl)( $directory)( $git_branch$git_commit$git_state$git_status)( $nix_shell)( $cmd_duration)( $character) '';
      username = {
        format = "[$user]($style)";
        show_always = true;
      };
      hostname = {
        format = "[@$hostname]($style)";
        style = "bold green";
        ssh_only = false;
      };
      shlvl = {
        format = "[$shlvl]($style)";
        style = "bold cyan";
        threshold = 2;
        repeat = true;
      };
      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style))";
        style = "bold blue";
      };
      nix_shell = {
        format = "via [$symbol]($style)";
        symbol = "󱄅";
        style = "blue";
      };
      cmd_duration = {
        format = "took [$duration]($style)";
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      scan_timeout = 10;
      package.disabled = true;
    };
  };
}
