{
  lib,
  config,
  pkgs,
  inputs,
  hyprhook,
  hyprhook-mouse-move,
  ...
}:
let
  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.system};
  hyprhookPkg = hyprhook.packages.${pkgs.system}.hyprhook;
  hyprhookMouseMovePkg = hyprhook-mouse-move.packages.${pkgs.system}.default;
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyrpland-plugins";
    paths = with hyprPluginPkgs; [
      hyprexpo
      hyprhookPkg
      #...plugins
    ];
  };
in
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # To communicate to Hyprland at runtime where the plugins are located
    environment.sessionVariables = {
      HYPR_PLUGIN_DIR = hypr-plugin-dir;
    };

    # Compile Rust binary for efficiently checking mouse position and showing / hiding waybar
    environment.systemPackages = with pkgs; [
      hypridle
      hyprpaper
      hyprshot
      hyprhookMouseMovePkg

      # BUG: Screensharing in discord through xwaylandvideobridge
      # only works on built-in monitor. Also, if I spend too much time
      # on the external monitor, also seems to crash xwaylandvideobridge
      kdePackages.xwaylandvideobridge
    ];

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
