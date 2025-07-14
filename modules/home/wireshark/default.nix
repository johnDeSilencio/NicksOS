{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.wireshark.enable = lib.mkEnableOption "Packet analysis GUI tool";
  };

  config = lib.mkIf config.custom.home.wireshark.enable {
    programs.wireshark.enable = true;

    # Make sure that I have permissions to use Wireshark without being root
    users.extraGroups.wireshark.members = [ "nicholas" ];

    environment.systemPackages =
      let
        wireshark = pkgs.symlinkJoin {
          name = "wireshark-wrapped";
          paths = [ pkgs.wireshark ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Increases the size of the text in the calculator by 100%
            wrapProgram $out/bin/wireshark --set QT_SCALE_FACTOR "2.0"
          '';
        };

      in
      [
        wireshark
      ];
  };
}
