-- Linters.
-- https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  commit = "789b7ada1b4f00e08d026dffde410dcfa6a0ba87", -- 2025-01-21
  event = "VeryLazy",
  config = function()
    local lint = require("lint")
    local fns = require("s3rvac.functions")

    -- Available linters.
    lint.linters_by_ft = {
      lua = { "luacheck" },
      python = { "ruff" },
      sh = { "shellcheck" },
      terraform = { "tflint" },
      yaml = { "yamllint" },
    }

    -- Settings for each linter.
    -- Note: The `enabled` attribute is my own. I use it to determine whether a
    --       particular linter is available (both in this file and in the statusline).
    local linter_settings = {
      luacheck = {
        cmd = fns.mason_bin_path_to("luacheck"),
        enabled = fns.mason_bin_exists("luacheck"),
        -- Make the linter recognize Neovim's `vim` global.
        args = { "--globals", "vim", fns.unpack(lint.linters.luacheck.args) },
      },
      ruff = {
        cmd = fns.mason_bin_path_to("ruff"),
        enabled = fns.mason_bin_exists("ruff"),
      },
      shellcheck = {
        cmd = fns.mason_bin_path_to("shellcheck"),
        enabled = fns.mason_bin_exists("shellcheck"),
        args = {
          -- Exclude the following diagnostic:
          -- * SC1090: ShellCheck can't follow non-constant source.
          "--exclude=SC1090",
          fns.unpack(lint.linters.shellcheck.args),
        },
      },
      tflint = {
        cmd = fns.mason_bin_path_to("tflint"),
        enabled = fns.mason_bin_exists("tflint"),
      },
      yamllint = {
        cmd = fns.mason_bin_path_to("yamllint"),
        enabled = fns.mason_bin_exists("yamllint"),
        args = {
          "--config-data",
          fns.tool_config_path_for("yamllint.yaml"),
          fns.unpack(lint.linters.yamllint.args),
        },
      },
    }

    -- Apply the above settings to nvim-lint.
    for linter, settings in pairs(linter_settings) do
      for k, v in pairs(settings) do
        lint.linters[linter][k] = v
      end
    end

    -- Automatically run the linter on certain events for certain filetypes.
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        local linter = lint.linters_by_ft[vim.bo.filetype]
        if linter and linter_settings[linter[1]].enabled then
          lint.try_lint()
        end
      end,
    })
  end,
}
