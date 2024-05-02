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
    luaFilesContents = map (file: builtins.readFile "${neovim-config}/${file}") luaFiles;
    luaFilesToViml = map (file: "luafile ${file}") luaFilesContents;
    luaFilesCat = pkgs.lib.strings.concatStringsSep "\n" luaFilesToViml;
in
    luaFilesCat
