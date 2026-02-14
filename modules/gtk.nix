{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts-color-emoji
    ];
    pointerCursor = {
      gtk.enable = true;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "FiraCode Nerd Font Mono" ];
      sansSerif = [ "FiraCode Nerd Font" ];
      serif = [ "FiraCode Nerd Font" ];

    };
  };

  gtk = {
    enable = true;
    # INFO: `font` is handled via `fonts.fontconfig`
    font = {
      name = "Sans";
      size = 11;
    };
    iconTheme.package = pkgs.tela-icon-theme;
    iconTheme.name = "Tela-black";
    theme.package = pkgs.gruvbox-gtk-theme;
    theme.name = "Gruvbox-Dark";
    colorScheme = "dark";
  };
}
