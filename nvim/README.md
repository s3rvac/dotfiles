# Neovim

My configuration files for the [Neovim](https://neovim.io/) editor.

## Installation

* Create directory `$HOME/.config/nvim/` and copy all the files from the present directory in there.
* Install the following dependencies into your system:
  * [Neovim](https://neovim.io/) (obviously)
  * [ripgrep](https://github.com/BurntSushi/ripgrep) for grepping via the [fzf-lua](https://github.com/ibhagwan/fzf-lua) plugin.
  * [fd](https://github.com/sharkdp/fd) for finding files via the [fzf-lua](https://github.com/ibhagwan/fzf-lua) plugin.
* (Optional) Install [neovim-qt](https://github.com/equalsraf/neovim-qt) to have a GUI version of Neovim. With my configuration, it looks and behaves almost exactly like the terminal version of Neovim.
* (Optional) Place your local configuration into the `$HOME/.config/nvim/vimrc.local.vim` file. This file is sourced at the end of the `init.lua` file.

## Plugins

I manage plugins via the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. For a list of plugins that I use, see the [lua/s3rvac/plugins.lua](lua/s3rvac/plugins.lua) file.
