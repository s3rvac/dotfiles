Tmux
====

My configuration file for the [tmux](http://tmux.sourceforge.net/) terminal
multiplexer.

Installation
------------

* Copy `.tmux.conf` to `$HOME/`.

Plugins
-------

I use the following plugins:

* [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) - Enhances tmux
  searches by allowing regex searches and providing various pre-defined
  searches (files, URLs, SHA1 hashes etc.).
* [tmux-open](https://github.com/tmux-plugins/tmux-open) - Allows you to open
  highlighted selection directly from tmux copy mode, like opening links in a
  browser.

To install the plugins, either put them into the `~/.tmux/plugins/` directory
and use the `run-shell` commands from the end of my configuration file, or use
the [tmux plugin manager](https://github.com/tmux-plugins/tpm).
