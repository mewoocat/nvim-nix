{pkgs}: let
    toLua = str: "lua << EOF\n${str}\nEOF\n"; # Run lua string as vimscript
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n"; # Run lua file as vimscript
in
with pkgs.vimPlugins; [
  {
    plugin = nvim-treesitter.withAllGrammars;
  }
  {
    plugin = telescope-nvim;
  }
  {
    plugin = bufferline-nvim;
    #config = toLua "require(\"bufferline\").setup()";
  }
  {
    plugin = neo-tree-nvim;
  }
  {
    plugin = pywal-nvim;
  } 
  {
    plugin = wal-vim;
  } 
  {
    plugin = indent-blankline-nvim;
    config = toLua "require(\"ibl\").setup()";
  }
  {
    plugin = neogit;
  }
  {
    plugin = lualine-nvim;
  }

  # cmp
  {
    plugin = nvim-lspconfig;
  }
  {
    plugin = cmp-nvim-lsp;
  }
  {
    plugin = cmp-buffer;
  }
  {
    plugin = cmp-path;
  }
  {
    plugin = cmp-cmdline;
  }
  {
    plugin = nvim-cmp;
  }
  {
    plugin = nvim-autopairs;
  }

] 

# Build and add plugins not in nixpkgs
++ [
    {
        plugin = pkgs.vimUtils.buildVimPlugin {
          pname = "neopywal";
          version = "";
          src = builtins.fetchGit {
            url = "https://github.com/RedsXDD/neopywal.nvim.git";
            ref = "master";
            rev = "57fb800ccc1c2dd2f6623b82ef3612927a36fd4a";
          };
          #buildScript = ":";
        };
    }
]
