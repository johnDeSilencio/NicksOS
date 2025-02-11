{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.gimp.enable = lib.mkEnableOption "GNU Image Manipulation Program for editing media files";
  };

  config = lib.mkIf config.custom.gimp.enable {
    environment.systemPackages = with pkgs; [ gimp ];
  };
}
