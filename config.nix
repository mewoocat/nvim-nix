{ pkgs }:

# Creates derivation that copies lua setup file to derivation path
pkgs.stdenv.mkDerivation {
    name = "neovim-config";
    src = ./config/.;
    installPhase = ''
        cp -r $src $out
    '';
}
