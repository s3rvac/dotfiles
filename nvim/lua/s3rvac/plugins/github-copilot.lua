-- GitHub Copilot.
-- https://github.com/github/copilot.vim
return {
  "github/copilot.vim",
  tag = "v1.38.0", -- 2024-07-11
  config = function()
    -- Add an option to enable or disable copilot, e.g. via exrc.
    -- Note: This is my own variable, not the one provided by the plugin.
    if vim.fn.exists("g:copilot_enable") == 0 then
      vim.g.copilot_enable = true
    end

    -- Enable the copilot lazily to work around the issue that when I start
    -- Neovim, the plugin causes a lag that prevents me to do anything for the
    -- few hundred milliseconds. I have also tried loading the plugin with
    -- `event = "VeryLazy"`, but it did not have any effect.
    vim.g.copilot_enabled = false
    vim.cmd([[
      au BufNewFile,BufRead * call timer_start(1000,
        \ { tid -> execute('lua if vim.g.copilot_enable then vim.g.copilot_enabled = true end')})
    ]])

    -- Enable the plugin only for certain file types.
    vim.g.copilot_filetypes = {
      ["*"] = false,
      c = true,
      cmake = true,
      cpp = true,
      css = true,
      dockerfile = true,
      gitcommit = true,
      go = true,
      html = true,
      java = true,
      javascript = true,
      kotlin = true,
      lua = true,
      markdown = true,
      php = true,
      python = true,
      ruby = true,
      rust = true,
      sh = true,
      sql = true,
      terraform = true,
      tex = true,
      typescript = true,
      vim = true,
      xml = true,
      yaml = true,
    }

    -- Use a custom completion command.
    vim.g.copilot_no_tab_map = true
    vim.keymap.set("i", "<C-x><C-j>", 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
    })

    -- Keymaps.
    vim.keymap.set("n", "<Leader>gcp", ":Copilot panel<CR>")
    vim.keymap.set("n", "<Leader>gce", ":Copilot enable<CR>:echo 'Copilot enabled'<CR>")
    vim.keymap.set("n", "<Leader>gcd", ":Copilot disable<CR>:echo 'Copilot disabled'<CR>")
  end,
}
