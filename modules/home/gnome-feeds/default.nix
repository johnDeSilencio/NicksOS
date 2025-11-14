{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.gnome-feeds.enable = lib.mkEnableOption "GUI RSS Feed Reader";
  };

  config = lib.mkIf config.custom.home.gnome-feeds.enable {
    environment.systemPackages = with pkgs; [
      gnome-feeds
    ];
  };
}
