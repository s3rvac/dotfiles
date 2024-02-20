local fns = require("s3rvac.functions")

-------------------------------------------------------------------------------
-- Lua
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeLua", {})

-- Indent style.
--
-- Use tabs by default, but use 2 spaces when editing Neovim's configuration.
--
-- References:
-- - https://roblox.github.io/lua-style-guide/
-- - https://www.mediawiki.org/wiki/Manual:Coding_conventions/Lua
-- - Neovim's source code and other configs/plugins.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeLua",
  pattern = "lua",
  callback = fns.set_indent_style_to_tabs,
  desc = "FileType lua: Indent style - default",
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = "FileTypeLua",
  pattern = vim.fn.stdpath("config") .. "/*.lua",
  callback = fns.set_indent_style_to_2_spaces,
  desc = "FileType lua: Indent style - Neovim's config",
})
