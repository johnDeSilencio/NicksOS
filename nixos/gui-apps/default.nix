{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./discord-overlay.nix)
    (import ./keepassxc-overlay.nix)
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    discord
    gimp
    keepassxc
    minecraft
    obsidian
    photoqt
    qalculate-qt
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
