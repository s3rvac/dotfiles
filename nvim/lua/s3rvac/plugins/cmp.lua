-- A completion plugin.
-- https://github.com/hrsh7th/nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- For completion of text in a buffer.
    "hrsh7th/cmp-buffer",
    -- For completion of file paths.
    "hrsh7th/cmp-path",
    -- For LSP completion.
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
        -- I want to trigger regular autocompletion manually.
        autocomplete = false,
      },
      formatting = {
        -- Include the source of each item in the menu
        format = function(entry, vim_item)
          vim_item.menu = ({
            buffer = "[Buffer]",
            path = "[Path]",
            nvim_lsp = "[LSP]",
          })[entry.source.name]
          return vim_item
        end
      },
      mapping = cmp.mapping.preset.insert({
        -- Enable Omni completion triggered by <C-x><C-o>.
        ["<C-x><C-o>"] = cmp.mapping(function()
            cmp.complete()
          end
        ),

        -- Initating the completion and scrolling the items.
        ["<C-j>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({behavior = "insert"})
            else
              cmp.complete()
            end
          end
        ),
        ["<C-k>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item({behavior = "insert"})
            else
              cmp.complete()
            end
          end
        ),

        -- Scrolling the preview window.
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Preserve the original mapping of <C-p>/<C-n> (I need those to be
        -- fast and complete just text) but allow those to be used when cmp is
        -- visible.
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(select_opts)
            else
              fallback()
            end
          end, {"i", "s"}
        ),
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item(select_opts)
            else
              fallback()
            end
          end, {"i", "s"}
        ),

        -- Safely select entries with <CR>.
        -- * If nothing is selected (including preselections), add a newline as usual.
        -- * If something has explicitly been selected, select it.
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
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        {
          name = "path",
          option = {
            -- When autocompleting a directory, include the trailing slash as
            -- this is what Neovim's path completion does.
            trailing_slash = true,
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
        }
      },
    })
  end,
}
