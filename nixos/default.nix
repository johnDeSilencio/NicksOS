{ config, pkgs, ... }:
{
  imports = [
    ./cli-tools/default.nix
    ./git/default.nix
    ./gnupg/default.nix
    ./gui-apps/default.nix
    ./hypr/default.nix
    ./language-servers/default.nix
    ./libreoffice/default.nix
  ];
}
