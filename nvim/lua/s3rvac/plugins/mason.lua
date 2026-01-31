-- Management of external tooling, such as LSP servers.
-- https://github.com/williamboman/mason.nvim
return {
  "williamboman/mason.nvim",
  tag = "v2.2.1", -- 2026-01-07
  event = "VeryLazy",
  dependencies = {
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      commit = "443f1ef8b5e6bf47045cb2217b6f748a223cf7dc", -- 2026-01-22
    },
  },
  config = function()
    local mason = require("mason")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- LSP servers, formatters, and linters to install via :MasonToolsInstall.
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- LSP servers.
        "bash-language-server",
        "clangd",
        "css-lsp",
        "dockerfile-language-server",
        "gopls",
        "html-lsp",
        "kotlin-language-server",
        "lua-language-server",
        "pyright",
        "terraform-ls",
        "vim-language-server",
        "yaml-language-server",
        -- Via system-wide installations:
        -- * haskell-language-server

        -- Formatters.
        "clang-format",
        "jq",
        "ruff",
        "shfmt",
        "stylua",
        "usort",
        "yq",
        -- Via system-wide installations:
        -- * fourmolu (haskell)

        -- Linters.
        "hlint",
        "luacheck",
        "ruff",
        "shellcheck",
        "tflint",
        "yamllint",
      },

      -- Do not run :MasonToolsInstall on startup. I prefer to run it manually
      -- and only on machines that have all the necessary dependencies
      -- installed, such as npm.
      run_on_start = false,
    })
  end,
}
