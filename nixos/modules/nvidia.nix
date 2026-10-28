{ pkgs, config, ... }:
{
  imports = [ ./nvidia-vram-workaround.nix ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false; # proprietary driver (older GPU)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  # 580.x doesn't build on the newest kernels, so we pin
  boot.kernelPackages = pkgs.linuxPackages_6_18;
}
