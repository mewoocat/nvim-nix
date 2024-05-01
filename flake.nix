{
    description = "NeoVim + Configuration";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs = { self, ... }@inputs: let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        neovimConfigFiles = pkgs.callPackage ./config { }; # Copy config files to output path
        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
            customRC = "luafile ${neovimConfigFiles}/init.lua"; # Vimscript config
            plugins = pkgs.callPackage ./plugins.nix { };
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
