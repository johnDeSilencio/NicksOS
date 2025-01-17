{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    bugstalker
    cargo-asm
    cargo-audit
    cargo-auditable
    cargo-binstall
    cargo-crev
    cargo-criterion
    cargo-deny
    cargo-edit
    cargo-espflash
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
    cargo-sort
    cargo-tarpaulin
    cargo-udeps
    cargo-update
    cargo-watch
    trunk
  ];
}
