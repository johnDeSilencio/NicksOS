{ config, pkgs, ... }:
{
  imports = [
    ./neovim.nix
  ];

  environment.systemPackages = with pkgs; [
    android-tools

    # Shell history tool
    atuin

    # cat clone that supports colors and paging
    bat
    cmake

    # Query and display system information like serial #
    dmidecode

    # For writing down ideas in the terminal quickly
    eureka-ideas

    # A better GNU find
    fd
    gcc
    gnumake
    gping
    htop
    killall

    # ;) (ls replacement)
    lsd
    nmap

    # Compression / decompression tool
    ouch
    pass

    # Supports running arbitrary hooks during commit lifecycle
    pre-commit
    procs
    qemu

    # A better, faster grep
    ripgrep

    # Query and display data about SSD / hard drive health
    smartmontools

    # Colorful & configurable terminal prompt
    starship
    tailwindcss

    # An engine for writing and checking of to-dos
    taskwarrior3
    taskwarrior-tui

    # TL;DR tool for CLI commands
    tealdeer

    # Rust rewrite
    uutils-coreutils-noprefix

    # Execute arbitrary commands when a file changes
    watchexec
    wget

    # wl-copy and wl-paste
    wl-clipboard-rs

    # Terminal multiplexer
    zellij
  ];

  # Fish
  programs.fish.enable = true;
}
