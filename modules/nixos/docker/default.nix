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

      rootless = {
        enable = true;
      };
    };

    users.extraGroups.docker.members = [ "nicholas" ];
  };
}
