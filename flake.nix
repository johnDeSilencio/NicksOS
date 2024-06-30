{
  description = "Nick's OS flake config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      home-manager,
      fenix,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        framework = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [ fenix.overlays.default ];
                environment.systemPackages = with pkgs; [
                  (fenix.packages.${system}.complete.withComponents [
                    "cargo"
                    "clippy"
                    "rust-src"
                    "rustc"
                    "rustfmt"
                  ])
                  rust-analyzer-nightly
                ];
              }
            )
          ];
        };
      };

      homeConfigurations = {
        nicholas = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
