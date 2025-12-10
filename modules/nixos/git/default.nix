{
  lib,
  config,
  pkgs,
  nixpkgs-unstable,
  ...
}:
{
  options = {
    custom.git.enable = lib.mkEnableOption "Version control management tools";
  };

  config = lib.mkIf config.custom.git.enable {
    environment.systemPackages = [
      pkgs.git
      pkgs.git-credential-manager
      pkgs.git-extras

      # Syntax-aware merge driver
      nixpkgs-unstable.mergiraf
    ];

    home-manager.users.nicholas = {
      # Configure git
      programs.git = {
        enable = true;

        settings = {
          user = {
            name = "Nicholas R. Smith";
            email = "nicholasrsmith1600@gmail.com";
            signingkey = "2A603AA9D0619A75";
          };

          commit.gpgsign = true;
          gpg.format = "openpgp";
          credential = {
            helper = "manager";
            credentialStore = "gpg";
          };
        };
      };

      home.file = {
        ".gitconfig" = {
          source = ./config/.gitconfig;
        };

        ".gitattributes" = {
          source = ./config/.gitattributes;
        };
      };
    };
  };
}
