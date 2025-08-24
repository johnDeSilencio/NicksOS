{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.zulip.enable = lib.mkEnableOption "Native Zulip chat GUI client";
  };

  config = lib.mkIf config.custom.home.zulip.enable {
    environment.systemPackages = with pkgs; [ zulip ];
  };
}
