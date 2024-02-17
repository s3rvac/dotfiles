-- Load all Lua files in the present directory.
local curr_dir = vim.fn.stdpath("config") .. "/lua/s3rvac/config"
for _, file in ipairs(vim.fn.readdir(curr_dir, [[v:val =~ "\.lua$"]])) do
  if file ~= "init.lua" then
    require("s3rvac.config." .. file:gsub("%.lua$", ""))
  end
end
