{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # For sending / receiving system notifications
    libnotify

    # For displaying and styling system notifications
    mako
  ];
}
