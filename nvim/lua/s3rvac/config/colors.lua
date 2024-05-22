-- I use my own colorscheme.
vim.cmd("colorscheme s3rvac")

-- A list of filetypes for which I do not want to use Treesitter-based syntax
-- highlighting. The reason is that for those file types, the original,
-- non-treesitter, regex-based version looks better, at least for now.
vim.g.s3rvac_disable_treesitter_highlight_for_filetypes = {
  "css",
  "csv",
  "diff",
  "dockerfile",
  "gitcommit",
  "kotlin",
  "latex",
  "make",
  "rst",
  "toml",
  "yaml",
}

-- Highlight mixtures of spaces and tabs.
vim.cmd([[hi SpacesTabsMixture guifg=red guibg=gray19]])

-- Highlight mixtures only when there are at least two successive spaces to
-- prevent highlighting of false positives (e.g. in git diffs, which may begin
-- with a space).
vim.cmd([[match SpacesTabsMixture /^  \+\t\+[\t ]*\|^\t\+  \+[\t ]*/]])
