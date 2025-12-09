{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    custom.home.corectrl.enable = lib.mkEnableOption "GUI application to monitor AMD GPU performance";
  };

  config = lib.mkIf config.custom.home.corectrl.enable {
    environment.systemPackages = with pkgs; [
      botan3
      corectrl
      hwdata
      virtualglLib
      vulkan-tools
    ];
  };
}
