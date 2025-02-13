{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.git.enable = lib.mkEnableOption "Version control management tools";
  };

  config = lib.mkIf config.custom.git.enable {
    environment.systemPackages = with pkgs; [
      git
      git-credential-manager
      git-extras
    ];

    home-manager.users.nicholas = {
      # Configure git
      programs.git = {
        enable = true;
        userName = "Nicholas R. Smith";
        userEmail = "nicholasrsmith1600@gmail.com";
        extraConfig = {
          commit.gpgsign = true;
          gpg.format = "openpgp";
          user.signingkey = "2A603AA9D0619A75";
          credential = {
            helper = "manager";
            credentialStore = "gpg";
          };
        };
      };
    };
  };
}
