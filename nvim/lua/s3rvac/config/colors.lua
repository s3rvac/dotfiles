-- I use my own colorscheme.
vim.cmd("colorscheme s3rvac")

-- Highlight mixtures of spaces and tabs.
vim.cmd([[hi SpacesTabsMixture guifg=red guibg=gray19]])

-- Highlight mixtures only when there are at least two successive spaces to
-- prevent highlighting of false positives (e.g. in git diffs, which may begin
-- with a space).
vim.cmd([[match SpacesTabsMixture /^  \+\t\+[\t ]*\|^\t\+  \+[\t ]*/]])
