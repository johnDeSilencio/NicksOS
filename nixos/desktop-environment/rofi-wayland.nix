{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Wayland app launcher
    rofi-wayland
  ];
}
