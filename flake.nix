{
  description = "Nick's OS flake config";

  inputs = {
    # Leaf dependencies
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    crane = {
      url = "github:ipetkov/crane/";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:johnDeSilencio/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };

    cucumber-language-server = {
      url = "github:johnDeSilencio/language-server/chore/update-tree-sitter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zellij status bar plugin
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprhook = {
      url = "github:johnDeSilencio/Hyprhook/feature/version-mismatch-fix";
      inputs.hyprland.follows = "hyprland";
    };

    tombi = {
      url = "github:tombi-toml/tombi";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    wild = {
      url = "github:davidlattimore/wild";
      inputs.crane.follows = "crane";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      wild,
      ...
    }:
    let
      system = "x86_64-linux";

      overlays = [
        (wild.overlays.default)
      ];
    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            nixpkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              overlays = overlays;
            };

            inherit inputs;
          };
          modules = [
            ./hosts/framework/configuration.nix
          ];
        };
      };
    };
}
