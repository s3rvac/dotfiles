-- Force Neovim to always use the system version of Python. Otherwise, when
-- opening Neovim from within a virtual environment (e.g. Python's venv),
-- Python plugins in Neovim would complain that `pynvim` is not installed.
vim.g.python3_host_prog = "/usr/bin/python3"
