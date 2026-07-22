{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.jj.enable = lib.mkEnableOption "Modern alternative VCS frontend to git";
  };

  config = lib.mkIf config.custom.jj.enable {
    environment.systemPackages = with pkgs; [
      jujutsu
    ];
  };
}
