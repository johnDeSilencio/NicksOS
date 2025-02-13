{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.bacon.enable = lib.mkEnableOption "Background Rust code runner for fast iteration";
  };

  config = lib.mkIf config.custom.bacon.enable {
    environment.systemPackages = with pkgs; [ bacon ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/bacon/" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
