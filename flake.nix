{
  description = "Lab flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      treefmt-nix,
      flake-root,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      imports = [
        treefmt-nix.flakeModule
        flake-root.flakeModule
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
          treefmt.config = import ./treefmt.nix {
            inherit config pkgs;
          };

          devShells.default = pkgs.mkShell {
            packages = [
              pkgs.just
              pkgs.treefmt
              pkgs.git
            ];

            shellHook = ''
              cp -f ${config.treefmt.build.configFile} treefmt.toml
            '';
          };

          formatter = config.treefmt.build.wrapper;
        };
    };
}
