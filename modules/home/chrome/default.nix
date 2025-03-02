{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.chrome.enable = lib.mkEnableOption "Chrome browser maintained by Google";
  };

  config = lib.mkIf config.custom.home.chrome.enable {
    environment.systemPackages = with pkgs; [
      ungoogled-chromium
    ];
  };
}
