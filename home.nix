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
      libreoffice-qt

      zip
      unzip
      curl
      wget
      jq
      flink

      fastfetch

      discord-ptb

      jetbrains.idea-community
      vscode
      gcc
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

  programs.zathura.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "oldceeleldhonbafppcapldpdifcinji"; } # languagetool
      { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # grammarly

    ];
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        buttons = "@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\x4\\0\\0\\0\\x2\\0\\0\\0\\x3\\0\\0\\0\\x5\\0\\0\\0\\x6)";
        contrastOpacity = 188;
        contrastUiColor = "#282828";
        showSidePanelButton = true;
        uiColor = "#b6b2b7";
        undoLimit = 95;
      };
      Shortcuts = {
        TYPE_COPY = "Return";
      };
    };
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
