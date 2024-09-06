{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
    discord
    keepassxc
    minecraft
    thunderbird
  ];

  # Steam
  programs.steam.enable = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nicholas" ];
  };
}
