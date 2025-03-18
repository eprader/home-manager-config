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
              # mode = "1920x1080@60Hz";
              # position = "1920,0";
              # scale = 1.25;
              # BUG:
              # Currently the display will not turn back on after
              # unpluging the laptop from the hub.

              status = "disable";
            }
          ];
        }
        {
          # NOTE:
          # This profile exists asuming the default requirement for docking
          # is to mirror the laptop screen.
          profile.name = "docked-presentation";
          profile.outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              position = "0,0";
              scale = 1.25;
              status = "enable";
            }
            {
              criteria = "*";
              # mode = "1920x1080@60Hz";
              position = "0,-1080";
              scale = 1.0;
              status = "enable";
            }
          ];
        }
      ];

  };
}

