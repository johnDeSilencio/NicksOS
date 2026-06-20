{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.docker.enable = lib.mkEnableOption "Containerization tool";
  };

  config = lib.mkIf config.custom.docker.enable {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    virtualisation.docker = {
      enable = true;

      # Fixes bug where shutdown hangs on s6-svscan process for ~90 s
      liveRestore = false;

      rootless = {
        enable = true;
      };
    };

    users.extraGroups.docker.members = [ "nicholas" ];
  };
}
