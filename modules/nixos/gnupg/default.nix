{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.gnupg.enable = lib.mkEnableOption "GNU Pretty Good Privacy (PGP) for signing and verifying signatures with keys";
  };

  config = lib.mkIf config.custom.gnupg.enable {
    environment.systemPackages = with pkgs; [
      gnupg
      pinentry-tty
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}
