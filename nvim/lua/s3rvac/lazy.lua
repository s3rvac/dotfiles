-- Plugin management via the lazy.nvim plugin manager.
-- https://github.com/folke/lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end

-- Add lazy.nvim to the runtime path, which allows me to `require` it.
vim.opt.rtp:prepend(lazy_path)

-- Set up lazy.nvim and import+load all my plugins.
require("lazy").setup({
  { import = "s3rvac.plugins" },
}, {
  lockfile = vim.fn.stdpath("config") .. "/data/lazy-lock.json",
  -- Disable automatic detection of changes in files as they make editing of
  -- files in the plugins directory cumbersome.
  change_detection = { enabled = false },
  ui = {
    border = "single",
    icons = {
      -- Use a custom icon for the following items as the default ones are weird.
      ft = "",
    },
  },
})
