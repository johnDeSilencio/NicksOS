{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = [
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
      hypr-plugin-dir
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
