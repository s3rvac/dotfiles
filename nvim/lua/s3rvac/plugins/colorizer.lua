-- Colorizer of color codes.
-- https://github.com/norcalli/nvim-colorizer.lua
return {
  "norcalli/nvim-colorizer.lua",
  commit = "a065833f35a3a7cc3ef137ac88b5381da2ba302e", -- 2024-05-10
  ft = { "css", "html", "lua", "vim" },
  config = function()
    -- Disable colorizer by default and only enable it via :ColorizerToggle.
    require("colorizer").setup({
      -- Enable the colorizer for the following filetypes.
      "css",
      "html",
      "lua",
      "vim",
    }, {
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    })
  end,
}
