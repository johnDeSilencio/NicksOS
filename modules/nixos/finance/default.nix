{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.finance.enable = lib.mkEnableOption "Tools for personal finance";
  };

  config = lib.mkIf config.custom.finance.enable {
    environment.systemPackages = with pkgs; [ gnucash ];
  };
}
