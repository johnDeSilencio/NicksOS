{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.custom.desktop-environment.enable {
    environment.systemPackages = with pkgs; [
      # For volume control function keys:
      # XF86AudioMute
      # XF86AudioLowerVolume
      # XF86AudioRaiseVolume
      pavucontrol

      # For the previous, play / pause, and skip function keys:
      # XF86AudioPrev
      # XF86AudioPlay
      # XF86AudioNext
      playerctl

      # For the screen brightness function keys:
      # XF86MonBrightnessDown
      # XF86MonBrightnessUp
      brightnessctl
    ];
  };
}
