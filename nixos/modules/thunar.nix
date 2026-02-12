{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services = {
    gvfs.enable = true; # Mount, trash, etc...
    tumbler.enable = true; # Thumbnails
  };

  environment.systemPackages = with pkgs; [
    file-roller
    libgsf # Thumbnails for .odf files
  ];
}
