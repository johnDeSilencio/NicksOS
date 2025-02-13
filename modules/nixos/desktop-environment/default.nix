{ lib, ... }:
{
  options = {
    custom.desktop-environment.enable = lib.mkEnableOption "Hyprland desktop environment with supporting Wayland widgets";
  };

  imports = [
    ./function-keys.nix
    ./hyprland.nix
    ./mako.nix
    ./rofi-wayland.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
