{ config, pkgs, ... }:
{
  imports = [
    ./hypr/default.nix
    ./language-servers/default.nix
    ./libreoffice/default.nix
  ];
}