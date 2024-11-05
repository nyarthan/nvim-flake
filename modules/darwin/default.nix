{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nvim-flake;
in
{
  options.nvim-flake = { };

  config = lib.mkIf cfg.enable { };
}
