{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.taskwarrior.enable = lib.mkEnableOption "Command-line task management software";
  };

  config = lib.mkIf config.custom.taskwarrior.enable {
    environment.systemPackages = with pkgs; [
      taskwarrior3
      taskwarrior-tui
    ];

    home-manager.users.nicholas = {
      home.file = {
        ".taskrc" = {
          source = ./config/.taskrc;
        };
      };
    };
  };
}
