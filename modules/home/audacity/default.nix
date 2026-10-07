{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.audacity.enable = lib.mkEnableOption "Audio recording and editing software";
  };

  config = lib.mkIf config.custom.home.audacity.enable {
    environment.systemPackages = with pkgs; [
      audacity
    ];
  };
}
