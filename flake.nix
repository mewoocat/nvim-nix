{
    description = "NeoVim + Configuration";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs = { self, ... }@inputs: let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        #plugins = pkgs.callPackage ./plugins.nix { };
        #config = pkgs.callPackage ./
        plugins = with pkgs.vimPlugins; [
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
            #config = toLua "require(\"bufferline\").setup()";
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
        ];

        # Copy config files to output path
        neovimConfigFiles = pkgs.callPackage ./config.nix {};
        # TODO: Figure out why setup.lua is not in /config 
        config = "luafile ${neovimConfigFiles}/setup.lua";


        #config = "luafile ./setup.lua";
    
        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
            customRC = config;
            plugins = plugins;
        };
        neovimWrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
    in
    {
        packages."x86_64-linux".default = pkgs.writeShellApplication {
            name = "nvim";
            runtimeInputs = [  ];
            text = ''
                ${neovimWrapped}/bin/nvim "$@"
            '';
        };
    };
}
