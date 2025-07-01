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
    environment.systemPackages =
      let
        qalculate-qt = pkgs.symlinkJoin {
          name = "qalculate-qt-wrapped";
          paths = [ pkgs.qalculate-qt ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Increases the size of the text in the calculator by 100%
            wrapProgram $out/bin/qalculate-qt --set QT_SCALE_FACTOR "2.0"
          '';
        };
      in
      [ qalculate-qt ];
  };
}
