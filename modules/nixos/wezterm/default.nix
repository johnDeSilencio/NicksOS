{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.wezterm.enable = lib.mkEnableOption "Cross platform, GPU-accelerated terminal emulator written in Rust";
  };

  config = lib.mkIf config.custom.wezterm.enable {
    environment.systemPackages = with pkgs; [ wezterm ];

    home-manager.users.nicholas = {
      home.file = {
        ".wezterm.lua" = {
          source = ./config/.wezterm.lua;
          recursive = false;
        };
      };
    };
  };
}
