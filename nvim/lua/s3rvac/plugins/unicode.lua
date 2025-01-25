-- Identification and completion of Unicode characters.
-- https://github.com/chrisbra/unicode.vim
return {
  "chrisbra/unicode.vim",
  commit = "9da92ffe08b90200dcb499fdfecb234326f5514c", -- 2024-06-23
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
