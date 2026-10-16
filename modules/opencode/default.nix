{ lib, ... }:
{
  programs.opencode = {
    enable = true;
    settings = lib.importJSON ./config.json;
    # settings = lib.importJSON ./opencode.json;
    # tui = builtins.readFile ./tui.json;
  };
}
