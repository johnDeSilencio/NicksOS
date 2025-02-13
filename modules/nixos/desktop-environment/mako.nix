{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    environment.systemPackages = with pkgs; [
      # For sending / receiving system notifications
      libnotify

      # For displaying and styling system notifications
      mako
    ];
  };
}
