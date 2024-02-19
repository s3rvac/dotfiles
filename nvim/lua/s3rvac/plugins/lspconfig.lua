-- LSP-related configuration.
-- https://github.com/neovim/nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  tag = "v0.1.7",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local fns = require("s3rvac.functions")

    -- Used to enable autocompletion (assigned to every LSP server config).
    local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

    ------- Settings -------

    -- Add border around windows.
    require("lspconfig.ui.windows").default_options.border = "single"
    -- Add border to the documentation hover window (shown via lua
    -- vim.lsp.buf.hover()).
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
    })

    ------- Mappings -------

    local opts = { noremap = true, silent = true }

    -- Buffer-local mappings and settings that only work if there is an active
    -- language server.
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- Disable semantic (lsp) highlights.
      client.server_capabilities.semanticTokensProvider = nil

      opts.desc = "LSP: Jump to the definition of the symbol under cursor"
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "LSP: Jump to the declaration of the symbol under cursor"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "LSP: Show documentation for the symbol under cursor"
      vim.keymap.set("n", "<Leader>ll", vim.lsp.buf.hover, opts)

      opts.desc = "LSP: Show signature for the symbol under cursor"
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

      opts.desc = "LSP: Show references for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lr", "<cmd>FzfLua lsp_references<CR>", opts)

      opts.desc = "LSP: Show available code actions for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lc", vim.lsp.buf.code_action, opts)

      opts.desc = "LSP: Smart rename of the symbol under cursor"
      vim.keymap.set("n", "<Leader>lR", vim.lsp.buf.rename, opts)

      -- Unused mappings:

      -- opts.desc = "LSP: Show the signature of the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

      -- opts.desc = "LSP: Show definitions for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_definitions<CR>", opts)

      -- opts.desc = "LSP: Show type definitions for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_typedefs<CR>", opts)

      -- opts.desc = "LSP: Show declarations for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_definitions<CR>", opts)

      -- opts.desc = "LSP: Show implementations for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_implementations<CR>", opts)
    end

    ------ Language servers -------

    -- Note: I need to specify full paths to servers; otherwise, they fail to
    --       start (for no apparent reason). I am able to run them manually
    --       from Neovim without any issues.

    -- Bash
    local bashls = fns.mason_bin_path_to("bash-language-server")
    lspconfig["bashls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      autostart = fns.is_executable(bashls),
      cmd = { bashls, "start" },
      settings = {
        bashIde = {
          -- Disable shellcheck because it is already handled by nvim-lint.
          shellcheckPath = "",
        },
      },
    })

    -- Dockerfile
    local dockerls = fns.mason_bin_path_to("docker-langserver")
    lspconfig["dockerls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      autostart = fns.is_executable(dockerls),
      cmd = { dockerls, "--stdio" },
    })

    -- Lua
    local lua_ls = fns.mason_bin_path_to("lua-language-server")
    lspconfig["lua_ls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      autostart = fns.is_executable(lua_ls),
      cmd = { lua_ls },
      on_init = function(client)
        -- Use special configuration when editing Neovim's configuration files.
        -- Based on https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        local path = client.workspace_folders[1].name
        if path == vim.fn.stdpath("config") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              diagnostics = {
                -- Make the language server recognize Neovim's `vim` global.
                globals = { "vim" },
                -- Ignore noisy `missing-fields` warnings, e.g. when setting up nvim-treesitter's
                -- configuration ("Missing required fields in type `TSConfig`").
                -- https://github.com/LazyVim/LazyVim/issues/1471
                -- https://github.com/nvim-lua/kickstart.nvim/issues/543
                disable = { "missing-fields" },
              },
              -- Make the language server use the LuaJIT version of Lua.
              runtime = {
                version = "LuaJIT",
              },
              -- Make the language server aware of Neovim's runtime files.
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          })
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end,
    })

    -- Python
    local pyright = fns.mason_bin_path_to("pyright-langserver")
    lspconfig["pyright"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      autostart = fns.is_executable(pyright),
      cmd = { pyright, "--stdio" },
    })

    -- Python
    local terraformls = fns.mason_bin_path_to("terraform-ls")
    lspconfig["terraformls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      autostart = fns.is_executable(terraformls),
      cmd = { terraformls, "serve" },
    })

    -- YAML
    local yamlls = fns.mason_bin_path_to("yaml-language-server")
    lspconfig["yamlls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      autostart = fns.is_executable(yamlls),
      cmd = { yamlls, "--stdio" },
    })
  end,
}
