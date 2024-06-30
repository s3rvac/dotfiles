# Bash

My configuration files for the [bash](http://www.gnu.org/software/bash/) shell.

## Installation

* Copy all the files to `$HOME/`.
* Install [Git completion](https://github.com/git/git/blob/master/contrib/completion/git-completion.bash) by downloading the shell script into `$HOME/.git-completion.bash`.
* Install [Tmuxinator completion](https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.bash) by downloading the shell script into `$HOME/.tmuxinator-completion.bash`.
* Install [kubectl](https://github.com/kubernetes/kubectl) completion by running `kubectl completion bash > $HOME/.kubectl-completion.bash`.
* Install [fzf](https://github.com/junegunn/fzf) by following [these instructions](https://github.com/junegunn/fzf?tab=readme-ov-file#installation), including key bindings and completion. My configuration expects the key bindings and completion to be in the `$HOME/.fzf` directory.
* Install the following optional dependencies:
    * [bat](https://github.com/sharkdp/bat) for syntax highlighting in the preview window of fzf.
    * [fd](https://github.com/sharkdp/fd) for faster listing of files and directories in fzf.
* Optionally, install the [scripts](../scripts).
