-- LSP-related configuration.
-- https://github.com/neovim/nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  tag = "v0.1.7",
  dependencies = {
    -- LSP completion for nvim-cmp.
    "hrsh7th/cmp-nvim-lsp",
    -- Better development experience for Neovim configuration and plugins.
    -- https://github.com/folke/neodev.nvim
    {
      "folke/neodev.nvim",
      tag = "v2.5.2", -- 2023-03-24
    },
    -- Incremental LSP renaming.
    -- https://github.com/smjonas/inc-rename.nvim
    {
      "smjonas/inc-rename.nvim",
      commit = "6f9b5f9cb237e12935144cdc535322b8c93c1b25", -- 2023-12-28
    },
  },
  config = function()
    -- Important: Make sure to set up neodev before lspconfig.
    require("neodev").setup()
    require("inc_rename").setup()

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
    -- Add border to the signature-help hover window (shown via lua
    -- vim.lsp.buf.signature_help()).
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
    })

    ------- Keymaps -------

    local opts = { noremap = true, silent = true }

    -- Buffer-local keymaps and settings that only work if there is an active
    -- language server.
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "LSP: Jump to the definition of the symbol under cursor"
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "LSP: Jump to the declaration of the symbol under cursor"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "LSP: Show documentation for the symbol under cursor"
      vim.keymap.set("n", "<Leader>ll", vim.lsp.buf.hover, opts)

      opts.desc = "LSP: Show signature for the current function call"
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

      opts.desc = "LSP: Show references for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lr", "<cmd>FzfLua lsp_references<CR>", opts)

      opts.desc = "LSP: Show available code actions for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lc", vim.lsp.buf.code_action, opts)

      opts.desc = "LSP: Smart rename of the symbol under cursor (no prefill)"
      vim.keymap.set("n", "<Leader>rC", ":IncRename ", opts)

      opts.desc = "LSP: Smart rename of the symbol under cursor (prefill cword)"
      vim.keymap.set("n", "<leader>cC", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, fns.unpack(opts) })

      -- Unused keymaps:

      -- opts.desc = "LSP: Show definitions for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_definitions<CR>", opts)

      -- opts.desc = "LSP: Show type definitions for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_typedefs<CR>", opts)

      -- opts.desc = "LSP: Show declarations for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_definitions<CR>", opts)

      -- opts.desc = "LSP: Show implementations for the symbol under cursor"
      -- vim.keymap.set("n", "xxx", "<cmd>FzfLua lsp_implementations<CR>", opts)
    end

    local on_init = function(_, _)
      -- No need to do anything special here for now.
      return true
    end

    ------ Language servers -------

    -- Note: I need to specify full paths to servers; otherwise, they fail to
    --       start (for no apparent reason). I am able to run them manually
    --       from Neovim without any issues.

    -- C, C++
    local clangd = fns.mason_bin_path_to("clangd")
    lspconfig["clangd"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(clangd),
      cmd = { clangd },
    })

    -- Bash
    local bashls = fns.mason_bin_path_to("bash-language-server")
    lspconfig["bashls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(bashls),
      cmd = { bashls, "start" },
      settings = {
        bashIde = {
          -- Disable shellcheck because it is already handled by nvim-lint.
          shellcheckPath = "",
        },
      },
    })

    -- CSS
    local cssls = fns.mason_bin_path_to("vscode-css-language-server")
    lspconfig["cssls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(cssls),
      cmd = { cssls, "--stdio" },
    })

    -- Dockerfile
    local dockerls = fns.mason_bin_path_to("docker-langserver")
    lspconfig["dockerls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(dockerls),
      cmd = { dockerls, "--stdio" },
    })

    -- HTML
    local html = fns.mason_bin_path_to("vscode-html-language-server")
    lspconfig["html"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(html),
      cmd = { html, "--stdio" },
    })

    -- Kotlin
    local kotlin_language_server = fns.mason_bin_path_to("kotlin-language-server")
    lspconfig["kotlin_language_server"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(kotlin_language_server),
      cmd = { kotlin_language_server },
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
        -- Note: Only a part of the original code is used here as
        --       https://github.com/folke/neodev.nvim does the rest.
        local cwd = client.workspace_folders[1].name
        if cwd == vim.fn.stdpath("config") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              diagnostics = {
                -- Ignore noisy `missing-fields` warnings, e.g. when setting up nvim-treesitter's
                -- configuration ("Missing required fields in type `TSConfig`").
                -- https://github.com/LazyVim/LazyVim/issues/1471
                -- https://github.com/nvim-lua/kickstart.nvim/issues/543
                disable = { "missing-fields" },
              },
            },
          })
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        -- We also need to call the original on_init() function.
        return on_init(client)
      end,
    })

    -- Python
    local pyright = fns.mason_bin_path_to("pyright-langserver")
    lspconfig["pyright"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(pyright),
      cmd = { pyright, "--stdio" },
    })

    -- Rust
    local rust_analyzer = fns.mason_bin_path_to("rust-analyzer")
    lspconfig["rust_analyzer"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(rust_analyzer),
      cmd = { rust_analyzer },
      settings = {
        -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {},
      },
    })

    -- Terraform
    local terraformls = fns.mason_bin_path_to("terraform-ls")
    lspconfig["terraformls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(terraformls),
      cmd = { terraformls, "serve" },
    })

    -- Vim
    local vimls = fns.mason_bin_path_to("vim-language-server")
    lspconfig["vimls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(vimls),
      cmd = { vimls, "--stdio" },
    })

    -- YAML
    local yamlls = fns.mason_bin_path_to("yaml-language-server")
    lspconfig["yamlls"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      on_init = on_init,
      autostart = fns.is_executable(yamlls),
      cmd = { yamlls, "--stdio" },
      settings = {
        yaml = {
          schemas = {
            -- To be defined in project-local configuration files.
          },
        },
      },
    })
  end,
}
