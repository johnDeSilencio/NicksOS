{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # For configuring & styling logout / power off modal dialog
    wlogout
  ];
}
