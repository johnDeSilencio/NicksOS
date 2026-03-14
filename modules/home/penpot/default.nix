{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.penpot.enable = lib.mkEnableOption "Figma alternative for designing UIs";
  };

  config = lib.mkIf config.custom.home.penpot.enable {
    environment.systemPackages =
      let
        penpot = pkgs.symlinkJoin {
          name = "penpot-desktop-wrapped";
          paths = [ pkgs.penpot-desktop ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Increases the size of the text in Penpot by 50%
            wrapProgram $out/bin/penpot-desktop --set GDK_SCALE "1.5"
          '';
        };
      in
      [
        penpot
      ];
  };
}
