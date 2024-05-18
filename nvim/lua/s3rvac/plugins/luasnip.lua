-- Snippets.
-- https://github.com/L3MON4D3/LuaSnip
return {
  "L3MON4D3/LuaSnip",
  tag = "v2.3.0", -- 20204-16
  event = "BufEnter",
  config = function()
    local luasnip = require("luasnip")
    local fns = require("s3rvac.functions")

    -- Keymaps.
    vim.keymap.set(
      { "i", "s" },
      "<Tab>",
      function()
        -- When I am at the beginning of a line (or there is only whitespace
        -- before the cursor), always insert a tab. This prevents annoying
        -- behavior when I try to indent and the cursor jumps around.
        local _, col = unpack(vim.api.nvim_win_get_cursor(0))
        local prefix = string.sub(vim.api.nvim_get_current_line(), 0, col)
        if string.match(prefix, "^%s*$") then
          return "<Tab>"
        elseif luasnip.expand_or_jumpable() then
          return "<Plug>luasnip-expand-or-jump"
        else
          return "<Tab>"
        end
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
