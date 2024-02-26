-- Fuzzy finding, grepping, etc.
-- https://github.com/ibhagwan/fzf-lua
return {
  {
    "ibhagwan/fzf-lua",
    commit = "3b3cc17c7bb91f6bbef7166c0756f89a189c4db4", -- 2024-02-23
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- List nvim-treesitter as a dependency to ensure that when fzf.lua is
      -- initialized, we can get the list of disabled treesitter modules from
      -- the treesitter.lua configuration.
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
      -- Mappings.
      local fzf = require("fzf-lua")
      vim.keymap.set("n", "<leader>fb", fzf.buffers, {})
      vim.keymap.set("n", "<leader>fc", fzf.command_history, {})
      vim.keymap.set("n", "<leader>ff", fzf.files, {})
      vim.keymap.set("n", "<leader>fgb", fzf.git_branches, {})
      vim.keymap.set("n", "<leader>fgc", fzf.git_commits, {})
      vim.keymap.set("n", "<leader>fgC", fzf.git_bcommits, {})
      vim.keymap.set("n", "<leader>fgs", fzf.git_status, {})
      vim.keymap.set("n", "<leader>fgt", fzf.git_tags, {})
      vim.keymap.set("n", "<leader>fR", fzf.resume, {})
      vim.keymap.set("n", "<leader>fs", fzf.search_history, {})
      vim.keymap.set("n", "<leader>/", fzf.live_grep_native, {})
      vim.keymap.set("n", "<leader>*", fzf.grep_cword, {})

      -- Fuzzy completion of file paths.
      -- (I still use the original implementation of <C-x><C-f> for file
      -- completion in case there are characters around the cursor, e.g. in
      -- `[text](|)`, where `|` is the cursor. Those cases are not handled by
      -- FzF very well.)
      vim.keymap.set({ "n", "v", "i" }, "<C-x><C-p>", function()
        fzf.complete_path()
      end, { silent = true, desc = "Fuzzy complete path" })

      -- Configuration.
      local fzf_defaults = require("fzf-lua.defaults").defaults
      require("fzf-lua").setup({
        defaults = {
          -- Disable icons (speedup + it more resembles fzf in the shell).
          git_icons = false,
          file_icons = false,
        },
        winopts = {
          width = 0.90,
          height = 0.80,
          border = "single",
          preview = {
            -- Decrease the width of the preview window to have more available space
            -- for file names.
            horizontal = "right:50%",
          },
        },
        fzf_colors = {
          -- Use the same colors as I use in the shell version of fzf.
          ["hl"] = { "fg", "Statement" },
          ["hl+"] = { "fg", "Statement" },
        },
        grep = {
          -- 1) Make ripgrep search also in hidden files/directories when grepping.
          -- 2) Use the same colors as I have defined for grep, git grep, etc.
          rg_opts = '--hidden --colors "match:fg:0xff,0xff,0x60" --colors "match:bg:black" --colors "match:style:bold" '
            .. fzf_defaults.grep.rg_opts,
        },
        previewers = {
          builtin = {
            treesitter = {
              enable = true,
              -- Disable the same types as disabled in the configuration for
              -- the nvim-treesitter plugin.
              disable = require("nvim-treesitter.configs").get_module("highlight").disable,
            },
          },
        },
      })
    end,
  },
}
