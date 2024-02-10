-- Session manager.
-- https://github.com/stevearc/resession.nvim
return {
  "stevearc/resession.nvim",
  config = function()
    local resession = require("resession")

    -- Settings.
    resession.setup({
      -- Disable autosaving (I save my sessions manually).
      autosave = {
        enabled = false,
      },
      -- Store all sessions into ~/.local/share/nvim/sessions.
      dir = "sessions",
    })

    -- Commands.
    vim.api.nvim_create_user_command(
      "SessSave",
      function(opts)
        resession.save(opts.fargs[1])
      end,
      {
        nargs = "?",
        desc = "Saves a session (optionally with the given name)",
      }
    )
    vim.api.nvim_create_user_command(
      "SessLoad",
      function(opts)
        resession.load(opts.fargs[1])
      end,
      {
        nargs = "?",
        desc = "Loads a session (optionally with the given name)"
      }
    )
  end
}
