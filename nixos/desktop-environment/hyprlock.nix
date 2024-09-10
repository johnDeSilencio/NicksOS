{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    greetd.wlgreet
    hyprlock
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "nicholas";
      };
    };
  };
}
