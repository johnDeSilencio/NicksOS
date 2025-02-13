{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.printing.enable = lib.mkEnableOption "Enabling printing and managing printers";
  };

  config = lib.mkIf config.custom.printing.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
