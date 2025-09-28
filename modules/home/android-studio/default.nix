{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.android-studio.enable = lib.mkEnableOption "IDE for developing Android applications";
  };

  config = lib.mkIf config.custom.home.android-studio.enable {
    environment.systemPackages = with pkgs; [
      android-studio
    ];
  };
}
