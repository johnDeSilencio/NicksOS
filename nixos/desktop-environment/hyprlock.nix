{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    greetd.wlgreet
    hyprlock
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprlock}/bin/hyprlock";
        user = "nicholas";
      };
    };
  };
}
