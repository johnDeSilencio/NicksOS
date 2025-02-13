{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.fish.enable = lib.mkEnableOption "Shell alternative to Bash written in Rust";
  };

  config = lib.mkIf config.custom.fish.enable {
    home-manager.users.nicholas = {
      programs.fish = {
        enable = true;
      };

      home.file = {
        ".config/fish/" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
