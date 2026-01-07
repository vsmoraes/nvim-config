# Introduction
This repository holds my own Neovim setup. It was originally built to work on MacOS, but I can't see why it wouldn't also work on Linux and Windows.

My setup is heavily influenced by [ThePrimeage's setup](https://github.com/ThePrimeagen/init.lua), but with my own twist. The idea is to accommodate my muscle memory built over the years by using Sublime Text and IntelliJ shortcuts.

# Installation
Just clone this repository into your `$XDG_CONFIG_HOME/nvim` and Lazy will pretty much take care of the rest once Neovim is opened for the first time.

On first launch, Neovim will automatically:
1. Install all plugins via Lazy
2. Install LSP servers via Mason
3. Install formatters and linters via mason-tool-installer

This may take a few minutes. You can check the progress with `:Lazy` and `:Mason`.

It's also a good idea to run the following checks to validate everything is properly set up:
```vim
:checkhealth lazy
:checkhealth mason
```

# Features
+ Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim).
+ Fuzzy finder via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
+ Code auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
+ LSP support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with Mason for auto-installation.
+ Pre-configured LSPs for Kotlin, PHP, Go, Lua, TypeScript, and JavaScript.
+ Code formatting via [conform.nvim](https://github.com/stevearc/conform.nvim) with auto-format on save.
+ Linting support via [nvim-lint](https://github.com/mfussenegger/nvim-lint) with auto-installation.
+ File tree explorer via [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
+ Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
+ Integrated terminal via [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) with smart run/test commands.
+ Indentation guides via [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
+ Treesitter context for showing current function/class scope.
+ Dracula colors scheme via [dracula.nvim](https://github.com/Mofiqul/dracula.nvim).

# Requirements
Before installing, ensure you have the following installed:

**Note:** LSP servers, formatters, and linters are automatically installed via Mason on first launch. You only need to install the language runtimes and core tools listed below.

## Core Requirements
+ **Neovim** >= 0.9.0
+ **Git** - for cloning plugins
+ **Node.js** >= 18.0 - required by some LSP servers
+ **Python3** - required by some plugins
+ **ripgrep** - for telescope grep functionality
+ **fd** (optional) - for faster file finding in telescope

## Language-Specific Requirements

### Kotlin
+ **JDK** >= 11
+ **Kotlin compiler** (`kotlinc`)
+ **Gradle** (for project builds)

### PHP
+ **PHP** >= 8.0
+ **Composer** - PHP dependency manager

### Go
+ **Go** >= 1.20

### Lua
+ **Lua** >= 5.1 (usually bundled with Neovim)
+ **luacheck** - Lua linter

## Installation Commands

### macOS (using Homebrew)
```bash
brew install neovim git node ripgrep fd
brew install openjdk kotlin gradle php composer go lua luacheck
```

### Linux (Debian/Ubuntu)
```bash
sudo apt install neovim git nodejs npm ripgrep fd-find
sudo apt install default-jdk kotlin gradle php composer golang lua5.4 luarocks
sudo luarocks install luacheck
```

### Linux (Arch)
```bash
sudo pacman -S neovim git nodejs npm ripgrep fd
sudo pacman -S jdk-openjdk kotlin gradle php composer go lua luarocks
sudo luarocks install luacheck
```

# Keymaps

## Leader Key
The leader key is set to `<Space>`.

## File Navigation & Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>pv` | Normal | Open file explorer (netrw) |
| `<S-n>` | Normal | Toggle file tree (nvim-tree) |

## Diagnostics
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>e` | Normal | Toggle diagnostics location list |

## LSP Navigation
| Keymap | Mode | Description |
|--------|------|-------------|
| `gd` | Normal | Go to definition (via Telescope) |
| `gt` | Normal | Go to type definition (falls back to definition if not supported) |
| `gr` | Normal | Go to references (via Telescope) |

## Telescope - Fuzzy Finder
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>pf` | Normal | Find files in project |
| `<C-p>` | Normal | Find git files |
| `<leader>pws` | Normal | Grep word under cursor |
| `<leader>pWs` | Normal | Grep WORD under cursor (includes special chars) |
| `<leader>ps` | Normal | Grep search with input prompt |
| `<leader>vh` | Normal | Search help tags |

## Code Formatting
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>mp` | Normal/Visual | Format file or selected range |

## Terminal Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-\>` | Normal | Toggle floating terminal |
| `<Esc>` | Terminal | Exit terminal mode (back to normal mode) |
| `<C-q>` | Terminal | Close terminal |

## Run & Test Commands
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>rr` | Normal | Run application (auto-detects project type) |
| `<leader>rt` | Normal | Run tests (auto-detects project type) |

## Completion (Insert Mode)
| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-p>` | Insert | Select previous completion item |
| `<C-n>` | Insert | Select next completion item |
| `<C-y>` | Insert | Confirm completion selection |
| `<C-Space>` | Insert | Trigger completion menu |

## Default Vim Keymaps Worth Knowing
These are standard Vim keymaps that are useful to know:

### Navigation
| Keymap | Description |
|--------|-------------|
| `h/j/k/l` | Move left/down/up/right |
| `w/b` | Move forward/backward by word |
| `0/$` | Move to start/end of line |
| `gg/G` | Go to first/last line |
| `{/}` | Move by paragraph |
| `<C-u>/<C-d>` | Scroll up/down half page |
| `<C-b>/<C-f>` | Scroll up/down full page |

### Editing
| Keymap | Description |
|--------|-------------|
| `i/a` | Insert before/after cursor |
| `I/A` | Insert at start/end of line |
| `o/O` | Open new line below/above |
| `x/X` | Delete character under/before cursor |
| `dd` | Delete line |
| `yy` | Yank (copy) line |
| `p/P` | Paste after/before cursor |
| `u/<C-r>` | Undo/redo |
| `.` | Repeat last command |

### Visual Mode
| Keymap | Description |
|--------|-------------|
| `v` | Enter visual mode (character-wise) |
| `V` | Enter visual line mode |
| `<C-v>` | Enter visual block mode |

### Search & Replace
| Keymap | Description |
|--------|-------------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n/N` | Next/previous search result |
| `*/#` | Search word under cursor forward/backward |
| `:s/old/new/g` | Replace in line |
| `:%s/old/new/g` | Replace in file |
