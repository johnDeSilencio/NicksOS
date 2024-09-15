{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    # Without this, errors will spam on screen
    StandardError = "journal";
    # Without these, bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVDisallocate = true;
  };

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
