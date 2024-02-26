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

-------------------------------------------------------------------------------
-- Markdown
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeMarkdown", {})

-- Text object: markdown link (using nvim-various-textobjs).
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set(
      { "o", "x" },
      "il",
      "<cmd>lua require('various-textobjs').mdlink('inner')<CR>",
      { buffer = true }
    )
    vim.keymap.set(
      { "o", "x" },
      "al",
      "<cmd>lua require('various-textobjs').mdlink('outer')<CR>",
      { buffer = true }
    )
  end,
  desc = "nvim-various-textobjs: Markdown links",
})

-------------------------------------------------------------------------------
-- PHP
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypePHP", {})

-- Make <Leader>man open PHP documentation for the symbol under the cursor.
fns.create_man_cmd_and_ft_autocmd_for_opening_docs(
  "FileTypePHP",
  "php",
  "https://php.net/"
)

-------------------------------------------------------------------------------
-- Python
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypePython", {})

-- Make <Leader>man open Python documentation for the symbol under the cursor.
fns.create_man_cmd_and_ft_autocmd_for_opening_docs(
  "FileTypePython",
  "python",
  "https://docs.python.org/3/search.html?q="
)
