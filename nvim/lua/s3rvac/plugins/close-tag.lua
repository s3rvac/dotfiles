-- Closing HTML/XML tags on demand.
-- https://github.com/airblade/vim-tag-closer
return {
  "airblade/vim-tag-closer",
  commit = "d812d765fef3caf5a4097dadf7c565e0a01a2f36", -- 2024-03-05
  ft = { "html", "xhtml", "xml" },
  init = function()
    -- Disable the default keymaps and use my own keymap.
    vim.g.tag_closer_enable_default_keymaps = 0
    vim.keymap.set("i", "<C-_>", "<C-O><Plug>(CloseTag)", { silent = true, desc = "Close tag" })
  end,
}
