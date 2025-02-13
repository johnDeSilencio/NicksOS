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

    home-manager.users.nicholas = {
      home.file = {
        ".config/mako" = {
          source = ./config/mako;
          recursive = true;
        };
      };
    };
  };
}
