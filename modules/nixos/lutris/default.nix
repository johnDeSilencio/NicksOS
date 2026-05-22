{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.lutris.enable = lib.mkEnableOption "Windows gaming on Linux";
  };

  config = lib.mkIf config.custom.lutris.enable {
    environment.systemPackages = with pkgs; [
      # Needed so that I can play Monsters & Memories
      lutris

      # Needed to install GE-Proton10-34 so that I can play Monsters & Memories
      protonup-ng
    ];
  };
}
