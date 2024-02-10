-- Identification and completion of Unicode characters.
-- https://github.com/chrisbra/unicode.vim
return {
  "chrisbra/unicode.vim",
  config = function()
    -- Use custom mappings.
    vim.g["g:Unicode_no_default_mappings"] = true

    -- Mappings.
    vim.keymap.set("i", "<C-x><C-u>", "<Plug>(UnicodeComplete)", {
      desc = "Completion of Unicode characters",
    })
  end
}
