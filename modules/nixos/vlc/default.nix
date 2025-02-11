{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.vlc.enable = lib.mkEnableOption "VLC media player for playing videos";
  };

  config = lib.mkIf config.custom.vlc.enable {
    environment.systemPackages = with pkgs; [ vlc ];
  };
}
