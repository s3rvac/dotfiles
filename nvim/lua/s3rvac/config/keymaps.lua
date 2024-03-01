local fns = require("s3rvac.functions")
local opts = fns.keymap_opts

-------------------------------------------------------------------------------
-- Location list
-------------------------------------------------------------------------------

vim.keymap.set("n", "[l", "<cmd>lprevious<cr>", opts({ desc = "Previous location list item" }))
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", opts({ desc = "Next location list item" }))
vim.keymap.set("n", "[L", "<cmd>lfirst<cr>", opts({ desc = "First location list item" }))
vim.keymap.set("n", "]L", "<cmd>llast<cr>", opts({ desc = "Last location list item" }))

-------------------------------------------------------------------------------
-- Quickfix list
-------------------------------------------------------------------------------

vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", opts({ desc = "Previous quickfix list item" }))
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", opts({ desc = "Next quickfix list item" }))
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>", opts({ desc = "First quickfix list item" }))
vim.keymap.set("n", "]Q", "<cmd>clast<cr>", opts({ desc = "Last quickfix list item" }))

-------------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------------

vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  opts({ desc = "Go to the previous diagnostic" })
)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts({ desc = "Go to the next diagnostic" }))
vim.keymap.set(
  "n",
  "<Leader>df",
  vim.diagnostic.open_float,
  opts({ desc = "Open line diagnostics" })
)
vim.keymap.set(
  "n",
  "<Leader>dl",
  "<cmd>FzfLua diagnostics_document<CR>",
  opts({ desc = "List all diagnostics from the current buffer" })
)

------- Other -------

vim.keymap.set("n", "<Leader>sis", fns.select_indent_style, opts({ desc = "Select indent style" }))

-------------------------------------------------------------------------------
-- Keymaps that I have not yet rewritten into Lua.
-------------------------------------------------------------------------------

vim.cmd([[
" The leader and local-leader characters.
let mapleader = ','
let maplocalleader = ','

" F1: Toggle spell checker.
nnoremap <silent> <F1> :set spell!<CR>:set spell?<CR>

" Shift+F1: Toggle spell dictionary between English and Czech.
function! s:ToggleSpelllang()
	if &spelllang =~ 'en'
		set spelllang=cs
	else
		set spelllang=en_us,en_gb
	endif
	set spelllang?
endfunction
nnoremap <silent> <S-F1> :call <SID>ToggleSpelllang()<CR>

" F2: Toggle the display of unprintable characters.
nnoremap <silent> <F2> :set list!<CR>:set list?<CR>

" Shift+F2: Toggle the display of colorcolumn.
function! s:ToggleColorColumn()
	if &colorcolumn > 0
		set colorcolumn=""
	elseif &textwidth > 0
		let &colorcolumn = &textwidth
	else
		set colorcolumn=80
	endif
endfunction
nnoremap <silent> <S-F2> :call <SID>ToggleColorColumn()<CR>

" F3: Toggle line wrapping.
nnoremap <silent> <F3> :set nowrap!<CR>:set nowrap?<CR>

" Shift+F3: Toggle relative/absolute numbers.
nnoremap <silent> <S-F3> :set relativenumber!<CR>:set relativenumber?<CR>

" F4: Toggle hexdump view of binary files.
function! s:ToggleHexdumpView()
	if &filetype ==# 'xxd'
		" Turn off hexdump view.
		silent! :%!xxd -r
		set filetype=
	else
		" Turn on hexdump view.
		silent! :%!xxd
		set filetype=xxd
	endif
endfunction
nnoremap <silent> <F4> :call <SID>ToggleHexdumpView()<CR>

" Shift+F4: Toggle objdump view of binary files.
function! s:ToggleObjdumpView()
	if &filetype ==# 'objdump'
		" Turn off objdump view.
		" Replace the buffer with the original content of the buffer, stored in
		" the Z register.
		normal! ggVG"ZP
		set filetype=
		set noreadonly
	else
		" Turn on objdump view.
		" Cut the original content of the buffer into the Z register so I can
		" use it later to restore the original content.
		normal! ggVG"Zd
		" Get the output from objdump and paste it into the buffer.
		silent! :read !objdump -S %
		" Go to the beginning of the file.
		normal! ggdd
		" Set a proper file type to enable syntax highlighting through
		" http://www.vim.org/scripts/script.php?script_id=530.
		set filetype=objdump
		" Prevent accidental overwrites.
		set readonly
	endif
endfunction
nnoremap <silent> <S-F4> :call <SID>ToggleObjdumpView()<CR>

" F9: Run tests for the given file.
" The keymap is defined separately for each file type.

" Shift+F9: Run all tests.
" The keymap is defined separately for each file type.

" F10: Run the current script.
" The keymap is defined separately for each file type.

" Quit with Q instead of :q!.
noremap <silent> Q :q!<CR>

" Quicksave all buffers.
" (Use both :w and :wa to force write of the currently edited buffer, even if
" there are no changes. This forces removal of trailing whitespace from the
" buffer and also overwrites of the file even if it has changed, which is
" sometimes handy.)
nnoremap <silent> <C-s> :w<CR>:wa<CR>
inoremap <silent> <C-s> <Esc>:w<CR><Esc>:wa<CR>
vnoremap <silent> <C-s> <Esc>:w<CR><Esc>:wa<CR>

" Insert the contents of the clipboard.
nnoremap <silent> <Leader>P :set paste<CR>"+]P:set nopaste<CR>
nnoremap <silent> <Leader>p :set paste<CR>"+]p:set nopaste<CR>
vnoremap          <Leader>p "+p
" The following keymap is needed in nvim-qt, which, without it, just emits
" "<S-Insert>".
map! <S-Insert> <C-r>+

" Copy the selected text into the clipboard.
noremap <Leader>y "+y

" Cut the selected text into the clipboard.
noremap <Leader>d "+d

" Stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" Quickly select the text I just pasted.
noremap gV `[v`]

" Hitting space in normal/visual mode will make the current search disappear.
noremap <silent> <Space> :silent nohlsearch<CR>

" Swap the '<letter> and `<letter> functionality because the ' character is
" more easily reachable than the ` character.
nnoremap ' `
nnoremap ` '

" Disable arrows keys (I use exclusively h/j/k/l).
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Make j and k move by virtual lines instead of physical lines, but only when
" not used in the count mode (e.g. 3j). This is great when 'wrap' and
" 'relativenumber' are used.
" Based on http://stackoverflow.com/a/21000307/2580955
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Jump to the previous/next tab.
noremap <silent> J :tabprevious<CR>
noremap <silent> K :tabnext<CR>

" Alt-# goes to the #th tab.
nnoremap <silent> <A-1> 1gt
nnoremap <silent> <A-2> 2gt
nnoremap <silent> <A-3> 3gt
nnoremap <silent> <A-4> 4gt
nnoremap <silent> <A-5> 5gt
nnoremap <silent> <A-6> 6gt
nnoremap <silent> <A-7> 7gt
nnoremap <silent> <A-8> 8gt
nnoremap <silent> <A-9> 9gt
nnoremap <silent> <A-0> :tablast<CR>
if !has('gui_running')
	" Konsole sends <Esc># when pressing Alt-#.
	nnoremap <silent> <Esc>1 1gt
	nnoremap <silent> <Esc>2 2gt
	nnoremap <silent> <Esc>3 3gt
	nnoremap <silent> <Esc>4 4gt
	nnoremap <silent> <Esc>5 5gt
	nnoremap <silent> <Esc>6 6gt
	nnoremap <silent> <Esc>7 7gt
	nnoremap <silent> <Esc>8 8gt
	nnoremap <silent> <Esc>9 9gt
	nnoremap <silent> <Esc>0 :tablast<CR>
endif

" Join lines by <Leader>j because I use J to go to the previous tab.
" Also, when joining lines, keep the cursor as-is instead of moving it to the
" end of the line.
noremap <Leader>j mzJ`z

" Join lines without producing any spaces. It works like gJ, but does not keep
" the indentation whitespace.
" Also, when joining lines, keep the cursor as-is instead of moving it to the
" end of the line.
function! s:JoinWithoutSpaces()
	" Store the current cursor position and join the lines.
	normal! mzgJ
	" Remove any whitespace.
	if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
		normal! dw
	endif
	" Go back to the stored cursor position.
	normal! `z
endfunction
noremap <silent> <Leader>J :call <SID>JoinWithoutSpaces()<CR>

" Make Y yank everything from the cursor to the end of the line.
" This makes Y act more like C or D because by default, Y yanks the current
" line (i.e. the same as yy).
noremap Y y$

" Close the opened HTML tag with Ctrl+_.
inoremap <silent> <C-_> </<C-x><C-o><C-x>

" Smart window switching with awareness of Tmux panes. Now, I can use Ctrl+hjkl
" in both Vim and Tmux (without using the prefix). Based on
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.
" Note: I do not use https://github.com/christoomey/vim-tmux-navigator because
"       it does not work when vim is run over ssh.
if exists('$TMUX')
	function! s:TmuxOrSplitSwitch(wincmd, tmuxdir)
		let previous_winnr = winnr()
		silent! execute 'wincmd ' . a:wincmd
		if previous_winnr == winnr()
			call system('tmux select-pane -' . a:tmuxdir)
			redraw!
		endif
	endfunction

	let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
	let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
	let &t_te = "\<Esc>]2;" . previous_title . "\<Esc>\\" . &t_te

	nnoremap <silent> <C-h> :call <SID>TmuxOrSplitSwitch('h', 'L')<CR>
	nnoremap <silent> <C-j> :call <SID>TmuxOrSplitSwitch('j', 'D')<CR>
	nnoremap <silent> <C-k> :call <SID>TmuxOrSplitSwitch('k', 'U')<CR>
	nnoremap <silent> <C-l> :call <SID>TmuxOrSplitSwitch('l', 'R')<CR>
else
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l
endif

" Zoom/restore the currently active window.
" Based on https://coderwall.com/p/qqz1lq/vim-zoom-restore-window.
function! s:WindowZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction
command! WindowZoomToggle call s:WindowZoomToggle()
nnoremap <silent> <Leader>wz :WindowZoomToggle<CR>

" Increase/decrease window width and height.
nnoremap <silent> <A-j> 10<C-w>-
nnoremap <silent> <A-k> 10<C-w>+
nnoremap <silent> <A-h> 10<C-w>>
nnoremap <silent> <A-l> 10<C-w><

" Expand %% to the path of the current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Man pages.
" The nnoremap <Leader>man keymap is defined for every language separately.

" Wrap function arguments.
" Requires the vim-argwrap plugin (https://github.com/FooSoft/vim-argwrap).
nnoremap <silent> <Leader>wa :ArgWrap<CR>

" Check for changes in all buffers, automatically reload them, and redraw.
nnoremap <silent> <Leader>rr :checktime <Bar> redraw!<CR>

" Replaces the current word and all its occurrences).
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/
" A fallback if a LSP server is not available (see lspconfig.lua).
nmap <Leader>rC <Leader>rc
vmap <Leader>rC <Leader>rc

" Changes the current word and all its occurrences.
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"
" A fallback if a LSP server is not available (see lspconfig.lua).
nmap <Leader>cC <Leader>cc
vmap <Leader>cC <Leader>cc

" Replace tabs with spaces.
nnoremap <Leader>rts :%s/	/    /g<CR>

" Remove ANSI color escape codes.
nnoremap <Leader>rac :%s/<C-v><Esc>\[\(\d\{1,2}\(;\d\{1,2}\)\{0,2\}\)\?[m\|K]//g<CR>

" Makes the current file executable.
" Based on http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
function! s:MakeFileExecutable()
	let fname = expand('%:p')
	checktime
	execute 'au FileChangedShell ' . fname . ' :echo'
	silent !chmod a+x %
	checktime
	execute 'au! FileChangedShell ' . fname
	" Fix display issues in terminal Vim.
	redraw!
endfunction
nnoremap <silent> <Leader>mfx :call <SID>MakeFileExecutable()<CR>

" Command aliases.
cnoreabbrev tn tabnew

" Command mistypes.
nnoremap :E :e
nnoremap :Q :q
nnoremap :Tn :tabnew
nnoremap :Cd :cd

" English typo corrections.
iabbrev centre center
iabbrev fro for
iabbrev recieve receive
iabbrev recieved received
iabbrev teh the
iabbrev hte the
]])
