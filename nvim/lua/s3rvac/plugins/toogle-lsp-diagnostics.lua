-- Toggling LSP diagnostics.
-- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
return {
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
  commit = "afcacba44d86df4c3c9752b869e78eb838f55765", -- 2024-04-30
  event = "VeryLazy",
  config = function()
    require("toggle_lsp_diagnostics").init(vim.diagnostic.config())
    local fns = require("s3rvac.functions")

    -- Keymaps.
    vim.keymap.set(
      "n",
      "<Leader>dt",
      "<Plug>(toggle-lsp-diag)",
      fns.keymap_opts({ desc = "Toggle diagnostics (globally)" })
    )
  end,
}
