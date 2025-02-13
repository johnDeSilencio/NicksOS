{ config, pkgs, ... }:
{
  imports = [
    ./login/default.nix
    ./printers/default.nix
  ];
}
