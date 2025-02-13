{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.tuifeed.enable = lib.mkEnableOption "Command-line RSS feed reader written in Rust";
  };

  config = lib.mkIf config.custom.tuifeed.enable {
    environment.systemPackages = with pkgs; [ tuifeed ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/tuifeed" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
