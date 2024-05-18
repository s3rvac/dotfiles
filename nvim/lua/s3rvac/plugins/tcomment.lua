-- Quick commenting and uncommenting of code.
-- https://github.com/tomtom/tcomment_vim
return {
  "tomtom/tcomment_vim",
  commit = "48ab639a461d9b8344f7fee06cb69b4374863b13", -- 2024-03-25
  event = "VeryLazy",
  init = function()
    -- Disable leader commands as I do not use them.
    vim.g.tcomment_mapleader1 = ""
    vim.g.tcomment_mapleader2 = ""

    -- Do not comment blank lines.
    vim.g["tcomment#blank_lines"] = 0
  end,
}
