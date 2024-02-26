-- GitHub Copilot.
-- https://github.com/github/copilot.vim
return {
  "github/copilot.vim",
  tag = "v1.19.2", -- 2024-02-20
  config = function()
    -- Enable the copilot lazily to work around the issue that when I start
    -- Neovim, the plugin causes a lag that prevents me to do anything for the
    -- few hundred milliseconds. I have also tried loading the plugin with
    -- `event = "VeryLazy"`, but it did not have any effect.
    vim.g.copilot_enabled = false
    vim.cmd(
      "au BufNewFile,BufRead * call timer_start(1000, { tid -> execute('lua vim.g.copilot_enabled = true')})"
    )

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

    -- Mappings.
    vim.keymap.set("n", "<Leader>gcp", ":Copilot panel")
  end,
}
