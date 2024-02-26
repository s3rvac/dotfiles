-- A completion plugin.
-- https://github.com/hrsh7th/nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  commit = "04e0ca376d6abdbfc8b52180f8ea236cbfddf782", -- 2024-02-02
  event = "InsertEnter",
  dependencies = {
    -- For completion of text in a buffer.
    -- https://github.com/hrsh7th/cmp-buffer
    {
      "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa", -- 2022-08-10
    },
    -- For LSP completion.
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "5af77f54de1b16c34b23cba810150689a3a90312", -- 2023-12-10
    },
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
        -- I want to trigger regular autocompletion manually.
        autocomplete = false,
        -- Minimum number of characters to trigger completion (only used when
        -- autocomplete is true).
        keyword_length = 2,
      },
      formatting = {
        -- Include the source of each item in the menu
        format = function(entry, vim_item)
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
          })[entry.source.name]
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- Enable Omni completion triggered by <C-x><C-o>.
        ["<C-x><C-o>"] = cmp.mapping(function()
          cmp.complete()
        end),

        -- Initating the completion and scrolling through the items.
        -- Note: I use <C-k> in insert mode to show the signature of the
        --       current function, which is why there is `fallback()` instead
        --       of `cmp.complete()`.
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = "insert" })
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = "insert" })
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Scrolling the preview window.
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Preserve the original mapping of <C-p>/<C-n> (I need those to be
        -- fast and complete just buffer text) but allow those to be used when
        -- cmp is visible.
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = "insert" })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = "insert" })
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Safely select entries with <CR>.
        -- - If nothing is selected (including preselections), add a newline as usual.
        -- - If something has explicitly been selected, select it.
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
      }),
      window = {
        completion = {
          border = "none",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
        documentation = {
          border = "single",
        },
      },
    })
  end,
}
