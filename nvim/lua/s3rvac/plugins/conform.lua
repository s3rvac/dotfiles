-- Code formatting.
-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  tag = "v5.3.0", -- 2024-02-20
  event = "VeryLazy",
  config = function()
    local conform = require("conform")
    local fns = require("s3rvac.functions")

    conform.setup({
      -- Notes:
      -- - Conform will run multiple formatters sequentially.
      -- - Use a nested table to only the first available formatter.
      -- - The `enabled` attribute is my own. I use it to determine whether a
      --   particular linter is available (both in this file and in the statusline).
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "gofmt" },
        hcl = { "terragrunt" },
        json = { "jq" },
        lua = { "stylua" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        terraform = { "terraform" },
        yaml = { "yq" },
      },
      formatters = {
        clang_format = {
          command = fns.mason_bin_path_to("clang-format"),
          enabled = fns.mason_bin_exists("clang-format"),
          prepend_args = { "--fallback-style=Google" },
        },
        gofmt = {
          command = "gofmt",
          enabled = vim.fn.executable("gofmt"),
        },
        jq = {
          command = fns.mason_bin_path_to("jq"),
          enabled = fns.mason_bin_exists("jq"),
          prepend_args = { "--indent", "4" },
        },
        ruff_format = {
          command = fns.mason_bin_path_to("ruff"),
          enabled = fns.mason_bin_exists("ruff"),
        },
        shfmt = {
          command = fns.mason_bin_path_to("shfmt"),
          enabled = fns.mason_bin_exists("shfmt"),
        },
        stylua = {
          command = fns.mason_bin_path_to("stylua"),
          enabled = fns.mason_bin_exists("stylua"),
        },
        rustfmt = {
          command = "rustfmt",
          enabled = vim.fn.executable("rustfmt"),
        },
        terragrunt = {
          command = "terragrunt",
          enabled = vim.fn.executable("terragrunt"),
          args = { "hclfmt", "-no-color", "-" },
        },
        terraform = {
          command = "terraform",
          enabled = vim.fn.executable("terraform"),
          args = { "fmt", "-no-color", "-" },
        },
        yq = {
          command = fns.mason_bin_path_to("yq"),
          enabled = fns.mason_bin_exists("yq"),
          -- Remove the default -P/--prettyPrint argument so that yq e.g. does
          -- not unfurl inline lists.
          args = { "-" },
        },
      },
    })

    -- Keymaps.
    vim.keymap.set({ "n", "v" }, "<Leader>rf", function()
      conform.format({ async = true, lsp_fallback = true }, function(err)
        if not err then
          print("Formatted")
        end
      end)
    end, fns.keymap_opts({ desc = "Formats the current buffer (or range) via conform.nvim" }))

    -- Support for formatting via `gq`.
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
}
