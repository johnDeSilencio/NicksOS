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
    home-manager.users.nicholas.home.packages = with pkgs; [
      # TODO: https://nixpk.gs/pr-tracker.html?pr=536273
      # signal-desktop
    ];
  };
}
