{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.minecraft.enable = lib.mkEnableOption "Voxel-based 3D game";
  };

  config = lib.mkIf config.custom.home.minecraft.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}
