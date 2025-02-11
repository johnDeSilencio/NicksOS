{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.discord.enable = lib.mkEnableOption "Audio conferencing and screen sharing software";
  };

  config = lib.mkIf config.custom.discord.enable {
    nixpkgs = {
      overlays = [
        (import ./overlay.nix)
      ];
    };

    environment.systemPackages = with pkgs; [ discord ];
  };
}
