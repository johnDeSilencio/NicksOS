{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.sound-engineering.enable = lib.mkEnableOption "Audio recording software";
  };

  config = lib.mkIf config.custom.sound-engineering.enable {
    nixpkgs = {
      overlays = [
        (import ./overlay.nix)
      ];
    };

    environment.systemPackages = with pkgs; [
      reaper
    ];
  };
}
