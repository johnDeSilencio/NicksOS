{ config, pkgs, ... }:
{
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # For screen sharing
  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs; [
    hypridle
    hyprpaper
    hyprshot
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwaylandvideobridge
  ];
}
