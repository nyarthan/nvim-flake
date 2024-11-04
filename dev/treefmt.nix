{
  config,
  pkgs,
  ...
}:
{
  inherit (config.flake-root) projectRootFile;
  package = pkgs.treefmt;
  settings = {
    global.excludes = [
      "./.direnv"
      ".envrc"
      "treefmt.toml"
    ];
    formatter = {
      "justfile" = {
        command = "${pkgs.just}/bin/just";
        options = [
          "--unstable"
          "--fmt"
          "--check"
          "--justfile"
        ];
        includes = [ "justfile" ];
      };
    };
  };
  programs = {
    nixfmt.enable = true;
    mdformat.enable = true;
    yamlfmt.enable = true;
  };
}
