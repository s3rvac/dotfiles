-- Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "d3218d988f72ed34414959c9ccd802d393432d6e", -- 2025-12-13
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "bash",
          "bibtex",
          "c",
          "cmake",
          "cpp",
          "css",
          "csv",
          "diff",
          "dockerfile",
          "doxygen",
          "elixir",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "haskell",
          "hcl",
          "hocon",
          "html",
          "java",
          "javascript",
          "json",
          "kotlin",
          "latex",
          "llvm",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "php",
          "proto",
          "puppet",
          "python",
          "regex",
          "rst",
          "ruby",
          "rust",
          "scala",
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
          -- Disable treesitter highlighting for some file types as the
          -- original, non-treesitter, regex-based version looks better, at
          -- least at the moment.
          disable = vim.g.s3rvac_disable_treesitter_highlight_for_filetypes,

          -- Do not combine Vim's regex-based highlighting with
          -- Treesitter's highlighting.
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = false,
        },
        indent = {
          enable = false,
        },
      })

      -- Custom mapping of filetypes to parsers.
      vim.treesitter.language.register("html", { "xhtml" })

      -- Disable asynchronous parsing for now as it causes glitches on Neovim
      -- 0.11.1. For example, when opening ~/.bashrc, there is a noticeable lag
      -- before the highlighting is applied. Similarly when doing `:w`.
      --
      -- Potentially related issues/PRs:
      -- - https://github.com/neovim/neovim/issues/32660
      -- - https://github.com/neovim/neovim/issues/33139
      -- - https://github.com/neovim/neovim/pull/33145
      vim.g._ts_force_sync_parsing = true
    end,
  },
}
