{
  lib,
  config,
  nixpkgs-unstable,
  ...
}:
{
  options = {
    custom.prek.enable = lib.mkEnableOption "Rewrite of pre-commit in Rust";
  };

  config = lib.mkIf config.custom.prek.enable {
    environment.systemPackages = with nixpkgs-unstable; [
      prek
    ];

    home-manager.users.nicholas = {
      home.file = {
        ".pre-commit-config.yaml" = {
          source = ./config/.pre-commit-config.yaml;
        };
      };
    };
  };
}
