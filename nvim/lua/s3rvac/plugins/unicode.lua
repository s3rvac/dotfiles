-- Identification and completion of Unicode characters.
-- https://github.com/chrisbra/unicode.vim
return {
  "chrisbra/unicode.vim",
  commit = "902cd2b0a41a38528d080f8dd7a16ec5a865ebdd", -- 2025-09-22
  event = "VeryLazy",
  init = function()
    -- Use custom keymaps.
    vim.g.Unicode_no_default_mappings = true

    -- Keymaps.
    vim.keymap.set("i", "<C-x><C-u>", "<Plug>(UnicodeComplete)", {
      desc = "Completion of Unicode characters",
    })
  end,
}
