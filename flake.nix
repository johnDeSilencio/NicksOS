{
  description = "Nick's OS flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
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
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/framework/configuration.nix
          ];
        };
      };
    };
}
