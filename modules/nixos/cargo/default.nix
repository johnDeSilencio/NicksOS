{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.cargo.enable = lib.mkEnableOption "Cargo extensions and independent command-line utilities to help with Rust development";
  };

  config = lib.mkIf config.custom.cargo.enable {
    home-manager.users.nicholas = {
      home.file = {
        ".cargo/config.toml" = {
          source = ./config/config.toml;
          recursive = false;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      bugstalker
      cargo-audit
      cargo-auditable
      cargo-binstall
      cargo-crev
      cargo-criterion
      cargo-deny
      cargo-edit
      cargo-espmonitor
      cargo-expand
      cargo-flamegraph
      cargo-generate
      cargo-limit
      cargo-machete
      cargo-modules
      cargo-msrv
      cargo-nextest
      cargo-release
      cargo-semver-checks
      cargo-show-asm
      cargo-sort
      cargo-sweep
      cargo-tarpaulin
      cargo-udeps
      cargo-update
      cargo-watch
      espflash
      panamax
      trunk
    ];
  };
}
