-- Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "csv",
          "diff",
          "dockerfile",
          "doxygen",
          "gitignore",
          "go",
          "haskell",
          "html",
          "java",
          "javascript",
          "json",
          "kotlin",
          "latex",
          "llvm",
          "lua",
          "markdown",
          "markdown_inline",
          "php",
          "proto",
          "python",
          "ruby",
          "rust",
          "sql",
          "terraform",
          "toml",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        sync_install = false,
        highlight = {
          enable = true,
          -- Disable treesitter highlighting for the following file types
          -- as the original, non-treesitter, regex-based version looks
          -- better, at least at the moment.
          --
          -- Note: When you update this list, update the list in
          -- lua/s3rvac/plugins/fzf.lua as well.
          disable = {
            "diff",
            "gitcommit",
            "kotlin",
            "python",
            "terraform",
            "toml",
            "yaml",
          },

          -- Do not combine Vim's regex-based highlighting with
          -- Treesitter's highlighting.
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = false,
        },
        indent = {
          enable = false
        },
      })
    end
  },
}
