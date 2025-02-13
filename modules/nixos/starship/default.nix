{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.starship.enable = lib.mkEnableOption "Colorful and configurable terminal prompt";
  };

  config = lib.mkIf config.custom.starship.enable {
    environment.systemPackages = with pkgs; [ starship ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/starship.toml" = {
          source = ./config/starship.toml;
        };
      };
    };
  };
}
