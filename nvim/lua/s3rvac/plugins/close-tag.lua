-- Closing HTML/XML tags on demand.
-- https://github.com/airblade/vim-tag-closer
return {
  "airblade/vim-tag-closer",
  commit = "2f33c8e92528d246d487cc81c8c8bddda6a61b39", -- 2022-05-06
  ft = { "html", "xhtml", "xml" },
  config = function()
    -- Disable the default keymaps (unfortunately, the plugin does not provide
    -- a way to disable the default keymaps).
    vim.cmd("nunmap g/")
    vim.cmd("iunmap <C-G>/")

    -- Use my own keymap.
    vim.keymap.set("i", "<C-_>", "<C-O><Plug>(CloseTag)", { silent = true, desc = "Close tag" })
  end,
}
