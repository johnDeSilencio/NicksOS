{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
  ];

  environment.systemPackages = with pkgs; [
    photoqt
  ];

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nicholas" ];
  };
}
