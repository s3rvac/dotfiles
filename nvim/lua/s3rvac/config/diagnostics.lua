vim.diagnostic.config({
  -- Use underline for diagnostics.
  underline = true,
  -- Enable indicators in the sign column.
  signs = true,
  -- Disable the distracting virtual text.
  virtual_text = false,
  -- Show higher-severity diagnostics before lower-severity ones.
  severity_sort = true,
  -- Do not update diagnostics while in the insert mode.
  update_in_insert = false,
  -- Settings for the floating window.
  float = {
    border = "single",
    -- Use a custom formatting function.
    -- Message example:
    --   "xyz" is not defined (Pyright) [reportUndefinedVariable]
    suffix = "",
    format = function(diagnostic)
      return string.format(
        "%s (%s) [%s]",
        -- Remove trailing periods, e.g. "Lua Syntax Check." -> "Lua Syntax Check".
        string.gsub(diagnostic.message, "%.$", ""),
        string.gsub(diagnostic.source, "%.$", ""),
        diagnostic.code or (diagnostic.user_data and diagnostic.user_data.lsp.code or "-")
      )
    end,
  },
})
