{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.signal-desktop.enable = lib.mkEnableOption "Enable signal-desktop in home-manager";
  };

  config = lib.mkIf config.custom.home.signal-desktop.enable {
    home-manager.users.nicholas.home.packages = with pkgs; [ signal-desktop ];
  };
}
