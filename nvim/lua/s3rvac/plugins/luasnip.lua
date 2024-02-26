-- Snippets.
-- https://github.com/L3MON4D3/LuaSnip
return {
  "L3MON4D3/LuaSnip",
  tag = "v2.2.0", -- 2023-12-31
  event = "BufEnter",
  config = function()
    local luasnip = require("luasnip")
    local fns = require("s3rvac.functions")

    -- Keymaps.
    vim.keymap.set(
      { "i", "s" },
      "<Tab>",
      function()
        return luasnip.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
      end,
      fns.keymap_opts({
        desc = "Expand a snippet / jump forward / insert a tab",
        expr = true,
      })
    )
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      luasnip.jump(-1)
    end, fns.keymap_opts({ desc = "Jump backward in a snippet" }))
    vim.keymap.set({ "n" }, "<Leader>sni", function()
      vim.cmd(
        ":execute 'tabe "
          .. vim.fn.stdpath("config")
          .. "/snippets/"
          .. vim.bo.filetype
          .. ".snippets'"
      )
    end, fns.keymap_opts({ desc = "Edit snippets for the current filetype" }))

    -- Load SnipMate-like snippets from the .config/nvim/snippets directory.
    require("luasnip.loaders.from_snipmate").lazy_load()
  end,
}
