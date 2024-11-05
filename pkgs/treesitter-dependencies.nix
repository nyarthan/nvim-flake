{
  pkgs,
  grammars ? "all",
}:
let
  inherit (pkgs.vimPlugins.nvim-treesitter) withAllGrammars withPlugins;
in
pkgs.symlinkJoin {
  name = "treesitter-dependencies";
  paths =
    (
      if grammars == "all" then
        withAllGrammars
      else
        withPlugins (plugins: map (grammar: plugins.${grammar}) grammars)
    ).dependencies;
}
