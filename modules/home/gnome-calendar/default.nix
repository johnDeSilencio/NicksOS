{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.gnome-calendar.enable = lib.mkEnableOption "GUI calendar and task management application";
  };

  config = lib.mkIf config.custom.home.gnome-calendar.enable {
    environment.systemPackages = with pkgs; [
      gnome-calendar
    ];
  };
}
