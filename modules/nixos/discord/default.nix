{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.discord.enable = lib.mkEnableOption "Audio conferencing and screen sharing software";
  };

  config = lib.mkIf config.custom.discord.enable {
    environment.systemPackages =
      let
        discord = pkgs.symlinkJoin {
          name = "discord-wrapped";
          paths = [ pkgs.discord ];
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
            # Polyfill to allow Discord to do screensharing on Wayland through xwaylandbridge
            wrapProgram $out/opt/Discord/Discord --set XDG_SESSION_TYPE x11
          '';
        };
      in
      [ discord ];
  };
}
