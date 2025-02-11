{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.thunderbird.enable = lib.mkEnableOption "Email client";
  };

  config = lib.mkIf config.custom.thunderbird.enable {
    environment.systemPackages = with pkgs; [ thunderbird ];
  };
}
