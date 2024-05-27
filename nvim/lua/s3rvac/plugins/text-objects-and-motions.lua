-- Additional text objects, motions, or any related plugins.
return {
  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease.
  -- https://github.com/tpope/vim-surround
  {
    "tpope/vim-surround",
    commit = "3d188ed2113431cf8dac77be61b842acb64433d9", -- 2022-10-25
    event = "VeryLazy",
  },
  -- https://github.com/wellle/targets.vim
  {
    "wellle/targets.vim",
    commit = "642d3a4ce306264b05ea3219920b13ea80931767", -- 2023-02-22
    event = "VeryLazy",
    init = function()
      -- When seeking, prefer multiline targets around the cursor over distant
      -- targets within the cursor line. This works better than the default
      -- setting when e.g. doing ci{ inside of a block on a line that also
      -- contains curly brackets (the expected behavior is to change the block,
      -- not seek to the curly brackets on the current line).
      vim.g.targets_seekRanges =
        "cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA"

      -- Switch `b` back to the Neovim default, i.e. it will always select parentheses
      -- and never any other pair, such as curly or square braces.
      vim.cmd([[
        autocmd User targets#mappings#user call targets#mappings#extend({
          \ 'b': {'pair': [{'o':'(', 'c':')'}]}
          \ })
      ]])
    end,
  },
  -- https://github.com/christoomey/vim-sort-motion
  {
    "christoomey/vim-sort-motion",
    commit = "c8782be8f7da414c6442b3ba4b6abb0345d392d9", -- 2021-03-07
    event = "VeryLazy",
    init = function()
      -- Remove duplicates while sorting.
      vim.g.sort_motion_flags = "u"
    end,
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "5f9bf4b1ead7707e4e74e5319ee56bdc81fb73db", -- 2024-05-18
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            disable = {
              -- Disable JS for now as opening a .js file results in the following error:
              -- treesitter/query.lua:259: query: invalid node type at position 67 for language javascript
              "javascript",
              -- Disable Haskell for now as opening a .hs file results in the following error:
              -- treesitter/query.lua:252: Query error at 1:3. Invalid node type "apply":
              "haskell",
            },

            -- Automatically jump forward to the text object, similarly to
            -- targets.vim.
            lookahead = true,

            -- Any textobject is extended to include preceding or succeeding
            -- whitespace. Succeeding whitespace has priority in order to act
            -- similarly to e.g. the built-in `ap`.
            include_surrounding_whitespace = true,

            keymaps = {
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
        },
      })
    end,
  },
  -- https://github.com/chrisgrieser/nvim-various-textobjs
  {
    "chrisgrieser/nvim-various-textobjs",
    commit = "ae64795ff81017c8e572051fd728051176d6ecc5", -- 2024-05-18
    event = "VeryLazy",
    -- Use custom keymaps.
    opts = { useDefaultKeymaps = false },
    config = function()
      -- Identation (a replacement for https://github.com/michaeljsmith/vim-indent-object).
      vim.keymap.set(
        { "o", "x" },
        "ii",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>"
      )
      vim.keymap.set(
        { "o", "x" },
        "ai",
        "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>"
      )
      vim.keymap.set(
        { "o", "x" },
        "iI",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>"
      )
      vim.keymap.set(
        { "o", "x" },
        "aI",
        "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>"
      )

      -- The entire file (buffer).
      vim.keymap.set({ "o", "x" }, "aF", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

      -- URL.
      vim.keymap.set({ "o", "x" }, "aU", "<cmd>lua require('various-textobjs').url()<CR>")

      -- Markdown links (il, al).
      -- Defined in lua/s3rvac/config/autocommands.lua as this is a
      -- filetype-specific text object.
    end,
  },
}
