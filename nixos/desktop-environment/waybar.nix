{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # For configuring Bluetooth settings in the app bar
    blueman

    # For configuring network settings in the app bar
    networkmanagerapplet

    # For configuring / styling the desktop bar
    waybar
  ];

  # Configure blueman
  services.blueman.enable = true;

  programs.dconf.profiles = {
    user.databases = [
      {
        settings = {
          "org/blueman/general" = {
            plugin-list = [
              "!ShowConnected"
              "!ShowStatus"
            ];
          };
        };
      }
    ];
  };
}
