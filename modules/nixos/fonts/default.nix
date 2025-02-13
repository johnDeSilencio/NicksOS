{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.fonts.enable = lib.mkEnableOption "Managing NerdFonts";
  };

  config = lib.mkIf config.custom.fonts.enable {
    home-manager.users.nicholas = {
      # Enable fonts
      fonts.fontconfig.enable = true;

      # The home.packages option allows you to install Nix packages into your
      # environment.
      home.packages = [
        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        (pkgs.nerdfonts.override { fonts = [ "IntelOneMono" ]; })
      ];
    };
  };
}
