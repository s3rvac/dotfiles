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
      commit = "c1fbdcb0d8d1295314f1612c4a247253e70299d9", -- 2024-05-11
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

        -- Formatters.
        "clang-format",
        "jq",
        "ruff",
        "shfmt",
        "stylua",
        "usort",
        "yq",

        -- Linters.
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
