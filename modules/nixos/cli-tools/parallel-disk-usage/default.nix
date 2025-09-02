{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.cli-tools.parallel-disk-usage.enable = lib.mkEnableOption "Tool for visual representation of relative disk space usage";
  };

  config = lib.mkIf config.custom.cli-tools.parallel-disk-usage.enable {
    environment.systemPackages = [
      pkgs.parallel-disk-usage
    ];
  };
}
