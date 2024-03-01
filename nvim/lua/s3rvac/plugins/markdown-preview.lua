-- Markdown previwer.
-- https://github.com/iamcco/markdown-preview.nvim
return {
  "iamcco/markdown-preview.nvim",
  commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee", -- 2023-10-17
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  key = { "<Leader>mp" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    -- Settings.

    -- Reuse previously opened preview window when previewing a markdown file
    -- and automatically refetch preview contents when changing a buffer.
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview_auto_refresh = 1
    vim.g.mkdp_auto_close = 0

    -- Custom page title.
    vim.g.mkdp_page_title = 'Markdown: ${name}'

    -- Keymaps.
    local fns = require("s3rvac.functions")
    vim.keymap.set(
      "n",
      "<Leader>mp",
      ":MarkdownPreview<CR>",
      fns.keymap_opts({ desc = "Preview the currently open markdown file in a browser" })
    )
  end
}
