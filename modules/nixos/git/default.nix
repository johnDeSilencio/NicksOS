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
  };
}
