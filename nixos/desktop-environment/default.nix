{ config, pkgs, ... }:
{
  imports = [
    ./function-keys.nix
    ./hyprland.nix
    ./mako.nix
    ./rofi-wayland.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
