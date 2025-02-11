{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.zoom-us.enable = lib.mkEnableOption "Proprietary video conferencing and screen sharing";
  };

  config = lib.mkIf config.custom.zoom-us.enable {
    environment.systemPackages = with pkgs; [ zoom-us ];
  };
}
