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
      rofi-wayland
    ];
  };
}
