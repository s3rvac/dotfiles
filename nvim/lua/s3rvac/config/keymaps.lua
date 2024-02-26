-- Mappings, commands, abbreviations, etc.

local fns = require("s3rvac.functions")
local opts = fns.keymap_opts

------- Location list -------

vim.keymap.set(
  "n",
  "[l",
  "<cmd>lprevious<cr>",
  opts({ desc = "Previous location list item" })
)
vim.keymap.set(
  "n",
  "[l",
  "<cmd>lnext<cr>",
  opts({ desc = "Next location list item" })
)

------- Quickfix list -------

vim.keymap.set(
  "n",
  "[q",
  "<cmd>cprevious<cr>",
  opts({ desc = "Previous quickfix list item" })
)
vim.keymap.set(
  "n",
  "[q",
  "<cmd>cnext<cr>",
  opts({ desc = "Next quickfix list item" })
)

------- Diagnostics -------

vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  opts({ desc = "Go to the previous diagnostic" })
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  opts({ desc = "Go to the next diagnostic" })
)
vim.keymap.set(
  "n",
  "<Leader>df",
  vim.diagnostic.open_float,
  opts({ desc = "Open line diagnostics" })
)
vim.keymap.set(
  "n",
  "<Leader>dl",
  "<cmd>FzfLua diagnostics_document<CR>",
  opts({ desc = "List all diagnostics from the current buffer" })
)

------- Other -------

vim.keymap.set("n", "<Leader>sis", fns.select_indent_style, opts({ desc = "Select indent style" }))
