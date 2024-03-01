-- Filesytem explorer.
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  tag = "3.17", -- 2024-02-14
  dependencies = {
    -- https://github.com/MunifTanjim/nui.nvim
    {
      "MunifTanjim/nui.nvim",
      tag = "0.3.0", -- 2024-02-16
    },
    -- https://github.com/nvim-lua/plenary.nvim
    {
      "nvim-lua/plenary.nvim",
      commit = "4f71c0c4a196ceb656c824a70792f3df3ce6bb6d", -- 2024-01-29
    },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local fns = require("s3rvac.functions")

    -- Configuration.
    local highlights = require("neo-tree.ui.highlights")
    local components = require("neo-tree.sources.common.components")
    require("neo-tree").setup({
      enable_git_status = false,
      default_component_configs = {
        -- Do not show file types as I do not need to see this information.
        type = {
          enabled = false,
        },
        symlink_target = {
          enabled = true,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        -- Disable netrw (built-in filesystem explorer) and open directory
        -- within the window like netrw would, regardless of window.position.
        hijack_netrw_behavior = "open_current",
        -- Use the OS level file watchers to detect changes instead of
        -- relying on Neovim autocmd events.
        use_libuv_file_watcher = true,
        components = {
          -- Disable format-specific file icons as I do not like those.
          -- Instead, use always just "*".
          icon = function(config, node, state)
            if node.type == "file" then
              return { text = "* ", highlight = highlights.FILE_ICON }
            else
              return components.icon(config, node, state)
            end
          end,
        },
      },
    })

    -- Keymaps.
    vim.keymap.set(
      "n",
      "<leader>nt",
      ":Neotree source=filesystem toggle=true reveal=true position=left<CR>",
      fns.keymap_opts({ desc = "Toggle Neo-tree (left side)" })
    )
    vim.keymap.set(
      "n",
      "<leader>nT",
      ":Neotree source=filesystem toggle=true reveal=true position=current<CR>",
      fns.keymap_opts({ desc = "Toggle Neo-tree (current buffer)" })
    )
  end,
}
