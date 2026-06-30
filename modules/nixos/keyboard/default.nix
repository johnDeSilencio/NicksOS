{
  lib,
  config,
  pkgs,
  ...
}:
{
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  services = {
    xserver = {
      xkb.layout = "us,us";
      xkb.variant = ",colemak_dh";
      xkb.options = "caps:swapescape,grp:alt_shift_toggle";
    };
  };
}
