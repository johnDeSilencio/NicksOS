{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hypridle
      hyprpaper
      hyprshot

      # BUG: Screensharing in discord through xwaylandvideobridge
      # only works on built-in monitor. Also, if I spend too much time
      # on the external monitor, also seems to crash xwaylandvideobridge
      xwaylandvideobridge
    ];
  };
}
