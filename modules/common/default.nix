{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nvim-flake;

  availableGrammars = map (
    grammar: lib.strings.removeSuffix "-grammar" grammar.pname
  ) pkgs.vimPlugins.nvim-treesitter.allGrammars;
in
{
  options.nvim-flake = {
    treesitter = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "treesitter";
          grammars = lib.mkOption {
            type = lib.types.either (lib.types.enum [ "all" ]) (
              lib.types.listOf (lib.types.enum availableGrammars)
            );
            default = "all";
            description = ''
              Either "all" or a list of grammars.
            '';
          };
        };
      };
      default = { };
      description = '''';
    };
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = {
      nvim-flake-ts = "echo '${lib.concatStringsSep " " cfg.treesitter.grammars}'";
    };
  };
}
