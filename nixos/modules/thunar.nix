{ ... }:
{
  programs.thunar = {
    enable = true;
  };

  services = {
    gvfs.enable = true; # Mount, trash, etc...
    tumbler.enable = true; # Thumbnails for images
  };
}
