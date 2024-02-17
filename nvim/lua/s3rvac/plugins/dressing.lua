-- Improved UI.
-- https://github.com/stevearc/dressing.nvim
return {
  "stevearc/dressing.nvim",
  tag = "stable",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      border = "single",
      select = {
        -- Do not trim the trailing `:` from prompt (the trimmed version looks
        -- weird as the cursor is right after the prompt).
        trim_prompt = false,
      },
    })

    -- Show a better looking menu when asking for spelling suggestions.
    -- https://github.com/stevearc/dressing.nvim/issues/60#issuecomment-1239488340
    vim.keymap.set("n", "z=", function()
      local word = vim.fn.expand("<cword>")
      local suggestions = vim.fn.spellsuggest(word)
      vim.ui.select(
        suggestions,
        {},
        vim.schedule_wrap(function(selected)
          if selected then
            vim.api.nvim_feedkeys("ciw" .. selected, "n", true)
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<Esc>", true, true, true),
              "n",
              true
            )
          end
        end)
      )
    end)
  end,
}
