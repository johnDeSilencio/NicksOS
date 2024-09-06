{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    git-credential-manager
  ];
}
