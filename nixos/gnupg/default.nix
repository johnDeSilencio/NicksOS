{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-tty
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };
}
