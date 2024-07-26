My personal NeoVim configuration packages as a nix flake.

# Overview
---
The key properties of this nvim config
- nix for plugin package management
- A focus on using lua for config

# Installation
---
## Run temporarily
Locally:   `nix run .#`
Remotely:  `nix run github:mewoocat/nvim-nix`

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
todo

# Usage
---
Run
```
nvim
```


# Credits
---
ty to :)
- https://github.com/QuantumCoded/neovim
