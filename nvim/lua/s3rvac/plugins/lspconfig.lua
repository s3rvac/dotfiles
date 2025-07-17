-- LSP-related configuration.
-- https://github.com/neovim/nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  tag = "v2.1.0", -- 2025-04-26
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- LSP completion for nvim-cmp.
    "hrsh7th/cmp-nvim-lsp",
    -- Better development experience for Neovim configuration and plugins.
    -- https://github.com/folke/neodev.nvim
    {
      "folke/neodev.nvim",
      tag = "v3.0.0", -- 2024-06-01
    },
    -- Incremental LSP renaming.
    -- https://github.com/smjonas/inc-rename.nvim
    {
      "smjonas/inc-rename.nvim",
      commit = "2eaff20526ff6101337b84f4b0d238c11f47d7f4", -- 2025-05-06
    },
  },
  config = function()
    -- Important: Make sure to set up neodev before lspconfig.
    require("neodev").setup()
    require("inc_rename").setup()

    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local fns = require("s3rvac.functions")

    -- LSP capabilities with extended configuration to enable autocompletion
    -- (the capabilities are assigned to every LSP server config).
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

    -- Add border around windows.
    require("lspconfig.ui.windows").default_options.border = "single"
    local open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "single"
      return open_floating_preview(contents, syntax, opts, ...)
    end

    local on_attach = function(_, bufnr)
      -- Buffer-local keymaps and settings that only work if there is an active
      -- language server.
      local opts = { noremap = true, silent = true, buffer = bufnr }

      opts.desc = "LSP: Jump to the definition of the symbol under cursor"
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "LSP: Jump to the declaration of the symbol under cursor"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "LSP: Show documentation for the symbol under cursor"
      vim.keymap.set("n", "<Leader>ll", vim.lsp.buf.hover, opts)

      opts.desc = "LSP: Toggle inlay hints"
      vim.keymap.set("n", "<Leader>li", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        print("LSP inlay hints: " .. (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"))
      end, opts)

      opts.desc = "LSP: Show signature for the current function call"
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

      opts.desc = "LSP: Show references for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lr", "<cmd>FzfLua lsp_references<CR>", opts)

      -- The following keymap is useful when a file changes outside of Neovim,
      -- e.g. a new file is added, or a new module is installed that the
      -- language server does not know about yet.
      opts.desc = "LSP: Restart all the language servers"
      vim.keymap.set("n", "<Leader>lR", function()
        local language_servers = {}

        -- GitHub Copilot does not react to :LspStart, so we have to first
        -- check if it is running, then stop all language servers, and then
        -- start GitHub Copilot (provided that it was previously running).
        local copilot_enabled = false
        for _, client in pairs(vim.lsp.get_clients({ buffer = bufnr })) do
          language_servers[client.name] = true
          if client.name ~= "GitHub Copilot" then
            copilot_enabled = true
          end
        end

        -- Use LspStop followed by LspStart as LspRestart does not work
        -- properly (language servers are not attached).
        vim.cmd("LspStop")
        vim.cmd("LspStart")

        if copilot_enabled then
          vim.cmd("Copilot enable")
        end

        language_servers = table.concat(vim.tbl_keys(language_servers), ", ")
        print("Language servers restarted: " .. language_servers)
      end, opts)

      opts.desc = "LSP: Show available code actions for the symbol under cursor"
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)

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

    local function set_up_language_server(t)
      local server_name = fns.table_remove_key(t, "server_name")
      local cmd_args = fns.table_remove_key(t, "cmd_args") or {}

      -- I need to specify full paths to servers; otherwise, they fail to start
      -- (for no apparent reason). I am able to run them manually from Neovim
      -- without any issues.
      --
      -- Prefer the tools installed via Mason, but fall back to the system-wide
      -- ones (used e.g. by rust-analyzer).
      local orig_server_bin = fns.table_remove_key(t, "server_bin")
      local server_bin = fns.mason_bin_path_to(orig_server_bin)
      if not fns.is_executable(server_bin) and fns.is_executable(orig_server_bin) then
        server_bin = vim.fn.exepath(orig_server_bin)
      end

      lspconfig[server_name].setup(vim.tbl_extend("error", t, {
        capabilities = fns.table_remove_key(t, "capabilities") or capabilities,
        on_attach = fns.table_remove_key(t, "on_attach") or on_attach,
        on_init = fns.table_remove_key(t, "on_init") or on_init,
        autostart = fns.is_executable(server_bin),
        cmd = { server_bin, fns.unpack(cmd_args) },
      }))
    end

    -- Bash
    set_up_language_server({
      server_name = "bashls",
      server_bin = "bash-language-server",
      cmd_args = { "start" },
      settings = {
        bashIde = {
          -- Disable shellcheck because it is already handled by nvim-lint.
          shellcheckPath = "",
        },
      },
    })

    -- C, C++
    set_up_language_server({
      server_name = "clangd",
      server_bin = "clangd",
    })

    -- CSS
    set_up_language_server({
      server_name = "cssls",
      server_bin = "vscode-css-language-server",
      cmd_args = { "--stdio" },
    })

    -- Dockerfile
    set_up_language_server({
      server_name = "dockerls",
      server_bin = "docker-langserver",
      cmd_args = { "--stdio" },
    })

    -- Go
    set_up_language_server({
      server_name = "gopls",
      server_bin = "gopls",
    })

    -- Haskell
    set_up_language_server({
      server_name = "hls",
      server_bin = "haskell-language-server",
      filetypes = { "haskell", "lhaskell", "cabal" },
      cmd_args = { "--lsp" },
      settings = {
        haskell = {
          formattingProvider = "fourmolu",
        },
      },
    })

    -- HTML
    set_up_language_server({
      server_name = "html",
      server_bin = "vscode-html-language-server",
      cmd_args = { "--stdio" },
    })

    -- Kotlin
    set_up_language_server({
      server_name = "kotlin_language_server",
      server_bin = "kotlin-language-server",
      settings = {
        kotlin = {
          -- Enable inlay hints.
          inlayHints = {
            typeHints = true,
            parameterHints = true,
            chaineHints = true,
          },
        },
      },
    })

    -- Lua
    set_up_language_server({
      server_name = "lua_ls",
      server_bin = "lua-language-server",
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
      settings = {
        Lua = {
          -- Enable inlay hints.
          hint = {
            enable = true,
          },
        },
      },
    })

    -- Python
    set_up_language_server({
      server_name = "pyright",
      server_bin = "pyright-langserver",
      cmd_args = { "--stdio" },
    })

    -- Rust
    --
    -- Use a rust-analyzer installation corresponding to the used Rust version
    -- instead of using the Mason-provided one (I had some issues with the
    -- Mason-provided one):
    --
    --     $ rustup component add rust-analyzer
    set_up_language_server({
      server_name = "rust_analyzer",
      server_bin = "rust-analyzer",
      settings = {
        -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {},
      },
    })

    -- Terraform
    set_up_language_server({
      server_name = "terraformls",
      server_bin = "terraform-ls",
      cmd_args = { "serve" },
    })

    -- Vim
    set_up_language_server({
      server_name = "vimls",
      server_bin = "vim-language-server",
      cmd_args = { "--stdio" },
    })

    -- YAML
    set_up_language_server({
      server_name = "yamlls",
      server_bin = "yaml-language-server",
      cmd_args = { "--stdio" },
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
