{ pkgs }:
let
    luaFiles = [
        "setup.lua"
        "test.lua"
    ];
    # Creates derivation that copies lua setup file to derivation path
    neovim-config = pkgs.stdenv.mkDerivation {
        name = "neovim-config";
        src = ./lua;
        installPhase = ''
            cp -r $src $out
        '';
    };
    # this needs to be path not contents
    #luaFilesContents = map (file: builtins.readFile "${neovim-config}/${file}") luaFiles;
    luaFilesToViml = map (file: "luafile ${neovim-config}/${file}") luaFiles;
    luaFilesCat = pkgs.lib.strings.concatStringsSep "\n" luaFilesToViml;
in
    luaFilesCat
