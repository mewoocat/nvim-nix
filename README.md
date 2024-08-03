My personal NeoVim configuration packages as a nix flake.

# Overview
The key properties of this nvim config
- nix for plugin package management
- A focus on using lua for config

# Installation
## Run temporarily
- Locally:   `nix run .#`
- Remotely:  `nix run github:mewoocat/nvim-nix`

## Flake
Add to flake inputs,
```
inputs = {
    ...
    myNvim.url = "github:mewoocat/nvim-nix";
    ...
};
```
Then add `inputs.myNvim.packages.x86_64-linux.default` to system or homemanager packages.

## Nix-env

#### Install nix & enable flakes
```
sh <(curl -L https://nixos.org/nix/install) --daemon
export NIX_CONFIG="experimental-features = nix-command flakes"
```

`nix run github:mewoocat/NixOS#nvim`

`nix profile install github:mewoocat/NixOS#nvim`
todo

# Usage
## Running
```
nvim
```


# Credits
ty to :)
- https://github.com/QuantumCoded/neovim
