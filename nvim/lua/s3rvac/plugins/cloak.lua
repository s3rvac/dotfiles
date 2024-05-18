-- Overlays *'s over defined patterns in defined files + disables nvim-cmp in
-- those files.
-- https://github.com/laytan/cloak.nvim
return {
  "laytan/cloak.nvim",
  commit = "6e5bcd50bebc5cdb7cd3a00eb3d97ab7c4cc3b94", -- 2024-03-23
  config = function()
    local fns = require("s3rvac.functions")

    local cloak = require("cloak")
    cloak.setup({
      -- Hide the true length of the cloaked text.
      cloak_length = 20,
      -- Stop after the first pattern match.
      try_all_patterns = false,
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
        },
        {
          file_pattern = "*/.kube/config",
          cloak_pattern = { "(password: ).+", replace = "%1" },
        },
        {
          file_pattern = "pw.*",
          cloak_pattern = {
            { "(codes?: ).+", replace = "%1" },
            { "(keys?: ).+", replace = "%1" },
            { "(pins?: ).+", replace = "%1" },
            { "(secrets?: ).+", replace = "%1" },
            { "(pw: ).+", replace = "%1" },
          },
        },
      },
    })

    vim.keymap.set("n", "<Leader>ct", function()
      cloak.toggle()
    end, fns.keymap_opts({ desc = "Toggle cloak.nvim" }))
  end,
}
