{ config, pkgs, ... }:
{
  import = [
    ./hypr/default.nix
    ./language-servers/default.nix
  ];
}
