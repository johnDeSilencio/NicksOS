{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.dprint.enable = lib.mkEnableOption "Formatter written in Rust that uses WASM compiled plugins";
  };

  config = lib.mkIf config.custom.dprint.enable {
    environment.systemPackages = with pkgs; [ dprint ];

    home-manager.users.nicholas = {
      home.file = {
        ".dprint.json" = {
          source = ./config/.dprint.json;
        };
      };
    };
  };
}
