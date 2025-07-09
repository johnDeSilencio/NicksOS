{
  lib,
  config,
  ...
}:
{
  options = {
    custom.docker.enable = lib.mkEnableOption "Containerization tool";
  };

  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    users.extraGroups.docker.members = [ "nicholas" ];
  };
}
