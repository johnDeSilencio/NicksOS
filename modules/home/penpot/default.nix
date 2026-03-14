{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.penpot.enable = lib.mkEnableOption "Figma alternative for designing UIs";
  };

  config = lib.mkIf config.custom.home.penpot.enable {
    environment.systemPackages = with pkgs; [
      penpot-desktop
    ];
  };
}
