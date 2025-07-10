{
  lib,
  config,
  nixpkgs-unstable,
  ...
}:
{
  options = {
    custom.wild.enable = lib.mkEnableOption "Incremental linker";
  };

  config = lib.mkIf config.custom.wild.enable {
    environment.systemPackages = [
      nixpkgs-unstable.wild
    ];
  };
}
