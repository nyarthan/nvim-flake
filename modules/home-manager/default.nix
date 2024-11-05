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
  imports = [
    ../common
  ];

  options.nvim-flake = {
    enable = lib.mkEnableOption "nvim-flake";

    appName = lib.mkOption {
      type = lib.types.str;
      description = ''
        value of $NVIM_APPNAME
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = {
      nvim-flake = "echo THIS_WORKS";
    };
  };
}
