{
  description = "Nick's OS flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    cucumber-language-server = {
      url = "github:johnDeSilencio/language-server/chore/update-tree-sitter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
    };

    # Zellij status bar plugin
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.rust-overlay.follows = "rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.49.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprhook = {
      url = "github:Hyprhook/Hyprhook";
      inputs.hyprland.follows = "hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprhook-mouse-move = {
      url = "github:johnDeSilencio/hyprhook-mouse-move";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      rust-overlay,
      zjstatus,
      hyprhook,
      hyprhook-mouse-move,
      ...
    }:
    let
      system = "x86_64-linux";

      overlays = [
        (final: prev: {
          zjstatus = zjstatus.packages.${prev.system}.default;
        })
      ];
    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              zjstatus
              inputs
              hyprhook
              hyprhook-mouse-move
              ;
          };
          modules = [
            { nixpkgs.overlays = overlays; }
            ./hosts/framework/configuration.nix
            inputs.musnix.nixosModules.musnix
          ];

        };
      };

    };
}
