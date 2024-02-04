-------------------------------------------------------------------------------
-- The initialization of my own colorscheme.
-------------------------------------------------------------------------------

local M = {}

function M.load()
  -- Ensure that we use true (24-bit) colors in the terminal.
  vim.opt.termguicolors = true

  -- The clearing only needs to be done when there is no colorscheme set.
  if vim.g.colors_name then
    vim.cmd "hi clear"
  end

  vim.g.colors_name = "s3rvac"

  require("s3rvac.colorscheme.theme").setup()
end

return M
