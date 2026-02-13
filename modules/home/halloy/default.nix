{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.halloy.enable = lib.mkEnableOption "GUI IRC Client";
  };

  config = lib.mkIf config.custom.home.halloy.enable {
    environment.systemPackages = with pkgs; [
      halloy
    ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/halloy/config.toml" = {
          source = ./config/config.toml;
        };

        ".config/halloy/themes/" = {
          source = ./config/themes;
          recursive = true;
        };
      };
    };
  };
}
