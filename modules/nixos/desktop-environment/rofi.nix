{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    environment.systemPackages = with pkgs; [
      # Wayland app launcher
      rofi
    ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/rofi/" = {
          source = ./config/rofi;
          recursive = true;
        };
      };
    };
  };
}
