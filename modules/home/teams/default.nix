{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.teams.enable = lib.mkEnableOption "Microsoft Teams video call and screen share software";
  };

  config = lib.mkIf config.custom.home.teams.enable {
    environment.systemPackages = with pkgs; [
      teams-for-linux
    ];
  };
}
