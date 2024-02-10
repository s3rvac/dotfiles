-- An improved wild menu for cmdline and searching.
-- https://github.com/gelguy/wilder.nvim
return {
  "gelguy/wilder.nvim",
  event = "CmdlineEnter",
  dependencies = {
    "romgrk/fzy-lua-native",
  },
  config = function()
    local wilder = require("wilder")

    wilder.setup({modes = {":", "/", "?"}})

    wilder.set_option("use_python_remote_plugin", 0)

    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
      )
    })

    wilder.set_option("renderer", wilder.popupmenu_renderer({
      highlighter = wilder.lua_fzy_highlighter(),
      highlights = {
        accent = wilder.make_hl(
          "WilderAccent",
          "Pmenu",
          {{a = 1}, {a = 1}, {foreground = "#33b1ff", bold = true}}
        ),
      },
    }))
  end
}
