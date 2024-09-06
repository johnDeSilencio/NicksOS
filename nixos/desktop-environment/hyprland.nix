{ config, pkgs, ... }:
{
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hypridle
    hyprpaper
    hyprshot
  ];
}
