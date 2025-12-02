{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  hyprhook = inputs.hyprhook.packages.${pkgs.system}.hyprhook;
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
    security.pam.services.hyprland.enableGnomeKeyring = true;

    environment.systemPackages = with pkgs; [
      hypridle
      hyprpaper
      hyprshot
      hyprhook
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
    };
  };
}
