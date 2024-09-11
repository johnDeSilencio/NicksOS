{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    hyprlock
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.concatStrings [
          "${pkgs.greetd.tuigreet}/bin/tuigreet "
          "--time "
          "--asterisks "
          "--remember "
          "--remember-user-session "
          "--theme 'text=yellow;action=yellow;input=lightyellow;prompt=yellow;border=yellow;container=black' "
          "--cmd 'hyprland &>/dev/null'"
        ];
        user = "greeter";
      };
    };
  };
}
