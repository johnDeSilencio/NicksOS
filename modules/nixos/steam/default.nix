{ lib, config, ... }:
{
  options = {
    custom.steam.enable = lib.mkEnableOption "Platform for purchasing and playing videogames";
  };

  config = lib.mkIf config.custom.steam.enable {
    programs.steam.enable = true;
  };
}
