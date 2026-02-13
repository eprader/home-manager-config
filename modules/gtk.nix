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
    iconTheme.name = "Gruvbox-Plus-Dark";
    iconTheme.package = pkgs.gruvbox-plus-icons;
    theme.name = "Gruvbox-Dark";
    theme.package = pkgs.gruvbox-gtk-theme;
    colorScheme = "dark";
  };
}
