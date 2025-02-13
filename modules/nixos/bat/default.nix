{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.bat.enable = lib.mkEnableOption "cat clone that supports colors and paging";
  };

  config = lib.mkIf config.custom.bat.enable {
    environment.systemPackages = with pkgs; [ bat ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/bat/" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
