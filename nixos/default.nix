{ config, pkgs, ... }:
{
  imports = [
    ./cli-tools/default.nix
    ./gnupg/default.nix
    ./gui-apps/default.nix
    ./hypr/default.nix
    ./language-servers/default.nix
    ./libreoffice/default.nix
  ];
}
