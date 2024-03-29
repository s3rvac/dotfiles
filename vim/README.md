# Vim

My configuration files for the [Vim](http://www.vim.org/) editor.

> [!WARNING]
> In 2024, I switched to [Neovim](https://neovim.io/), so my Vim configuration is no longer actively maintained.

## Installation

* Copy `.vimrc` to `$HOME/`.
* Copy `.vim/colors/s3rvac.vim` to `$HOME/.vim/colors/`.
* Copy `.vim/snippets` to your [ultisnips](https://github.com/SirVer/ultisnips)
  directory.

## Plugins

I use the following Vim plugins, which you can install by using
[pathogen](https://github.com/tpope/vim-pathogen).

* General:
  * [AutoFenc](https://github.com/s3rvac/AutoFenc) - Automatically detects and sets file encoding when opening files.
  * [CSApprox](https://github.com/godlygeek/csapprox) - Makes GVim-only colorschemes work transparently in terminal Vim.
  * [Command-T](https://github.com/wincent/command-t) - Fast, intuitive mechanism for opening files.
  * [copilot-vim](https://github.com/github/copilot.vim) - Vim plugin for GitHub Copilot.
  * [matchit](http://www.vim.org/scripts/script.php?script_id=39) - Extends `%` matching for HTML, LaTeX, and many other languages.
  * [netrw](http://www.vim.org/scripts/script.php?script_id=1075) - Network oriented reading, writing, and browsing.
  * [Rename](http://www.vim.org/scripts/script.php?script_id=1928) - Easier renaming of files.
  * [ReplaceWithRegister](https://github.com/vim-scripts/ReplaceWithRegister) - Easy way of replacing text with the contents of a register.
  * [sessionman](http://www.vim.org/scripts/script.php?script_id=2010) - Session manager.
  * [targets.vim](https://github.com/wellle/targets.vim) - Additional text objects.
  * [tcomment_vim](https://github.com/tomtom/tcomment_vim) - Adds a motion to (un)comment lines.
  * [ultisnips](https://github.com/SirVer/ultisnips) - The ultimate snippet solution for Vim.
  * [vim-argwrap](https://github.com/FooSoft/vim-argwrap) - Wrap and unwrap function arguments, lists, and dictionaries.
  * [vim-bracketed-paste](https://github.com/ConradIrwin/vim-bracketed-paste) - Handles bracketed-paste-mode (aka automatic `:set paste`).
  * [vim-grepper](https://github.com/mhinz/vim-grepper) - A convenient wrapper around grepping facilities in Vim.
  * [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object) - Adds a text object representing lines with the same indent.
  * [vim-repeat](https://github.com/tpope/vim-repeat) - Enables repeating-supported plugin maps with `"."`.
  * [vim-sort-motion](https://github.com/christoomey/vim-sort-motion) - Adds a motion to sort text objects.
  * [vim-surround](https://github.com/tpope/vim-surround) - Quoting/parenthesizing made simple.

* Filetype:
  * [LaTeX Box](https://github.com/LaTeX-Box-Team/LaTeX-Box) - Lightweight Toolbox for LaTeX.
  * [rust.vim](https://github.com/rust-lang/rust.vim) - Vim configuration for Rust.
  * [vim-mail-refs](https://github.com/sopticek/vim-mail-refs) - Automatic insertion of URL references into mails.
  * [vim-puppet](https://github.com/rodjek/vim-puppet) - Formatting, syntax-highlighting etc. for Puppet.
  * [xmledit](https://github.com/sukima/xmledit) - Helps edit XML files.

* Syntax:
  * [dokuwiki](https://github.com/nblock/vim-dokuwiki)
  * [elixir](https://github.com/elixir-editors/vim-elixir)
  * [hive](https://github.com/autowitch/hive.vim)
  * [jinja2](https://github.com/Glench/Vim-Jinja2-Syntax)
  * [kotlin](https://github.com/udalov/kotlin-vim)
  * [llvm](https://llvm.org/svn/llvm-project/llvm/trunk/utils/vim/syntax/llvm.vim)
  * [markdown](https://github.com/plasticboy/vim-markdown)
  * [pgsql](https://github.com/lifepillar/pgsql.vim)
  * [python](https://github.com/hdima/python-syntax)
  * [rdoc](https://github.com/depuracao/vim-rdoc)
  * [redminewiki](https://github.com/s3rvac/vim-syntax-redminewiki)
  * [retdecdsm](https://github.com/s3rvac/vim-syntax-retdecdsm)
  * [terraform](https://github.com/hashivim/vim-terraform)
  * [yara](https://github.com/s3rvac/vim-syntax-yara)
