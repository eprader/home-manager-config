{ lib, ... }:
let
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  programs.opencode = {
    enable = true;
    package = unstable.opencode;
    settings = lib.importJSON ./opencode.json;
    tui = lib.importJSON ./tui.json;
  };
}
