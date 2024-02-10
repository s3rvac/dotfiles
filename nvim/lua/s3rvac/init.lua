-- My own colorscheme.
require("s3rvac.colorscheme")

-- Plugin management via lazy.nvim.
require("s3rvac.lazy")

-- Global configuration.
require("s3rvac.config")

-- Local configuration (optional).
local local_config = vim.fn.stdpath("config") .. "/lua/s3rvac/config-local.lua"
if vim.loop.fs_stat(local_config) then
  require("s3rvac.config-local")
end
