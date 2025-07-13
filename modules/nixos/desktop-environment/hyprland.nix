{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  hyprhook = inputs.hyprhook.packages.${pkgs.system}.hyprhook;
  hyprhook-mouse-move = inputs.hyprhook-mouse-move.packages.${pkgs.system}.default;
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = [
      hyprhook
      # ... more plugins
    ];
  };
in
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    environment.systemPackages = with pkgs; [
      hypridle
      hyprpaper
      hyprshot
      hyprhook
      hyprhook-mouse-move
      hypr-plugin-dir

      # BUG: Screensharing in discord through xwaylandvideobridge
      # only works on built-in monitor. Also, if I spend too much time
      # on the external monitor, also seems to crash xwaylandvideobridge
      kdePackages.xwaylandvideobridge
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Compile Rust binary for efficiently checking mouse position and showing / hiding waybar
    home-manager.users.nicholas = {
      home.file = {
        ".config/hypr/" = {
          source = ./config/hypr;
          recursive = true;
        };
      };

      home.file.".config/hypr/plugin.conf".text = ''
        exec-once = hyprctl plugin load ${hypr-plugin-dir}/lib/libhyprhook.so

        plugin {
            hyprhook {
                # For triggering this binary whenever the mouse is moved
                mouseMove = /run/current-system/sw/bin/hyprhook-mouse-move
            }
        }
      '';
    };
  };
}
