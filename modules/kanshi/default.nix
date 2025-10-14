{ ... }:
{
  services.kanshi = {
    enable = true;
    # settings = builtins.readFile ./config;

    # profile standalone {
    #     output "AU Optronics 0xF38C" mode 1920x1080@60Hz position 0,0 scale 1.25
    # }
    # profile home {
    #     output "BNQ BenQ GW2480 87K0193501Q" {
    #         mode 1920x1080@60Hz
    #         position 0,0
    #         scale 1.0
    #     }
    #     output "AU Optronics 0xF38C" {
    #         mode 1920x1080@60Hz
    #         position 1920,0
    #         scale 1.0
    #     }
    # }
    systemdTarget = "hyprland-session.target";
    settings =
      [
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              position = "0,0";
              scale = 1.25;
              status = "enable";
            }
          ];
        }
        {
          profile.name = "docked-home";
          profile.outputs = [
            {
              criteria = "BNQ BenQ GW2480 87K0193501Q";
              mode = "1920x1080@60Hz";
              position = "0,0";
              scale = 1.0;
              status = "enable";
            }
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              position = "1920,0";
              scale = 1.25;
              # BUG:
              # Currently the display will not turn back on after
              # unpluging the laptop from the hub if set to `disable`.
              status = "enable";
            }
          ];
        }
        # NOTE:
        # This profile exists asuming the default usecase for docking
        # is to mirror the laptop screen.
        {
          profile.name = "mirrored";
          profile.outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              position = "0,0";
              scale = 1.25;
              status = "enable";
            }
            { criteria = "*"; }
          ];
          profile.exec = [
            "hyprctl keyword monitor DP-1,preferred,0x0,1,mirror,eDP-1"
          ];
        }
      ];

  };
}

