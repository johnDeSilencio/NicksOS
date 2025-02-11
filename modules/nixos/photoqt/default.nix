{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.photoqt.enable = lib.mkEnableOption "Image viewer";
  };

  config = lib.mkIf config.custom.photoqt.enable {
    environment.systemPackages = with pkgs; [ photoqt ];
  };
}
