{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.obsidian.enable = lib.mkEnableOption "Markdown editor and knowledge management system";
  };

  config = lib.mkIf config.custom.obsidian.enable {
    environment.systemPackages = with pkgs; [ obsidian ];
  };
}
