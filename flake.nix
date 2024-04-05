{
    description = "NeoVim + Configuration"
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    }
    outputs = { self, ... }@inputs:
    {
        packages."x86_64-linux".default = writeShellApplication {
            name = "nvim"
            runtimeInputs = [ pkgs.neovim ];
            text = ''
            nvim
            ''
        }
    }
}
