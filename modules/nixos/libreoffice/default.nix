{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.libreoffice.enable = lib.mkEnableOption "Open source replacement for Microsoft Office tools";
  };

  config = lib.mkIf config.custom.libreoffice.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
    ];
  };
}
