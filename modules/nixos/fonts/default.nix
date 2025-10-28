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
      home.packages = with pkgs; [
        # Mono fonts
        nerd-fonts.adwaita-mono
        nerd-fonts.aurulent-sans-mono
        nerd-fonts.blex-mono
        nerd-fonts.caskaydia-mono
        nerd-fonts.comic-shanns-mono
        nerd-fonts.commit-mono
        nerd-fonts.daddy-time-mono
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.departure-mono
        nerd-fonts.droid-sans-mono
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        nerd-fonts.geist-mono
        nerd-fonts.intone-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.martian-mono
        nerd-fonts.recursive-mono
        nerd-fonts.roboto-mono
        nerd-fonts.shure-tech-mono
        nerd-fonts.ubuntu-mono
        nerd-fonts.victor-mono
        nerd-fonts.zed-mono

        # Sans fonts
        nerd-fonts.ubuntu-sans

        # Other
        nerd-fonts._3270
        nerd-fonts.agave
        nerd-fonts.anonymice
        nerd-fonts.arimo
        nerd-fonts.bigblue-terminal
        nerd-fonts.code-new-roman
        nerd-fonts.d2coding
        nerd-fonts.envy-code-r
        nerd-fonts.hasklug
        nerd-fonts.heavy-data
        nerd-fonts.hurmit
        nerd-fonts.im-writing
        nerd-fonts.inconsolata
        nerd-fonts.inconsolata-go
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nerd-fonts.iosevka-term-slab
        nerd-fonts.lekton
        nerd-fonts.liberation
        nerd-fonts.lilex
        # nerd-fonts.m+
        nerd-fonts.meslo-lg
        nerd-fonts.mononoki
        nerd-fonts.noto
        nerd-fonts.open-dyslexic
        nerd-fonts.overpass
        nerd-fonts.profont
        nerd-fonts.sauce-code-pro
        nerd-fonts.terminess-ttf
        nerd-fonts.tinos
        nerd-fonts.ubuntu
      ];
    };
  };
}
