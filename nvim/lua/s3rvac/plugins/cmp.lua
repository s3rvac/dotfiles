-- A completion plugin.
-- https://github.com/hrsh7th/nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  commit = "da88697d7f45d16852c6b2769dc52387d1ddc45f", -- 2026-01-26
  event = "InsertEnter",
  dependencies = {
    -- For completion of text in a buffer.
    -- https://github.com/hrsh7th/cmp-buffer
    {
      "hrsh7th/cmp-buffer",
      commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657", -- 2025-04-01
    },
    -- For LSP completion.
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "cbc7b02bb99fae35cb42f514762b89b5126651ef", -- 2025-11-13
    },
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noselect,preview",
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

        -- Cycling through completion items.
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),

        -- Scrolling the preview window.
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Abort completion and close the completion menu.
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
      }),
      -- Prevent language servers from preselecting items in the completion
      -- menu as I want to have full control over the selection. For example,
      -- without this, rust-analyzer pre-selects the first item in the
      -- completion menu, which I dislike.
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, _)
            -- Do not complete certain kinds that I do not want to be
            -- completed.
            local kind = entry:get_kind()
            return kind ~= cmp.lsp.CompletionItemKind.Snippet
              and kind ~= cmp.lsp.CompletionItemKind.Text
          end,
        },
        {
          name = "buffer",
          option = {
            -- Use a custom keyword pattern to make cmp-buffer complete Unicode
            -- word characters, e.g. "ko" will include "kočička" in the completion
            -- menu. To explain the pattern, \k matches Neovim's 'iskeyword'.
            -- https://github.com/hrsh7th/nvim-cmp/issues/453
            --
            -- Note: I use a custom 'iskeyword' setting to include '-', which
            -- makes hyphenated words part of the completion menu. This is very
            -- useful, at least for me.
            keyword_pattern = [[\k\+]],
            -- Complete from all buffers, including the hidden ones.
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
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
