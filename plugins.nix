{pkgs}:
with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      telescope-nvim
      bufferline-nvim
      neo-tree-nvim
      pywal-nvim
      wal-vim
      indent-blankline-nvim
      neogit
]

