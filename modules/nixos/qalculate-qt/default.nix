{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.qalculate-qt.enable = lib.mkEnableOption "Calculator GUI app";
  };

  config = lib.mkIf config.custom.qalculate-qt.enable {
    nixpkgs = {
      overlays = [
        (import ./overlay.nix)
      ];
    };

    environment.systemPackages = with pkgs; [ qalculate-qt ];
  };
}
