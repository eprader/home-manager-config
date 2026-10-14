{ ... }:
let
  # NOTE: Workaround taken from:
  # https://github.com/basnijholt/dotfiles/blob/89dbf9ad0dbd3290d9d3f321843296a31a29325a/configs/nixos/configuration.nix

  # The following is a workaround for the NVIDIA VRAM leak on Wayland.
  # Hyprland was using >3GB of VRAM after a day of use
  # See: https://github.com/NVIDIA/egl-wayland/issues/126#issuecomment-2379945259
  limitFreeBufferProfile = builtins.toJSON {
    rules = [
      # See https://github.com/hyprwm/Hyprland/issues/7704#issuecomment-2639212608
      # for tip about using `.Hyprland-wrapped` instead of `hyprland`.
      {
        pattern = {
          feature = "procname";
          matches = ".Hyprland-wrapped";
        };
        profile = "Limit Free Buffer Pool On Wayland Compositors";
      }
      {
        pattern = {
          feature = "procname";
          matches = "gnome-shell";
        };
        profile = "Limit Free Buffer Pool On Wayland Compositors";
      }
    ];
    profiles = [
      {
        name = "Limit Free Buffer Pool On Wayland Compositors";
        settings = [
          {
            key = "GLVidHeapReuseRatio";
            value = 0;
          }
        ];
      }
    ];
  };
in
{
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
    limitFreeBufferProfile;
}
