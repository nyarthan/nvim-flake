{
  description = "Nvim flake flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
        };

      flake = {
        nixosModules = {
          nvim-flake = ./modules/nixos;
          default = self.nixosModules.nvim-flake;
        };
        darwinModules = {
          nvim-flake = ./modules/darwin;
          default = self.darwinModules.nvim-flake;
        };
        homeManagerModules = {
          nvim-flake = ./modules/home-manager;
          default = self.homeManagerModules.nvim-flake;
        };
        flakeModules = {
          nvim-flake = ./modules/flake;
          default = self.flakeModules.nvim-flake;
        };

        treesitter-dependencies = import ./pkgs/treesitter-dependencies.nix;
      };
    };
}
