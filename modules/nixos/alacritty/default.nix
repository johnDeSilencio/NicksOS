{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.alacritty.enable = lib.mkEnableOption "Cross platform, GPU-accelerated terminal emulator written in Rust";
  };

  config = lib.mkIf config.custom.alacritty.enable {
    environment.systemPackages = with pkgs; [ alacritty ];
  };
}
