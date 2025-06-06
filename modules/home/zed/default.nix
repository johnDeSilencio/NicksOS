{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.zed.enable = lib.mkEnableOption "GPU-accelerated text editor and IDE";
  };

  config = lib.mkIf config.custom.home.zed.enable {
    environment.systemPackages = with pkgs; [
      zed-editor
    ];
  };
}
