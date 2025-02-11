{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.spotify.enable = lib.mkEnableOption "Spotify desktop client for playing audio media";
  };

  config = lib.mkIf config.custom.spotify.enable {
    environment.systemPackages = with pkgs; [ spotify ];
  };
}
