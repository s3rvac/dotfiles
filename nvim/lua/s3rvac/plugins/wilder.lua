-- An improved wild menu for cmdline and searching.
-- https://github.com/gelguy/wilder.nvim
return {
  "gelguy/wilder.nvim",
  commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf", -- 2022-08-13
  event = "CmdlineEnter",
  dependencies = {
    -- https://github.com/romgrk/fzy-lua-native
    {
      "romgrk/fzy-lua-native",
      commit = "820f745b7c442176bcc243e8f38ef4b985febfaf", -- 2023-06-08
    },
  },
  config = function()
    local wilder = require("wilder")

    wilder.setup({ modes = { ":", "/", "?" } })

    wilder.set_option("use_python_remote_plugin", 0)

    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
      ),
    })

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
        highlights = {
          accent = wilder.make_hl(
            "WilderAccent",
            "Pmenu",
            { { a = 1 }, { a = 1 }, { foreground = "#33b1ff", bold = true } }
          ),
        },
      })
    )
  end,
}
