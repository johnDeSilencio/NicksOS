{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.steam.enable = lib.mkEnableOption "Platform for purchasing and playing videogames";
  };

  config = lib.mkIf config.custom.steam.enable {
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      umu-launcher
    ];
  };
}
