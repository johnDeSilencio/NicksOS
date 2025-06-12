{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.kdenlive.enable = lib.mkEnableOption "Video editing software";
  };

  config = lib.mkIf config.custom.home.kdenlive.enable {
    nixpkgs = {
      overlays = [
        (import ./overlay.nix)
      ];
    };

    environment.systemPackages = with pkgs; [ kdePackages.kdenlive ];
  };
}
