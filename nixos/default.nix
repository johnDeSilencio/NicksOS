{ config, pkgs, ... }:
{
  imports = [
    ./cargo/default.nix
    ./cli-tools/default.nix
    ./development/default.nix
    ./login/default.nix
    ./printers/default.nix
  ];
}
