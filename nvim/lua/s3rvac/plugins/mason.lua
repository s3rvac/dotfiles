-- Management of external tooling, such as LSP servers.
-- https://github.com/williamboman/mason.nvim
return {
  "williamboman/mason.nvim",
  tag = "v1.10.0", -- 2024-01-29
  event = "VeryLazy",
  dependencies = {
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      commit = "1212fb6082b7177dde17ea65e429e027835aeb40", -- 2023-02-14
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
        "cssls",
        "dockerfile-language-server",
        "html-lsp",
        "kotlin-language-server",
        "lua_ls",
        "pyright",
        "rust-analyzer",
        "terraformls",
        "vim-language-server",
        "yaml-language-server",

        -- Formatters.
        "clang-format",
        "jq",
        "ruff",
        "shfmt",
        "stylua",
        "yq",

        -- Linters.
        "luacheck",
        "ruff",
        "shellcheck",
        "tflint",
        "yamllint",
      },

      -- Do not run :MasonToolsInstall on startup (I prefer to run it manually).
      run_on_start = false,
    })
  end,
}
