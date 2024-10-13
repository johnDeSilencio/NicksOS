{ config, pkgs, ... }:
let
  rust-nightly = pkgs.rust-bin.selectLatestNightlyWith (t: t.default);
  rust-stable = pkgs.rust-bin.stable.latest.default;

  # Define a custom script for using Rust nightly
  switch-rust-nightly = pkgs.writeScriptBin "swn" ''
    #! ${pkgs.fish}/bin/fish
    set -U RUSTC "${rust-nightly}/bin/rustc"
    set -U CARGO "${rust-nightly}/bin/cargo"
  '';

  # Define a custom script for using Rust stable
  switch-rust-stable = pkgs.writeScriptBin "sws" ''
    #! ${pkgs.fish}/bin/fish
    set -U RUSTC "${rust-stable}/bin/rustc"
    set -U CARGO "${rust-stable}/bin/cargo"
  '';
in
{

  environment.systemPackages = with pkgs; [
    bugstalker
    cargo-asm
    cargo-audit
    cargo-auditable
    cargo-binstall
    cargo-crev
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

    # Used to switch between installed Rust versions
    switch-rust-nightly
    switch-rust-stable
  ];
}
