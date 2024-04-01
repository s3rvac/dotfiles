-- Closing HTML/XML tags on demand.
-- https://github.com/airblade/vim-tag-closer
return {
  -- Use my fork of the plugin that uses insert instead of append to insert the
  -- closing tag.
  "s3rvac/vim-tag-closer",
  branch = "insert-instead-of-append",
  ft = { "html", "xhtml", "xml" },
  init = function()
    -- Disable the default keymaps and use my own keymap.
    vim.g.tag_closer_enable_default_keymaps = 0
    vim.keymap.set("i", "<C-_>", "<C-O><Plug>(CloseTag)", { silent = true, desc = "Close tag" })
  end,
}
