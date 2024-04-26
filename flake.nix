{
    description = "NeoVim + Configuration";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs = { self, ... }@inputs: let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        plugins = pkgs.callPackage ./plugins.nix { };
        # Copy config files to output path
        neovimConfigFiles = pkgs.callPackage ./config { };
        # Vimscript config
        config = "luafile ${neovimConfigFiles}/setup.lua";
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
