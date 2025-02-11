{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./discord-overlay.nix)
    (import ./keepassxc-overlay.nix)
    (import ./qalculate-overlay.nix)
  ];

  environment.systemPackages = with pkgs; [
    discord
    keepassxc
    obsidian
    photoqt
    qalculate-qt
    thunderbird
    vlc
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
