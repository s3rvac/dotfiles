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

    -- Used to enable autocompletion (assigned to every LSP server config).
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

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

      opts.desc = "Open line diagnostics"
      vim.keymap.set("n", "<Leader>df", vim.diagnostic.open_float, opts)

      opts.desc = "Open line diagnostics"
      vim.keymap.set("n", "<Leader>df", vim.diagnostic.open_float, opts)

      opts.desc = "Go to the previous diagnostic"
      vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to the next diagnostic"
      vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, opts)

      opts.desc = "List all diagnostics from the current buffer"
      vim.keymap.set("n", "<Leader>dl", "<cmd>FzfLua diagnostics_document<CR>", opts)

      opts.desc = "LSP: Jump to the definition of the symbol under cursor"
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "LSP: Jump to the declaration of the symbol under cursor"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "LSP: Show documentation for the symbol under cursor"
      vim.keymap.set("n", "<Leader>ll", vim.lsp.buf.hover, opts)

      opts.desc = "LSP: Show references for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lr", "<cmd>FzfLua lsp_references<CR>", opts)

      opts.desc = "LSP: Show available code actions for the symbol under cursor"
      vim.keymap.set("n", "<Leader>lc", vim.lsp.buf.code_action, opts)

      opts.desc = "LSP: Smart rename of the symbol under cursor"
      vim.keymap.set("n", "<Leader>lR", vim.lsp.buf.rename, opts)

      opts.desc = "LSP: Reformat"
      vim.keymap.set({"n", "x"}, "<Leader>rF", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)

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

      -- Automatically show the diagnostics on the current line in a floating
      -- window after `updatetime` seconds of cursor inactivity.
      local float_window_opts = {
        focusable = false,
        close_events = {
          "BufLeave",
          "BufHidden",
          "CursorMoved",
          "InsertEnter",
          "FocusLost",
        },
      }
      vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            vim.diagnostic.open_float(nil, float_window_opts)
          end,
        })
    end

    ------ Language servers -------

    function file_exists(file)
      return vim.fn.filereadable(file) == 1
    end

    -- Python
    local pyright_server = vim.env.HOME .. "/.local/share/nvim/mason/bin/pyright-langserver"
    lspconfig["pyright"].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach,
      filetypes = { "python" },
      autostart = file_exists(pyright_server),
      -- I need to specify a full path to the server; otherwise, it fails to
      -- start (for no apparent reason). I am able to run it manually from
      -- Neovim without any issues.
      cmd = { pyright_server, "--stdio" },
    })
  end,
}
