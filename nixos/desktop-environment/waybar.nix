{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # For configuring network settings in the app bar
    networkmanagerapplet

    # For configuring / styling the desktop bar
    waybar
  ];
}
