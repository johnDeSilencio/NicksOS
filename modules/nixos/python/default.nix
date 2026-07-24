{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.python.enable = lib.mkEnableOption "Python language and tools";
  };

  config = lib.mkIf config.custom.python.enable {
    environment.systemPackages = with pkgs; [
      python315
      uv
    ];
  };
}
