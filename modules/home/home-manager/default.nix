{
  inputs,
  lib,
  config,
  ...
}:
{
  options = {
    custom.home.home-manager.enable = lib.mkEnableOption "Manage dotfiles and programs on a per-user basis";
  };

  config = lib.mkIf config.custom.home.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.nicholas = {
        imports = [
          ./home.nix
        ];

        home = {
          username = "nicholas";
          homeDirectory = "/home/nicholas";

          # This value determines the Home Manager release that your configuration is
          # compatible with. This helps avoid breakage when a new Home Manager release
          # introduces backwards incompatible changes.
          #
          # You should not change this value, even if you update Home Manager. If you do
          # want to update the value, then make sure to first check the Home Manager
          # release notes.
          stateVersion = "24.11"; # Please read the comment before changing.
        };
      };
    };
  };
}
