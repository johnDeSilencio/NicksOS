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
    programs.dconf.enable = true;
    services.gnome.evolution-data-server.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-calendar
      evolution
    ];
  };
}
