-- Identification and completion of Unicode characters.
-- https://github.com/chrisbra/unicode.vim
return {
  "chrisbra/unicode.vim",
  commit = "bc20d0fb3331a7b41708388c56bb8221c2104da7", -- 2023-09-20
  config = function()
    -- Use custom mappings.
    vim.g.Unicode_no_default_mappings = true

    -- Mappings.
    vim.keymap.set("i", "<C-x><C-u>", "<Plug>(UnicodeComplete)", {
      desc = "Completion of Unicode characters",
    })
  end,
}
