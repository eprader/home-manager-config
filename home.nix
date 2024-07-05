{ pkgs, ... }:

{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/git
    ./modules/kitty
    ./modules/starship
    ./modules/lsd.nix
    ./modules/lazygit
    ./modules/nvim
    ./modules/hypr
    ./modules/waybar
    ./modules/direnv.nix
    ./modules/btop.nix
  ];

  home = {
    username = "eprader";
    homeDirectory = "/home/eprader";

    sessionVariables = {
      VISUAL = "$EDITOR";
    };

    shellAliases = {
      hms = "home-manager switch";
    };

    packages = with pkgs; [
      wl-clipboard
      rofi-wayland

      zip
      unzip
      curl
      wget
      jq

      fastfetch

      discord-ptb

      jetbrains.idea-community
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true; # INFO: Sets `XCURSOR_THEME` and `XCURSOR_SIZE`
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  programs.bash = {
    enable = true;
    # INFO:
    # `.profile` include is needed for `home.sessionVariables` to work.
    initExtra = /* bash */ ''
      [[ -f ~/.profile ]] && . ~/.profile
    '';
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
