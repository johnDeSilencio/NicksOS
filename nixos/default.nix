{ config, pkgs, ... }:
{
  imports = [
    ./cargo/default.nix
    ./cli-tools/default.nix
    ./development/default.nix
    ./git/default.nix
    ./gnupg/default.nix
    ./desktop-environment/default.nix
    ./language-servers/default.nix
    ./libreoffice/default.nix
    ./localization/default.nix
    ./login/default.nix
    ./printers/default.nix
  ];
}
