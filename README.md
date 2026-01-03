# Introduction
This repository holds my own Neovim setup. It was originally built to work on MacOS, but I can't see why it wouldn't also work on Linux and Windows.

My setup is heavily influenced by [ThePrimeage's setup](https://github.com/ThePrimeagen/init.lua), but with my own twist. The idea is to accommodate my muscle memory built over the years by using Sublime Text and IntelliJ shortcuts.

# Installation
Just clone this repository into your `$XDG_CONFIG_HOME/nvim` and Lazy will pretty much take care of the rest once Neovim is oponed for the first time.

It's also a good idea to run the following check to validate that Lazy is properly set up:
```bash
:checkhealth lazy
```

# Features
+ Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim).
+ Fuzzy finder via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
+ Code auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
+ LSP support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
+ File tree explorer via [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
+ Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
+ Dracula colors cheme via [dracula.nvim](https://github.com/Mofiqul/dracula.nvim).
