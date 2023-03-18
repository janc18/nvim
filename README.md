# My Neovim Setup

My personal Neovim setup written in Lua.

<div align="center">
  <img src="https://raw.githubusercontent.com/wuelnerdotexe/nvim/main/assets/screenshot.png">
  Powered by <strong><a href="https://wuelnerdotexe.github.io/enfocado/">Enfocado</a></strong>.
</div>

## Table of Contents

- [Features](#features)
- [Philosophy](#philosophy)
- [Requirements](#requirements)
- [Installation](#installation)
- [Keymaps](#keymaps)
  - [General](#general)
  - [Explorer](#explorer)
    - [Folders Explorer](#folders-explorer)
    - [Git Explorer](#git-explorer)
  - [Windows](#windows)
  - [Buffers](#buffers)
  - [Tabs](#tabs)
  - [Snippets](#snippets)
  - [Selection](#selection)
  - [Commenting](#commenting)
  - [Moving text](#moving-text)
  - [Git signs](#git-signs)
  - [Language servers](#language-servers)
  - [Debugging](#debugging)
- [Recommendations](#recommendations)
  - [Fonts](#fonts)
  - [Docker](#docker)
- [Maintainer](#maintainer)
- [License](#license)

## Features

The main features and plugins provided by this setup are as follows:

- 🧠 Smooth times based on scientific research.
- 🫴 Lazy loading of plugins with [lazy.nvim](https://github.com/folke/lazy.nvim).
- ⚡ Modern Vim's native options by [human.vim](https://github.com/wuelnerdotexe/human.vim).
- 📂 Robust folders explorer with [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim).
- 🔭 Powerful fuzzy finder with [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim).
- 🌳 Advanced syntax recognition with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- 💡 Neovim native language server protocol.
- 🔗 Multiple cursors with [vim-visual-multi](https://github.com/mg979/vim-visual-multi).
- 📜 [Friendly snippets](https://github.com/rafamadriz/friendly-snippets) with [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
- 🤖 Autocomplete with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) powered by [Tabnine](https://www.tabnine.com/) Machine Learning.
- 👷 Git status of files with [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
- 🐛 Code debugging with [nvim-dap](https://github.com/mfussenegger/nvim-dap).
- 👀 Markdown previewer with [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
- 🐱 Useful and smart status bar with [feline.nvim](https://github.com/feline-nvim/feline.nvim).
- 👁 Harmonic and consistent theme by [Enfocado](https://wuelnerdotexe.github.io/enfocado).
- 💅 Modern and nice user interface with [bufferline.nvim](https://github.com/akinsho/bufferline.nvim), [dressing.nvim](https://github.com/stevearc/dressing.nvim), and [noice.nvim](https://github.com/folke/noice.nvim).
- 🟩 Tmux integration with [tmux.nvim](https://github.com/aserowy/tmux.nvim).
- 😎 Last but not least, announce your presence on Discord with funny messages (in Spanish) by [presence.nvim](https://github.com/andweeb/presence.nvim).

## Philosophy

> My Neovim setup, **unlike many others**, has and follows a **well-defined philosophy**, governed by **coherence** and **minimalism**. You won't find any unnecessary plugins or redundant plugins here, and **every little aspect** is tweaked to keep everything consistent as a whole; for example, all the icons used are the standard ones and all floating windows have a rounded edge. As it should be...

**DISCLAIMER:** Due to this you will see that I make many commits perfecting aspects that seem insignificant, I apologize for my sick perfectionism.

## Requirements

- [Nerd Fonts](https://www.nerdfonts.com/) patched with [codicons.ttf](https://github.com/microsoft/vscode-codicons) - to show nice icons.
- [Neovim](https://neovim.io/) >= v0.8 - obviously.
- [Git](https://git-scm.com/) - to install nvim plugins with [lazy.nvim](https://github.com/folke/lazy.nvim).
- [Node](https://nodejs.org/) and [NPM](https://www.npmjs.com/package/npm) - to install language servers and debug adapters with [mason.nvim](https://github.com/williamboman/mason.nvim).
- [ripgrep (rg)](https://github.com/BurntSushi/ripgrep) - to search patterns with [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim).
- [fd](https://github.com/sharkdp/fd) - to find files with [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim).

## Installation

First, if you have a previous Neovim config, make sure to make a backup before installing this setup in case something goes wrong in the process. This is done by backing up the `~/.config/nvim/` folder and its contents.

To install this configuration, you just need to clone this repository to the Neovim user config runtime directory for your operating system, which you can find [here](https://neovim.io/doc/user/starting.html#config), or by running the `:help config` help command within Neovim. For a clean install, make sure you have all Neovim runtime folders `~/.local/share/nvim` (Linux/MacOS) and `$LOCALAPPDATA/nvim-data` (Windows) clean.

For example, to install on Linux/MacOS:

```bash
git clone https://github.com/wuelnerdotexe/nvim ~/.config/nvim --depth 1
```

## Keymaps

The keymaps created by this config are very well thought out to be intuitive, meaningful, and most of all, to stick to the essence of Vim without conflicting with it. Keymaps are normally assigned two letters, which signify an action, for example: `d` + `p` = `d`iagnostic `p`review. Keep in mind that the functionality will always come first and then the action. This is the standard created and used by this configuration for unique consistency.

**IMPORTANT:** The `\` backslash remains as the global `<leader>` leadermap.

### General

|      VI Mode      |         Keymap         | Description                           |
| :---------------: | :--------------------: | ------------------------------------- |
|      Normal       | `<leader>` + `f` + `t` | Toggle the folders explorer           |
|      Normal       | `<leader>` + `f` + `f` | Find files in the current directory   |
|      Normal       | `<leader>` + `p` + `f` | Find the workspace projects           |
|      Normal       | `<leader>` + `o` + `f` | Find recently opened files            |
|      Normal       | `<leader>` + `m` + `f` | Find Vim files marks                  |
| Normal and visual | `<leader>` + `w` + `f` | Find word in the current directory    |
| Normal and visual | `<leader>` + `w` + `r` | Replace word in the current directory |
|      Normal       | `<leader>` + `g` + `t` | Toggle the git explorer               |
|      Normal       | `<leader>` + `g` + `f` | Find files from git status            |
|      Normal       | `<leader>` + `r` + `f` | Find resume                           |
|      Normal       | `<leader>` + `s` + `t` | Toggle document symbols               |
|      Normal       | `<leader>` + `t` + `o` | Open the terminal in a new buffer     |
|      Normal       | `<leader>` + `t` + `t` | Toggle bottom terminal                |

### Explorer

| VI Mode |         Keymap          | Description                  |
| :-----: | :---------------------: | ---------------------------- |
| Normal  | Double left mouse click | Expand/open or collapse node |
| Normal  |         `ENTER`         | Expand/open or collapse node |
| Normal  |      `CTRL` + `t`       | Open in a new tab            |
| Normal  |      `CTRL` + `s`       | Open in a new split          |
| Normal  |      `CTRL` + `v`       | Open to the side             |
| Normal  |           `a`           | Add node                     |
| Normal  |           `r`           | Rename node                  |
| Normal  |           `m`           | Move node                    |
| Normal  |           `c`           | Copy node                    |
| Normal  |           `d`           | Delete node                  |
| Normal  |           `y`           | Copy node to clipboard       |
| Normal  |           `x`           | Cut node to clipboard        |
| Normal  |           `p`           | Paste node from clipboard    |
| Normal  | `<localleader>` + `pt`  | Toggle preview               |
| Normal  |           `q`           | Exit                         |
| Normal  |         `<F5>`          | Refresh the explorer         |

#### Folders Explorer

| VI Mode |    Keymap    | Description                      |
| :-----: | :----------: | -------------------------------- |
| Normal  |     `>`      | Enter directory                  |
| Normal  |     `<`      | Leave directory                  |
| Normal  |     `/`      | Fuzzy finder                     |
| Normal  | `CTRL` + `f` | Filter nodes                     |
| Normal  |   `<Esc>`    | Clear filter                     |
| Normal  |  `[` + `g`   | Go to previous git modified node |
| Normal  |  `]` + `g`   | Go to next git modified node     |

#### Git Explorer

| VI Mode |  Keymap   | Description      |
| :-----: | :-------: | ---------------- |
| Normal  | `g` + `s` | Git stage file   |
| Normal  | `g` + `u` | Git unstage file |
| Normal  | `g` + `r` | Git revert file  |
| Normal  | `g` + `A` | Git add all      |
| Normal  | `g` + `c` | Git commit       |

### Windows

|      VI Mode      |       Keymap       | Description                              |
| :---------------: | :----------------: | ---------------------------------------- |
| Normal and visual |    `CTRL` + `h`    | Move to the left window                  |
| Normal and visual |    `CTRL` + `j`    | Move to the down window                  |
| Normal and visual |    `CTRL` + `k`    | Move to the up window                    |
| Normal and visual |    `CTRL` + `l`    | Move to the right window                 |
| Normal and visual |    `Alt` + `h`     | Resize the window on the left            |
| Normal and visual |    `Alt` + `j`     | Resize the window on the down            |
| Normal and visual |    `Alt` + `k`     | Resize the window on the up              |
| Normal and visual |    `Alt` + `l`     | Resize the window on the right           |
| Normal and visual | `CTRL` + `w` + `m` | Toggle maximizer window                  |
| Normal and visual | `CTRL` + `w` + `o` | Close all windows except the current one |
| Normal and visual | `CTRL` + `w` + `t` | Open the current file in a new tab       |
| Normal and visual | `CTRL` + `w` + `s` | Split horizontally the current file      |
| Normal and visual | `CTRL` + `w` + `v` | Split vertically the current file        |

### Buffers

| VI Mode |        Keymap         | Description                              |
| :-----: | :-------------------: | ---------------------------------------- |
| Normal  |       `g` + `B`       | Go to previous buffer                    |
| Insert  |  `SHIFT` + `PAGE UP`  | Go to previous buffer                    |
| Normal  |       `g` + `b`       | Go to next buffer                        |
| Insert  | `SHIFT` + `PAGE DOWN` | Go to next buffer                        |
| Normal  |   `SHIFT` + `Home`    | Move buffer left                         |
| Normal  |    `SHIFT` + `End`    | Move buffer right                        |
| Normal  |       `1` + `b`       | Close all buffers except the current one |

### Tabs

| VI Mode |        Keymap        | Description                           |
| :-----: | :------------------: | ------------------------------------- |
| Normal  |      `g` + `T`       | Go to the previous tab                |
| Insert  |  `CTRL` + `PAGE UP`  | Go to the previous tab                |
| Normal  |      `g` + `t`       | Go to the next tab                    |
| Insert  | `CTRL` + `PAGE DOWN` | Go to the next tab                    |
| Normal  |      `1` + `t`       | Close all tabs except the current one |

### Snippets

|      VI Mode      |     Keymap      | Description                                     |
| :---------------: | :-------------: | ----------------------------------------------- |
|      Insert       |      `TAB`      | Expand snippet or jump to the next snippet node |
| Insert and select | `SHIFT` + `TAB` | Jump to the previous snippet node               |
|      select       |      `TAB`      | Jump to the next snippet node                   |

### Selection

|           VI Mode           |    Keymap    | Description                  |
| :-------------------------: | :----------: | ---------------------------- |
|           Normal            | `Alt` + `v`  | Init incremental selection   |
|           Visual            | `CTRL` + `a` | Increment the node selection |
|           Visual            | `CTRL` + `x` | Decrement the node selection |
| Visual and operator pending |  `a` + `f`   | Select arround function      |
| Visual and operator pending |  `i` + `f`   | Select inner function        |
| Visual and operator pending |  `a` + `c`   | Select arround condition     |
| Visual and operator pending |  `i` + `c`   | Select inner condition       |
| Visual and operator pending |  `a` + `l`   | Select arround loop          |
| Visual and operator pending |  `i` + `l`   | Select inner loop            |

### Commenting

|           VI Mode           |     Keymap      | Description               |
| :-------------------------: | :-------------: | ------------------------- |
|           Normal            | `g` + `c` + `c` | Comment the current line  |
| Visual and operator pending |    `g` + `c`    | Comment current selection |

### Moving text

|      VI Mode      |     Keymap      | Description     |
| :---------------: | :-------------: | --------------- |
| Normal and visual | `Alt` + `Left`  | Move char left  |
| Normal and visual | `Alt` + `Down`  | Move line down  |
| Normal and visual |  `Alt` + `Up`   | Move line up    |
| Normal and visual | `Alt` + `Right` | Move char right |

### Git signs

|      VI Mode      |         Keymap         | Description                                                 |
| :---------------: | :--------------------: | ----------------------------------------------------------- |
|      Normal       | `<leader>` + `g` + `d` | Split git diffs                                             |
|      Normal       | `<leader>` + `d` + `t` | Toggle show deleted lines                                   |
|      Normal       | `<leader>` + `b` + `t` | Toggle the current line blame                               |
|      Normal       |       `[` + `h`        | Go to the previous hunk (can be repetable with `,` and `;`) |
|      Normal       |       `]` + `h`        | Go to the next hunk (can be repetable with `,` and `;`)     |
|      Normal       | `<leader>` + `h` + `p` | Preview the current hunk                                    |
|      Normal       | `<leader>` + `b` + `p` | Preview the current line blame                              |
| Normal and Visual | `<leader>` + `h` + `s` | Stage the current hunk                                      |
|      Normal       | `<leader>` + `h` + `r` | Reset the current hunk                                      |

### Language servers

|      VI Mode      |         Keymap         | Description                                                   |
| :---------------: | :--------------------: | ------------------------------------------------------------- |
|      Normal       | `<leader>` + `l` + `t` | Toggle lines diagnostics                                      |
|      Normal       | `<leader>` + `h` + `t` | Toggle inlay hints                                            |
|      Normal       | `<leader>` + `d` + `p` | Preview of the current diagnostic                             |
|      Normal       | `<leader>` + `d` + `l` | Show list of diagnostics                                      |
|      Normal       |       `[` + `d`        | Go to previous diagnostic (can be repetable with `,` and `;`) |
|      Normal       |       `]` + `d`        | Go to next diagnostic (can be repetable with `,` and `;`)     |
|      Insert       |      `CTRL` + `b`      | Scroll up in the documentation                                |
|      Insert       |      `CTRL` + `f`      | Scroll down in the documentation                              |
|      Normal       |          `K`           | Show hover documentation                                      |
|      Insert       |      `CTRL` + `k`      | Show signature help                                           |
|      Normal       | `<leader>` + `s` + `r` | Rename the current symbol                                     |
|      Normal       | `<leader>` + `r` + `l` | Show list of references                                       |
|      Normal       |       `g` + `d`        | Go to definition                                              |
|      Normal       |       `g` + `D`        | Peek definition                                               |
|      Normal       |       `g` + `i`        | Go to implementation                                          |
|      Normal       | `<leader>` + `c` + `a` | Show current code actions                                     |
| Normal and Visual | `<leader>` + `c` + `f` | Format the code                                               |

### Debugging

| VI Mode |          Keymap           | Description                             |
| :-----: | :-----------------------: | --------------------------------------- |
| Normal  |          `<F9>`           | Toggle breakpoint on the current line   |
| Normal  |          `<F5>`           | Run and debug                           |
| Normal  |     `SHIFT` + `<F5>`      | Terminate the current debugging session |
| Normal  | `SHIFT` + `CTRL` + `<F5>` | Restart the current debugging session   |
| Normal  |          `<F6>`           | Debug pause                             |
| Normal  |          `<F10>`          | Debug step over                         |
| Normal  |          `<F11>`          | Debug step into                         |
| Normal  |     `CTRL` + `<F11>`      | Debug step into targets                 |
| Normal  |     `SHIFT` + `<F11>`     | Debug step out                          |

**NOTE:** Only custom keymaps unique to this configuration are documented here. There are many more keymaps available by default in each installed plugin, in addition to the hundreds that come with Vim by default.

## Recommendations

### Fonts

In order for the **[Enfocado](https://wuelnerdotexe.github.io/enfocado)'s Human Writing** feature work as it should, I recommend that you use either of these three beautiful fonts, which align with the **"Mankind and Machine"** concept.

- [IBM Plex Mono](https://www.ibm.com/plex/).
- [Victor Mono](https://rubjo.github.io/victor-mono/).

### Docker

If you would like to test my configuration without overriting yours or simply run neovim with my configuration in a container now is possible.
You must have docker installed, and your user should be able to run docker without sudo command (withou this you may need to run your the following commands as sudo)
Run the command `make build` this will prepare everything for you, the first time you run this may take some moment to download the necessary files
from there you can just execute the file `wvim` this will mount the current directory and since it runs in a container will not have access to other folders.
Even changes done in the config directory in your machine will not affect the content of the container given that the containers during the build process created a copy of the configuration.
If you would like to continue using neovim in this way you can run `make install` which will create a symlink to your `~/.local/bin` directory which is expected to be part of your PATH if is not you should add it in your `.bashrc`, `.profile`, or `.zshrc` depending on your configuration
The way the container is run the contents of the folders `~/.config/nvim` and `~/.local/share/nvim` are persisted in volumes of docker, running the build again will clean these.

Note some errors are expected will be clear in the future but does not prevent the execution of neovim and my configuration.

## Maintainer

> Hi 👋, I'm **[Wuelner](https://linktr.ee/wuelnerdotexe)**, a **software developer from Guatemala**, passionate about creating minimalist solutions using solid fundamentals focused on **"how things should be"**.

## License

[GPL-3.0 &copy; Wuelner Martínez.](https://github.com/wuelnerdotexe/nvim/blob/main/LICENSE)

<p align="center">With 💖 from <strong>LATAM</strong> to the world!</p>
