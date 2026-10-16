{ lib, ... }:
{
  programs.opencode = {
    enable = true;
    settings = lib.importJSON ./opencode.json;
    tui = lib.importJSON ./tui.json;
  };
}
