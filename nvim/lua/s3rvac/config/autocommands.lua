local fns = require("s3rvac.functions")

-------------------------------------------------------------------------------
-- HCL
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeHCL", {})

-- Comment settings.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeHCL",
  pattern = "hcl",
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
  desc = "FileType hcl: Comment settings",
})

-------------------------------------------------------------------------------
-- Lua
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeLua", {})

-- Indent style.
--
-- Use tabs by default, but use 2 spaces when editing Neovim's configuration.
--
-- References:
-- - https://roblox.github.io/lua-style-guide/
-- - https://www.mediawiki.org/wiki/Manual:Coding_conventions/Lua
-- - Neovim's source code and other configs/plugins.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeLua",
  pattern = "lua",
  callback = fns.set_indent_style_to_tabs,
  desc = "FileType lua: Indent style - default",
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = "FileTypeLua",
  pattern = vim.fn.stdpath("config") .. "/*.lua",
  callback = fns.set_indent_style_to_2_spaces,
  desc = "FileType lua: Indent style - Neovim's config",
})

-- Let <Leader>man open Lua documentation for the symbol under the cursor.
fns.create_man_cmd_and_ft_autocmd_for_opening_docs(
  "FileTypeLua",
  "lua",
  "https://www.google.com/search?q=site:lua.org+"
)

-- Let F10 run the currently opened script.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeLua",
  pattern = "lua",
  callback = function()
    vim.keymap.set(
      { "n" },
      "<F10>",
      ":w<CR>:!lua %<CR>",
      fns.keymap_opts({ buffer = true, desc = "Run the currently opened script" })
    )
  end,
  desc = "FileType lua: F10: Run the currently opened script",
})

-------------------------------------------------------------------------------
-- Markdown
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeMarkdown", {})

-- Text object: markdown link (using nvim-various-textobjs).
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set(
      { "o", "x" },
      "il",
      "<cmd>lua require('various-textobjs').mdlink('inner')<CR>",
      fns.keymap_opts({ buffer = true, desc = "Text object: markdown link (inner)" })
    )
    vim.keymap.set(
      { "o", "x" },
      "al",
      "<cmd>lua require('various-textobjs').mdlink('outer')<CR>",
      fns.keymap_opts({ buffer = true, desc = "Text object: markdown link (outer)" })
    )
  end,
  desc = "nvim-various-textobjs: Markdown links",
})

-------------------------------------------------------------------------------
-- PHP
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypePHP", {})

-- Let <Leader>man open PHP documentation for the symbol under the cursor.
fns.create_man_cmd_and_ft_autocmd_for_opening_docs("FileTypePHP", "php", "https://php.net/")

-- Comment settings.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypePHP",
  pattern = "php",
  callback = function()
    -- Prefer // comments over /* */ comments.
    vim.bo.commentstring = "// %s"
  end,
  desc = "FileType php: Comment settings",
})

-------------------------------------------------------------------------------
-- Python
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypePython", {})

-- Indent style.
--
-- References:
-- - https://peps.python.org/pep-0008/
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypePython",
  pattern = "python",
  callback = fns.set_indent_style_to_4_spaces,
  desc = "FileType python: Indent style - default",
})

-- Make `gw` work properly on rst-style comments (#: xyz).
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypePython",
  pattern = "python",
  callback = function()
    vim.bo.comments = vim.bo.comments .. ",b:#:"
  end,
  desc = "FileType python: Comments",
})

-- Let <Leader>man open Python documentation for the symbol under the cursor.
fns.create_man_cmd_and_ft_autocmd_for_opening_docs(
  "FileTypePython",
  "python",
  "https://docs.python.org/3/search.html?q="
)

-- Let F10 run the currently opened script.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypePython",
  pattern = "python",
  callback = function()
    vim.keymap.set(
      { "n" },
      "<F10>",
      ":w<CR>:!python %<CR>",
      fns.keymap_opts({ buffer = true, desc = "Run the currently opened script" })
    )
  end,
  desc = "FileType python: F10: Run the currently opened script",
})

-------------------------------------------------------------------------------
-- SQL
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeSQL", {})

-- Comment settings.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeSQL",
  pattern = "sql",
  callback = function()
    vim.bo.commentstring = "-- %s"
  end,
  desc = "FileType sql: Comment settings",
})

-------------------------------------------------------------------------------
-- Terraform
-------------------------------------------------------------------------------

vim.api.nvim_create_augroup("FileTypeTerraform", {})

-- Comment settings.
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeTerraform",
  pattern = "terraform",
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
  desc = "FileType terraform: Comment settings",
})

-------------------------------------------------------------------------------
-- Other (have not been rewritten to Lua yet).
-------------------------------------------------------------------------------

vim.cmd([[
" Runs silently the given shell command.
command! -nargs=1 SilentExecute execute ':silent !' . <q-args> | execute ':redraw!'

augroup file_types
au!
" Consider all .tpl files to be Smarty files.
au BufNewFile,BufRead *.tpl setl ft=smarty
" Consider all .php* files (.phps, .phpt etc.) to be PHP files.
au BufNewFile,BufRead *.php[0-9a-zA-Z] setl ft=php
" Consider all .ll files to be LLVM IR files.
au BufNewFile,BufRead *.ll setl ft=llvm
" Consider all .wsgi files to be Python files.
au BufNewFile,BufRead *.wsgi setl ft=python
" Use Vim highlighting when editing Tridactyl's configuration.
au BufNewFile,BufRead .tridactylrc setl ft=vim
" Consider all .hql files to be Hive files.
au BufNewFile,BufRead *.hql set ft=hive
" Consider all .yar/.yara files to be YARA files.
au BufNewFile,BufRead *.yar,*.yara set filetype=yara
" Detection of Terraform-related files.
au BufNewFile,BufRead *.hcl,*.tfbackend set filetype=hcl
au BufNewFile,BufRead .terraformrc,terraform.rc set filetype=hcl
au BufNewFile,BufRead *.tf,*.tfvars,*.tftest.hcl set filetype=terraform
au BufNewFile,BufRead *.tfstate,*.tfstate.backup set filetype=json
augroup end

augroup remove_trailing_whitespace
au!
" Automatically remove trailing whitespace when saving a file.
function! s:RemoveTrailingWhitespace()
  let pattern = '\\s\\+$'
  if &ft ==# 'mail'
    " Do not remove the space from the email signature marker ("-- \n").
    let pattern = '\\(^--\\)\\@<!' . pattern
  endif
  call setline(1, map(getline(1, '$'), 'substitute(v:val, "' . pattern . '", "", "")'))
endfunction
au BufWritePre * :if !&bin | call s:RemoveTrailingWhitespace()
" Add a new command :W that can be used to write a file without removing
" trailing whitespace (this is sometimes handy).
command! W :set eventignore=BufWritePre | w | set eventignore=""
augroup end

" C and C++
augroup c_cpp
au!
" Use <Leader>man to display manual pages for the function under cursor.
au FileType c,cpp nnoremap <buffer> <silent> <Leader>man :execute ':vertical Man 3 ' . expand('<cword>')<CR>
" Make "gw" on comments work properly.
au FileType c,cpp setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
" Prefer // comments over /* */ comments.
au FileType c,cpp setl commentstring=//\ %s
" Search also in /usr/include.
au FileType c,cpp setl path+=/usr/include
" Switch between the header and the source file (requires https://clangd.llvm.org/).
au FileType c,cpp nnoremap <buffer> <silent> <Leader>hs :ClangdSwitchSourceHeader<CR>

" Let F10 compile and run the currently edited code
" (F10 -> use GCC, S-F10 -> use Clang).
au FileType c nnoremap <buffer> <F10> :w<CR>:!clear; gcc -std=c2x -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
au FileType c nnoremap <buffer> <S-F10> :w<CR>:!clear; clang -std=c2x -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
au FileType cpp nnoremap <buffer> <F10> :w<CR>:!clear; g++ -std=c++23 -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
au FileType cpp nnoremap <buffer> <S-F10> :w<CR>:!clear; clang++ -std=c++23 -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
augroup end

" Dokuwiki
augroup dokuwiki
au!
" Enable spell checking by default.
au FileType dokuwiki setl spell

" Indentation settings.
au FileType dokuwiki setl expandtab
au FileType dokuwiki setl tabstop=2
au FileType dokuwiki setl softtabstop=2
au FileType dokuwiki setl shiftwidth=2
augroup end


" Git commits
augroup gitcommit
au!
" Enable spell checking by default.
au FileType gitcommit setl spell

" Indentation settings.
au FileType gitcommit setl expandtab
au FileType gitcommit setl tabstop=4
au FileType gitcommit setl softtabstop=4
au FileType gitcommit setl shiftwidth=4
augroup end

" Go
augroup go
au!
" The default indentation settings are OK as Go uses tabs.

" Let F10 compile and run the current file.
au FileType go nnoremap <buffer> <F10> :w<CR>:!clear; go run %<CR>
augroup end

" Haskell
augroup haskell
au!
" Indentation settings.
au FileType haskell setl expandtab
au FileType haskell setl tabstop=4
au FileType haskell setl softtabstop=4
au FileType haskell setl shiftwidth=4
augroup end

" Hive
augroup hive
au!
" Indentation settings.
au FileType hive setl expandtab
au FileType hive setl tabstop=4
au FileType hive setl softtabstop=4
au FileType hive setl shiftwidth=4
augroup end

" JavaScript
augroup javascript
au!
augroup end

" Kotlin
augroup kotlin
au!
" Indentation settings.
au FileType kotlin setl expandtab
au FileType kotlin setl tabstop=4
au FileType kotlin setl softtabstop=4
au FileType kotlin setl shiftwidth=4
augroup end

" LaTeX
augroup latex
au!
" Enable spell checking by default.
au FileType tex setl spell
augroup end

" LLVM
augroup llvm
au!
" Indentation settings.
au FileType llvm setl expandtab
au FileType llvm setl tabstop=2
au FileType llvm setl softtabstop=2
au FileType llvm setl shiftwidth=2

" Make "gw" on comments working properly.
au FileType llvm setl comments=bO:;
augroup end

" Mail
augroup mail
au!
" Enable Czech spell checking by default.
au FileType mail setl spell
au FileType mail setl spelllang=cs

" Indentation settings.
au FileType mail setl expandtab
augroup end

" Markdown
augroup markdown
au!
" Enable spell checking by default.
au FileType markdown setl spell

" Indentation settings.
au FileType markdown setl expandtab
au FileType markdown setl tabstop=4
au FileType markdown setl softtabstop=4
au FileType markdown setl shiftwidth=4
augroup end

" reStructured Text
augroup rst
au!
" Enable spell checking by default.
au FileType rst setl spell

" Indentation settings.
au FileType rst setl expandtab
au FileType rst setl tabstop=4
au FileType rst setl softtabstop=4
au FileType rst setl shiftwidth=4
augroup end

" Ruby
augroup ruby
au!
" Indentation settings.
au FileType ruby setl expandtab
au FileType ruby setl tabstop=2
au FileType ruby setl softtabstop=2
au FileType ruby setl shiftwidth=2

" Let F10 run the currently opened script.
au FileType ruby nnoremap <buffer> <F10> :w<CR>:!clear; ruby %<CR>
augroup end

" Rust
augroup rust
au!
" Indentation settings.
au FileType rust setl expandtab
au FileType rust setl tabstop=4
au FileType rust setl softtabstop=4
au FileType rust setl shiftwidth=4

" Let F9 compile and run tests for the current project.
au FileType rust nnoremap <buffer> <F10> :w<CR>:!clear; cargo test<CR>

" Let F10 compile and run the current project.
au FileType rust nnoremap <buffer> <F10> :w<CR>:!clear; cargo run<CR>
augroup end

" Shell
augroup sh
au!
" Let F10 run the currently opened script.
au FileType sh nnoremap <buffer> <F10> :w<CR>:!clear; sh %<CR>
augroup end

" Terraform
augroup terraform
au!
" Indentation settings.
au FileType terraform setl expandtab
au FileType terraform setl tabstop=2
au FileType terraform setl softtabstop=2
au FileType terraform setl shiftwidth=2
augroup end

" Terragrunt (.hcl)
augroup hcl
au!
" Indentation settings.
au FileType hcl setl expandtab
au FileType hcl setl tabstop=2
au FileType hcl setl softtabstop=2
au FileType hcl setl shiftwidth=2
augroup end

" YAML
augroup yaml
au!
" Indentation settings.
au FileType yaml setl expandtab
au FileType yaml setl tabstop=2
au FileType yaml setl softtabstop=2
au FileType yaml setl shiftwidth=2
augroup end
]])
