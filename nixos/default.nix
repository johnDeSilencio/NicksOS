{ config, pkgs, ... }:
{
  imports = [
    ./cargo/default.nix
    ./login/default.nix
    ./printers/default.nix
  ];
}
