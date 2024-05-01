{ pkgs }:

# Creates derivation that copies lua setup file to derivation path
pkgs.stdenv.mkDerivation {
    name = "neovim-config";
    src = ./.; # prob gonna throw error
    installPhase = ''
        cp -r $src $out
    '';
}
