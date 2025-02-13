{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.zellij.enable = lib.mkEnableOption "Terminal multiplexer written in Rust that uses WASM for plugins";
  };

  config = lib.mkIf config.custom.zellij.enable {
    environment.systemPackages = with pkgs; [ zellij ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/zellij" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
