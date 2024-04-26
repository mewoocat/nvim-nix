{pkgs}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n"; # Run lua string as vimscript
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n"; # Run lua file as vimscript
in
with pkgs.vimPlugins; [
  {
    plugin = nvim-treesitter.withAllGrammars;
    config = ""; 
  }
  {
    plugin = telescope-nvim;
    #config = toLuaFile ./telescope.lua;
  }
  {
    plugin = bufferline-nvim;
    config = toLua "require(\"bufferline\").setup()";
  }
  {
    plugin = neo-tree-nvim;
    config = "";
  }
  {
    plugin = pywal-nvim;
    config = "";
  } 
  {
    plugin = wal-vim;
    config = "";
  } 
  {
    plugin = indent-blankline-nvim;
    #config = toLua "require(\"ibl\").setup()";
  }
  {
    plugin = neogit;
    config = "";
  }
]
