{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.panamax.enable = lib.mkEnableOption "crates.io and rustup mirror";
  };

  config = lib.mkIf config.custom.panamax.enable {
    environment.systemPackages = with pkgs; [
      panamax
    ];

    systemd.services.panamax = {
      enable = true;
      description = "crates.io and rustup mirror";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.panamax}/bin/panamax serve /home/nicholas/crates.io.mirror/";
        User = "nicholas";
        Restart = "on-failure";
        RestartSec = "3";
      };
    };
  };
}
