{ config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    silent = true;
  };
}
