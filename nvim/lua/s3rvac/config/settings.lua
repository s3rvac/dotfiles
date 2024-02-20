-- Enable project-local configuration by automatically executing .nvim.lua,
-- .nvimrc, and .exrc files in the current directory if the file is in the
-- trust list.
vim.opt.exrc = true

-- Force Neovim to always use the system version of Python. Otherwise, when
-- opening Neovim from within a virtual environment (e.g. Python's venv),
-- Python plugins in Neovim would complain that `pynvim` is not installed.
vim.g.python3_host_prog = "/usr/bin/python3"
