{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.keepassxc.enable = lib.mkEnableOption "Local password manager";
  };

  config = lib.mkIf config.custom.keepassxc.enable {
    nixpkgs = {
      overlays = [
        (import ./overlay.nix)
      ];
    };

    environment.systemPackages = with pkgs; [ keepassxc ];
  };
}
