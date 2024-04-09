{
    description = "NeoVim + Configuration";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs = { self, ... }@inputs: let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        plugins = pkgs.callPackage ./plugins.nix { };
        config = pkgs.callPackage ./
        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
            customRC = "";
            plugins = map (plugin: { inherit plugin; }) plugins;
        };
        neovimWrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
    in
    {
        packages."x86_64-linux".default = pkgs.writeShellApplication {
            name = "nvim";
            runtimeInputs = [ pkgs.neovim ];
            text = ''
                ${neovimWrapped}/bin/nvim "$@"
            '';
        };
    };
}
