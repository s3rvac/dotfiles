-- Management of external tooling, such as LSP servers.
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
return {
  "williamboman/mason.nvim",
  tag = "v1.10.0",
  event = "VeryLazy",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", tag = "v1.26.0" },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Enable and configure Mason.
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Enable and configure the installation of LSP servers.
    mason_lspconfig.setup({
      -- Disable automatic installation of servers. Reason: I prefer to install
      -- those manually as I use Neovim on many machines and not all of those
      -- are capable of running all servers.
      automatic_installation = false,
    })
  end
}
