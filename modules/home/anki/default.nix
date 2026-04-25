{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.anki.enable = lib.mkEnableOption "Spaced-repitition flashcards";
  };

  config = lib.mkIf config.custom.home.anki.enable {
    environment.systemPackages = with pkgs; [
      anki
    ];
  };
}
