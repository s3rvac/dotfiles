return {
  -- Syntax highlighting for Kotlin.
  -- Note: The treesitter-based one works but (1) looks worse than this one and
  -- (2) takes around 0.5s to load.
  -- https://github.com/udalov/kotlin-vim
  {
    "udalov/kotlin-vim",
    commit = "53fe045906df8eeb07cb77b078fc93acda6c90b8", -- 2022-12-30
    ft = "kotlin",
  },
  -- Syntax highlighting and other features for LaTeX.
  -- Note: The treesitter-based highlighting works but looks worse than this one.
  -- https://github.com/lervag/vimtex
  {
    "lervag/vimtex",
    tag = "v2.14", -- 2023-06-17
    ft = "tex",
    config = function()
      -- Disable built-in keymaps.
      vim.g.vimtex_mappings_enabled = false
      -- Use Okular as the PDF viewer.
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
    end,
  },
  -- Syntax highlighting for YARA rules.
  -- https://github.com/s3rvac/vim-syntax-yara
  {
    "s3rvac/vim-syntax-yara",
    ft = "yara",
  },
  -- Syntax highlighting for Jira issues.
  -- https://github.com/s3rvac/vim-syntax-jira
  {
    "s3rvac/vim-syntax-jira",
    ft = "jira",
  },
}
