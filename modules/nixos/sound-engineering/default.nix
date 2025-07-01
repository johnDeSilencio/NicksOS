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
    environment.systemPackages =
      let
        reaper = pkgs.symlinkJoin {
          name = "reaper-wrapped";
          paths = [ pkgs.reaper ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Increases the size of the text in Reaper by 100%
            wrapProgram $out/opt/REAPER/reaper --set GDK_SCALE "2.0"
          '';
        };
      in
      [ reaper ];
  };
}
