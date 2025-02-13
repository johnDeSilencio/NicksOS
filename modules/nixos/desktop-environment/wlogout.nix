{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    environment.systemPackages = with pkgs; [
      # For configuring & styling logout / power off modal dialog
      wlogout
    ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/wlogout" = {
          source = ./config/wlogout;
          recursive = true;
        };
      };
    };
  };
}
