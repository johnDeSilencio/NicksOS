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
    environment.systemPackages =
      let
        kdenlive = pkgs.symlinkJoin {
          name = "kdenlive-wrapped";
          paths = [ pkgs.kdePackages.kdenlive ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Increases the size of the text in kdenlive by 100%
            wrapProgram $out/bin/kdenlive --set QT_SCALE_FACTOR "2.0"
          '';
        };
      in
      [ kdenlive ];
  };
}
