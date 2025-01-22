-- A file explorer that allows editing the filesystem like a buffer.
-- https://github.com/stevearc/oil.nvim
return {
  "stevearc/oil.nvim",
  tag = "v2.14.0", -- 2024-12-21
  config = function()
    require("oil").setup({
      -- Show just file names, without icons (I find them distracting).
      columns = {},
      -- Set custom keymaps as some of the default ones clash with the ones that
      -- I use (e.g. <Ctrl-s> or gs) and some of the default ones I do not use.
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<M-v>"] = "actions.select_vsplit",
        ["<M-s>"] = "actions.select_split",
        ["<M-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<Leader>rr"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["gx"] = "actions.open_external",
      },
      view_options = {
        show_hidden = true,
      },
    })

    -- I need to use a custom definition of the <C-s> keymap for saving the
    -- changes so that I skip the removal of trailing whitespace that I use,
    -- which is incompatible with oil.nvim.
    vim.api.nvim_create_augroup("oil.nvim", {})
    vim.api.nvim_create_autocmd("FileType", {
      group = "oil.nvim",
      pattern = "oil",
      callback = function()
        vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save oil.nvim changes" })
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      group = "oil.nvim",
      pattern = "oil",
      callback = function()
        vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save oil.nvim changes" })
      end,
    })
  end,
}
