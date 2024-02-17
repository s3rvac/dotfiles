-- My global vimrc (not everything that I have right now is configured via Lua).
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- My local vimrc.
local vimrc_local = vim.fn.stdpath("config") .. "/vimrc-local.vim"
if vim.loop.fs_stat(vimrc_local) then
  vim.cmd.source(vimrc_local)
end

-- My Lua configuration.
require("s3rvac")
