-- Toggling LSP diagnostics.
-- WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
return {
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
  event = "VeryLazy",
  config = function()
    require("toggle_lsp_diagnostics").init(vim.diagnostic.config())
    local fns = require("s3rvac.functions")

    -- Mappings.
    vim.keymap.set(
      "n",
      "<Leader>dt",
      "<Plug>(toggle-lsp-diag)",
      fns.keymap_opts({ desc = "Toggle diagnostics (globally)" })
    )
  end,
}
