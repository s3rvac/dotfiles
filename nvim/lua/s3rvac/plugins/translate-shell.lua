-- Translating text without leaving Vim.
-- Requires https://github.com/soimort/translate-shell to be installed.
-- https://github.com/echuraev/translate-shell.vim
return {
  "echuraev/translate-shell.vim",
  commit = "d72a2eabd2a5466369df794777e662ecc2d732e9", -- 2020-06-02
  event = "VeryLazy",
  config = function()
    -- Settings.
    vim.g.trans_win_height = 30

    -- Keymaps.
    local fns = require("s3rvac.functions")
    vim.keymap.set(
      { "n", "v" },
      "<Leader>trs",
      ":Trans<CR>",
      fns.keymap_opts({ desc = "Lookup the current English word" })
    )
    vim.keymap.set(
      { "n", "v" },
      "<Leader>trS",
      ":Trans en:cs<CR>",
      fns.keymap_opts({ desc = "Translate the current English word into Czech" })
    )
  end,
}
