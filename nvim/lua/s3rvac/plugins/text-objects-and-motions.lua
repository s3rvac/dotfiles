-- Additional text objects, motions, or any related plugins.
return {
  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease.
  -- https://github.com/tpope/vim-surround
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  -- https://github.com/wellle/targets.vim
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },
  -- https://github.com/christoomey/vim-sort-motion
  {
    "christoomey/vim-sort-motion",
    event = "VeryLazy",
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
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
              -- "treesitter/query.lua:259: query: invalid node type at position 67 for language javascript"
              "javascript",
            },

            -- Automatically jump forward to the text object, similarly to
            -- targets.vim.
            lookahead = true,

            -- Any textobject is extended to include preceding or succeeding
            -- whitespace. Succeeding whitespace has priority in order to act
            -- similarly to e.g. the built-in `ap`.
            include_surrounding_whitespace = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
  -- https://github.com/chrisgrieser/nvim-various-textobjs
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    -- Use custom mappings.
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
