-- Toggling LSP diagnostics.
-- WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
return {
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
  event = "VeryLazy",
  config = function()
    require('toggle_lsp_diagnostics').init(vim.diagnostic.config())

    -- Mappings.
    local opts = { noremap = true, silent = true }

    opts.desc = "Toggle virtual windows for diagnostics (globally)"
    vim.keymap.set("n", "<Leader>dv", "<Plug>(toggle-lsp-diag-vtext)", opts)
  end
}
