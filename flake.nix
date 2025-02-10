{
  description = "Nick's OS flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

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
    {
      nixpkgs,
      catppuccin,
      home-manager,
      rust-overlay,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          specialArgs.inputs = inputs;
          inherit system;
          modules = [
            ./hosts/framework/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.nicholas = import ./home.nix;
            }
          ];
        };
      };
    };
}
