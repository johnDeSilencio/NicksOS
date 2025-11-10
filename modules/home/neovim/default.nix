{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    custom.home.neovim.enable = lib.mkEnableOption "Highly configurable terminal-based text editor and IDE";
  };

  config = lib.mkIf config.custom.home.neovim.enable {
    environment.systemPackages =
      let
        neovim = inputs.neovim.packages.x86_64-linux.default;
      in
      [
        neovim
      ];
  };
}
