{
  description = "Nick's OS flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
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
                  targets = [
                    "x86_64-unknown-linux-gnu"
                    "wasm32-unknown-unknown"
                  ];
                };

                rust-nightly-toolchain = pkgs.rust-bin.selectLatestNightlyWith (
                  toolchain:
                  toolchain.default.override {
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
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./home.nix
          ];
        };
      };
    };
}
