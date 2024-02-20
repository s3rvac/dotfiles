-- Management of external tooling, such as LSP servers.
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
return {
  "williamboman/mason.nvim",
  tag = "v1.10.0",
  event = "VeryLazy",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", tag = "v1.26.0" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Enable and configure mason.
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Enable and configure mason-lspconfig.
    mason_lspconfig.setup()

    -- LSP servers, formatters, and linters to install via :MasonToolsInstall.
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- LSP servers.
        "bash-language-server",
        "clangd",
        "dockerfile-language-server",
        "lua_ls",
        "pyright",
        "terraformls",
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
      },

      -- Do not run :MasonToolsInstall on startup (I prefer to run it manually).
      run_on_start = false,
    })
  end,
}
