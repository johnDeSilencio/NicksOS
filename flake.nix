{
  description = "Nick's OS flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      catppuccin,
      home-manager,
      rust-overlay,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            (
              { pkgs, ... }:
              let
                rust-stable-toolchain = pkgs.rust-bin.stable.latest.default.override {
                  extensions = [
                    "rust-src"
                    "rust-analyzer"
                  ];
                  targets = [
                    "x86_64-unknown-linux-gnu"
                    "wasm32-unknown-unknown"
                  ];
                };

                rust-nightly-toolchain = pkgs.rust-bin.selectLatestNightlyWith (
                  toolchain:
                  toolchain.default.override {
                    extensions = [
                      "rust-src"
                      "rust-analyzer"
                    ];
                    targets = [
                      "x86_64-unknown-linux-gnu"
                      "wasm32-unknown-unknown"
                    ];
                  }
                );
              in
              {
                nixpkgs.overlays = [ rust-overlay.overlays.default ];

                environment.systemPackages = [
                  rust-stable-toolchain
                  rust-nightly-toolchain
                ];
              }
            )
          ];
        };
      };

      homeConfigurations = {
        nicholas = home-manager.lib.homeManagerConfiguration {
          modules = [
            ./home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
