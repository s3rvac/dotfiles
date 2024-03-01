-- Toggling LSP diagnostics.
-- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
return {
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
  commit = "4fbfb51e3902d17613be0bc03035ce26b9a8d05d", -- 2023-10-10
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
