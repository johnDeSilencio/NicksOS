{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
    discord
    keepassxc
    minecraft
    thunderbird
  ];
}
