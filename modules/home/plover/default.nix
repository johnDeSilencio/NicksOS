{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    custom.home.plover.enable = lib.mkEnableOption "Stenography GUI software";
  };

  config = lib.mkIf config.custom.home.plover.enable {
    environment.systemPackages =
      let
        plover = inputs.plover.packages.x86_64-linux.plover.withPlugins (
          ps: with ps; [
            plover-console-ui
          ]
        );
      in
      [
        plover
      ];
  };
}
