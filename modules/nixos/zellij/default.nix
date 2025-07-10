{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    custom.zellij.enable = lib.mkEnableOption "Terminal multiplexer written in Rust that uses WASM for plugins";
  };

  config = lib.mkIf config.custom.zellij.enable {
    nixpkgs.overlays = [
      (self: super: {
        zjstatus = inputs.zjstatus.packages.${super.system}.default;
      })
    ];

    environment.systemPackages = with pkgs; [
      zellij
      zjstatus
    ];

    home-manager.users.nicholas = {
      home.file = {
        ".config/zellij" = {
          source = ./config;
          recursive = true;
        };
      };

      home.file.".config/zellij/layouts/default.kdl".text = ''
        load_plugins {
          "${pkgs.zjstatus}/bin/zjframes.wasm" {
            hide_frame_for_single_pane       "true"
            hide_frame_except_for_search     "true"
            hide_frame_except_for_scroll     "true"
            hide_frame_except_for_fullscreen "true"
          }
        }

        layout {
          default_tab_template {
            children
            pane size=1 borderless=true {
              plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                format_left   "{mode} #[fg=#8be9fd,bold]{session}"
                format_center "{tabs}"
                format_right  "{command_git_branch} {datetime}"
                format_space  ""

                border_enabled  "false"
                border_char     "─"
                border_format   "#[fg=#b3b3b3]{char}"
                border_position "top"

                hide_frame_for_single_pane "true"

                mode_normal  "#[bg=#cc922d,bold]   "
                mode_tmux    "#[bg=#f07178,bold]   "
                mode_locked  "#[bg=#8be9fd,bold]   "
                mode_resize  "#[bg=#b3b3b3,bold]   "

                tab_normal   "#[fg=#b3b3b3] {name} "
                tab_active   "#[fg=#b18840,bold,italic] {name} "

                datetime          "#[fg=#b3b3b3] {format} "
                datetime_format   "%A, %d %b %Y %H:%M"
                datetime_timezone "America/Los_Angeles"
              }
            }
          }
        }
      '';
    };
  };
}
