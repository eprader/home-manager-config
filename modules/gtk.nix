{ pkgs, ... }:
{
  home = {
    pointerCursor = {
      gtk.enable = true;
    };
  };

  gtk = {
    enable = true;
    # INFO: Handled via `fonts.fontconfig`
    font = {
      name = "SansSerif";
      size = 12;
    };
    iconTheme.package = pkgs.tela-icon-theme;
    iconTheme.name = "Tela-black";
    theme.package = pkgs.gruvbox-gtk-theme;
    theme.name = "Gruvbox-Dark";
    colorScheme = "dark";
  };
}
