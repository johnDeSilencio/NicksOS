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
    environment.systemPackages =
      let
        keepassxc = pkgs.symlinkJoin {
          name = "keepassxc-wrapped";
          paths = [ pkgs.keepassxc ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Increases the size of the text in KeePassXC by 50%
            wrapProgram $out/bin/keepassxc --set QT_SCALE_FACTOR "1.5"
          '';
        };
      in
      [ keepassxc ];
  };
}
