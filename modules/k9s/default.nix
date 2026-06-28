{ ... }:
let
  # Gruvbox Palette Variables

  currentLine = "#3c3836";
  black = "#282828";
  darkGrey = "#928374";

  darkRed = "#cc241d";
  red = "#fb4934";

  darkGreen = "#98971a";
  green = "#b8bb26";

  darkYellow = "#d79921";
  yellow = "#fabd2f";

  darkBlue = "#458588";
  blue = "#83a598";

  darkMagenta = "#b16286";
  magenta = "#d3869b";

  darkCyan = "#689d6a";
  cyan = "#8ec07c";

  lightGrey = "#a89984";
  white = "#ebdbb2";

  darkOrange = "#d65d0e";
  orange = "#fe8019";
in
{
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        liveViewAutoRefresh = true;
        refreshRate = 3; # seconds
        # Overrides the default k8s api server requests timeout. Defaults 120s
        apiServerTimeout = "20s";
        # Number of retries once the connection to the api-server is lost.
        maxConnRetry = 3;
        portForwardAddress = "localhost";
        skin = "gruvbox-dark";
        ui = {
          enableMouse = true;
          headless = false;
          logoless = true;
          # Set to true to hide K9s crumbs. Default false
          crumbsless = false;
          reactive = true;
          noIcons = false;
        };
        skipLatestRevCheck = true;
        featureGates = {
          nodeShell = true;
        };
        logger = {
          tail = 100;
          buffer = 5000;
          # Represents how far to go back in the log timeline in seconds. Setting to -1 will tail logs. Default is -1.
          sinceSeconds = -1;
          fullScreen = false;
          textWrap = true;
          showTime = true;
        };
        # Global memory/cpu thresholds. When set will alert when thresholds are met.
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 70;
          };
        };
      };
    };

    skins = {
      # INFO: there does not appear to be a default skin that only uses terminal colours:
      # https://k9scli.io/topics/skins/
      # Yaml references: https://github.com/derailed/k9s/tree/master/skins
      gruvbox-dark = {
        k9s = {
          body = {
            fgColor = white;
            bgColor = black;
            logoColor = orange;
          };
          prompt = {
            fgColor = blue;
            bgColor = black;
            suggestColor = darkBlue;
          };
          info = {
            fgColor = orange;
            sectionColor = white;
          };
          help = {
            fgColor = white;
            bgColor = black;
            keyColor = darkMagenta;
            numKeyColor = darkBlue;
            sectionColor = darkGreen;
          };
          dialog = {
            fgColor = white;
            bgColor = black;
            buttonFgColor = black;
            buttonBgColor = blue;
            buttonFocusFgColor = "white";
            buttonFocusBgColor = cyan;
            labelFgColor = cyan;
            fieldFgColor = blue;
          };
          frame = {
            border = {
              fgColor = darkGrey;
              focusColor = blue;
            };
            menu = {
              fgColor = white;
              fgStyle = "dim";
              keyColor = magenta;
              numKeyColor = magenta;
            };
            crumbs = {
              fgColor = black;
              bgColor = darkBlue;
              activeColor = orange;
            };
            status = {
              newColor = cyan;
              modifyColor = yellow;
              addColor = white;
              errorColor = red;
              highlightColor = blue;
              killColor = darkMagenta;
              completedColor = darkGrey;
            };
            title = {
              fgColor = blue;
              bgColor = black;
              highlightColor = cyan;
              counterColor = orange;
              filterColor = darkBlue;
            };
          };
          views = {
            charts = {
              bgColor = black;
              defaultDialColors = [
                darkGreen
                darkRed
              ];
              defaultChartColors = [
                darkGreen
                darkRed
              ];
            };
            table = {
              fgColor = white;
              bgColor = black;
              cursorFgColor = black;
              cursorBgColor = lightGrey;
              header = {
                fgColor = white;
                bgColor = black;
                sorterColor = orange;
              };
            };
            xray = {
              fgColor = white;
              bgColor = black;
              cursorColor = lightGrey;
              graphicColor = blue;
              showIcons = true;
            };
            yaml = {
              keyColor = cyan;
              colonColor = blue;
              valueColor = green;
            };
            logs = {
              fgColor = white;
              bgColor = black;
              indicator = {
                fgColor = blue;
                bgColor = black;
                toggleOnColor = green;
                toggleOffColor = currentLine;
              };
            };
          };
        };
      };
    };
  };
}
