-- My own colorscheme.
require("s3rvac.colorscheme")

-- Global configuration.
require("s3rvac.config")

-- Local configuration (optional).
local local_config = vim.fn.stdpath("config") .. "/lua/s3rvac/config-local.lua"
if vim.loop.fs_stat(local_config) then
  require("s3rvac.config-local")
end

-- Plugin management via lazy.nvim.
-- Loaded last to make lazy-loading based on keys work when using <Leader> keys
-- (I use a custom leader, which is defined in s3rvac.config.keymaps).
require("s3rvac.lazy")
