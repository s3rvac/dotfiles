-- Plugin management via the lazy.nvim plugin manager.
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
