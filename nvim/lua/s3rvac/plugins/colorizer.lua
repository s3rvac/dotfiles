-- Colorizer of color codes.
-- https://github.com/norcalli/nvim-colorizer.lua
return {
  "norcalli/nvim-colorizer.lua",
  commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6", -- 2020-06-11
  config = function()
    -- Disable colorizer by default and only enable it via :ColorizerToggle.
    require("colorizer").setup({
      -- Enable the colorizer for the following filetypes.
      "css",
      "lua",
      "html",
      "vim",
    }, {
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    })
  end,
}
