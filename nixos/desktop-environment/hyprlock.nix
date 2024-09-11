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
          "--theme '"
          "text=yellow;"
          "time=yellow;"
          "container=black;"
          "border=yellow;"
          "title=yellow;"
          "greet=yellow;"
          "prompt=yellow;"
          "input=yellow;"
          "action=yellow;"
          "button=yellow;' "
          "--cmd 'hyprland &>/dev/null'"
        ];
        user = "greeter";
      };
    };
  };
}
