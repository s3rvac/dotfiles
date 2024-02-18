"------------------------------------------------------------------------------
" General settings.
"------------------------------------------------------------------------------

" Keep a context (rows) when scrolling vertically.
set scrolloff=10
" Keep a context (columns) when scrolling horizontally.
set sidescroll=5
" Maximum number of tabs to open by the -p argument.
set tabpagemax=1000
" Don't redraw during complex operations (e.g. macros).
" TODO: Causes screen tearing / visual glitches?
" set lazyredraw
" Decrease updatetime (the time Vim waits after you stop typing before it
" triggers CursorHold autocommands) from the default 4 seconds, which is
" too long, to 1 second.
set updatetime=1000
" Automatically save before :next, :make etc.
set autowrite
" Ask to save file before operations like :q or :e fail.
set confirm
" Use 'magic' patterns (extended regular expressions).
set magic
" Allow switching edited buffers without saving.
set hidden
" Keep the cursor in the current column with page cmds.
set nostartofline
" Show (partial) command in the status line.
set showcmd
" Don't show matching brackets when typing them.
set noshowmatch
" Show the current mode.
set showmode
" Abbreviation of messages (avoids 'hit enter ...').
set shortmess+=aIoOtT
" Search in dir of the current file, cwd, and subdirs.
set path=.,,**
" Make incrementing 007 result into 008 rather than 010.
set nrformats-=octal

" ---- Line numbers ----

" Show line numbers.
set number
" Show relative numbers instead of absolute ones.
set relativenumber

" ---- Sign column ----

" Always show the sign column so that the whole screen does not move when there
" is a diagnostic message.
set signcolumn=yes:1

" ---- Whitespace ----

" Number of spaces a tab counts for.
set tabstop=4
" Number of spaces to use for each step of indent.
set shiftwidth=4
" Round indent to multiple of shiftwidth.
set shiftround
" Do not expand tab with spaces.
set noexpandtab
" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start
" Tell Vim which characters to show for expanded tabs, trailing whitespace,
" ends of lines, and non-breakable space.
set listchars=tab:>-,trail:#,eol:$,nbsp:~,extends:>,precedes:<

" ---- Backup and swap files ----

" Disable backup files.
set nobackup
" Disable swap files.
set noswapfile
" Disable auto backup before overwriting a file.
set nowritebackup

" ---- History ----

" Number of lines of command line history.
set history=1000
" Read/write a .viminfo file.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media
" Do not store searches.
set viminfo+=h

" ---- Undo ----

" Do not preserve undo history across Vim runs. I know that this can be very
" useful, but I currently find it annoying. Indeed, when I open a file, do some
" changes, and then hit undo a couple of times, I expect to end up in a state
" when the file was opened, not in a state e.g. a month ago.
set noundofile
" Number of undo levels.
set undolevels=1000

" ---- Splitting ----

" Open new vertical panes in the right rather than left.
set splitright
" Open new horizontal panes in the bottom rather than top.
set splitbelow

" ---- Security ----

" Forbid loading of .vimrc under $PWD.
set secure
" Modelines have been a source of vulnerabilities.
set nomodeline

" ---- Indention and formatting ----

" Indent a new line according to the previous one.
set autoindent
" Copy (exact) indention from the previous line.
set copyindent
" Do not try to preserve indention when indenting.
set nopreserveindent
" Turn off smartindent.
set nosmartindent
" Turn off C-style indent.
set nocindent
" Allow formatting of comments with `gq`.
set fo+=q
" Turn off automatic insertion of comment characters.
set fo-=r fo-=o
" Remove a comment leader when joining comment lines.
set fo+=j
" Turn off indention by filetype (I use custom settings for each filetype).
filetype indent off
" Override the previous settings for all file types (some filetype plugins set
" these options to different values, which is really annoying).
au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o fo+=j

" ---- Wrapping ----

" Enable text wrapping.
set wrap
" Break after words only.
set linebreak
" Allow arrows at the end/beginning of lines to move to the next/previous line.
set whichwrap+=<,>,[,]
" Show as much as possible from the last shown line.
set display+=lastline
" Don't automatically wrap lines.
set textwidth=0
" Disable automatic wrapping for all files (some filetype plugins set this to
" a different value, which is really annoying).
au FileType * set textwidth=0

" ---- Window title ----

" Set the window title. I need this in the Tmux configuration to determine
" whether Neovim is running or not.
set title

" ---- Tabline ----

" Display a tabline only if there are at least two tabs.
set showtabline=1
" Use a custom function that displays tab numbers in the tabline.
" Based on http://superuser.com/a/477221.
function! MyTabLine()
	let s = ''
	let wn = ''
	let t = tabpagenr()
	let i = 1
	while i <= tabpagenr('$')
		let buflist = tabpagebuflist(i)
		let winnr = tabpagewinnr(i)
		let s .= '%' . i . 'T'
		let s .= (i == t ? '%1*' : '%2*')
		let s .= ' '
		let wn = tabpagewinnr(i,'$')
		let s .= '%#TabNum#'
		let s .= i
		let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		let bufnr = buflist[winnr - 1]
		let file = bufname(bufnr)
		let buftype = getbufvar(bufnr, 'buftype')
		if buftype == 'nofile'
			if file =~ '\/.'
				let file = substitute(file, '.*\/\ze.', '', '')
			endif
		else
			" Shorten file name to include only first letters of each
			" directory.
			let file = pathshorten(file)
		endif
		if file == ''
			let file = '[No Name]'
		endif
		let s .= ' ' . file . ' '
		let i = i + 1
		" Add '[+]' if one of the buffers in the tab page is modified.
		for bufnr in buflist
			if getbufvar(bufnr, '&modified')
				let s .= '[+]'
				break
			endif
		endfor
	endwhile
	let s .= '%T%#TabLineFill#%='
	return s
endfunction
set tabline=%!MyTabLine()

" ---- Completion ----

set wildmenu
set wildchar=<Tab>
set wildmode=list:longest
" Ignore various binary/temporary files.
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg
" Ignore various version-control directories.
set wildignore+=.git,.svn,.hg
" Ignore various Python-related directories.
set wildignore+=*.egg-info,.mypy_cache,.pytest_cache,coverage,htmlcov,dist,venv,virtualenv
" Suffixes that get lower priority when doing tab completion for filenames.
" These files are less likely to be edited.
set suffixes=.bak,~,.swp,.o,.info,.aux,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" Options for the completion menu.
set completeopt=menu,menuone,longest
" Do not search in included/imported files (it slows down completion, mostly
" on network filesystems).
set complete-=i

" ---- Searching ----

" Highlight search matches.
set hlsearch
" Incremental search.
set incsearch
" Case-smart searching (make /-style searches case-sensitive only if there is
" a capital letter in the search expression).
set ignorecase
set smartcase

" ---- Sessions ----

set sessionoptions=curdir,folds,globals,tabpages

" ---- Folds ----

" Disable folds by default (i.e. automatically open all folds).
set nofoldenable

" ---- Bell ----

" Disable irritating bell sounds and indications.
set noerrorbells visualbell t_vb=
if has('gui_running')
	au GUIEnter * set visualbell t_vb=
endif

" ---- Encoding and end of line ----

" Default file encoding for new files.
setglobal fenc=utf-8
" Detect file encoding when opening a file and try to choose from the following
" encoding list (to check what file encoding was selected run `:set fenc`).
set fencs=ucs-bom,utf-8,cp1250,latin2,latin1
" Internal encoding used by Vim buffers, help and commands.
set enc=utf-8
" Terminal encoding used for input and terminal display.
set tenc=utf-8
" End of line. Unix EOL is preferred over the dos one and before the mac one.
set ffs=unix,dos,mac

" ---- Spell checking ----

" Disable spellchecking by default (F1 toggles it).
set nospell
" Language (use Shift+F1 to toggle between the Czech and English language).
set spelllang=en_us,en_gb
" Spellfile (can add/delete custom words to/from the dictionary) is enabled
" by default and stored into ~/.vim/spell/{spelllang}.{encoding}.add).

" ---- Graphical/terminal Vim ----

" Keep the cursor fat in all modes (including insert mode) and disable
" cursor blinking. Works both in GUI as well as in the terminal.
set guicursor=a:block,a:blinkon0

" Hide mouse cursor when editing.
set mousehide

if has('gui_running')
	" Enable mouse usage in the GUI.
	set mouse=a

	" GUI options:
	"  - aA: Enable autoselection.
	"  - c: Use console dialogs.
	"  - i: Use a Vim icon.
	" Menubar, toolbar, scrollbars etc. are disabled.
	set guioptions=aAci
" Vim in terminal.
else
	" Disable mouse usage in the terminal (I want to be able to select text via
	" terminal-provided facilities).
	set mouse=

	" Lower the timeout when entering normal mode from insert mode.
	set ttimeoutlen=0

	" Make some key combinations work when running Neovim in the terminal,
	" Tmux, and Midnight Commander.
	if exists('$TMUX')
		execute "set <xUp>=\e[1;*A"
		execute "set <xDown>=\e[1;*B"
		execute "set <xRight>=\e[1;*C"
		execute "set <xLeft>=\e[1;*D"
		execute "set <xHome>=\e[1;*H"
		execute "set <xEnd>=\e[1;*F"
		execute "set <Insert>=\e[2;*~"
		execute "set <Delete>=\e[3;*~"
		execute "set <PageUp>=\e[5;*~"
		execute "set <PageDown>=\e[6;*~"
		if exists('$MC_TMPDIR')
			" Running inside Midnight Commander.
			execute "set <F1>=\e[1;*P"
			execute "set <F2>=\e[1;*Q"
			execute "set <F3>=\e[1;*R"
			execute "set <F4>=\e[1;*S"
		else
			" Not running inside Midnight Commander.
			execute "set <xF1>=\e[1;*P"
			execute "set <xF2>=\e[1;*Q"
			execute "set <xF3>=\e[1;*R"
			execute "set <xF4>=\e[1;*S"
		endif
		execute "set <F5>=\e[15;*~"
		execute "set <F6>=\e[17;*~"
		execute "set <F7>=\e[18;*~"
		execute "set <F8>=\e[19;*~"
		execute "set <F9>=\e[20;*~"
		execute "set <F10>=\e[21;*~"
		execute "set <F11>=\e[23;*~"
		execute "set <F12>=\e[24;*~"
	else
		nmap <M-O>2P <S-F1>
		nmap <M-O>2Q <S-F2>
		nmap <M-O>2R <S-F3>
		nmap <M-O>2S <S-F4>
	endif
	nmap <F13> <S-F1>
	nmap <F14> <S-F2>
	nmap <F15> <S-F3>
	nmap <F16> <S-F4>
	nmap <F17> <S-F5>
	nmap <F18> <S-F6>
	nmap <F19> <S-F7>
	nmap <F20> <S-F8>
	nmap <F21> <S-F9>
	nmap <F22> <S-F10>
	nmap <F23> <S-F11>
	nmap <F24> <S-F12>
endif

"------------------------------------------------------------------------------
" Mappings, commands, and abbreviations.
"------------------------------------------------------------------------------

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
" The mapping is defined separately for each file type.

" Shift+F9: Run all tests.
" The mapping is defined separately for each file type.

" F10: Run the current script.
" The mapping is defined separately for each file type.

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
" The following mapping is needed in nvim-qt, which, without it, just emits
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
noremap <silent> J gT
noremap <silent> K gt

" Alt-# goes to the #th tab.
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt
if !has('gui_running')
	" Konsole sends <Esc># when pressing Alt-#.
	nnoremap <Esc>1 1gt
	nnoremap <Esc>2 2gt
	nnoremap <Esc>3 3gt
	nnoremap <Esc>4 4gt
	nnoremap <Esc>5 5gt
	nnoremap <Esc>6 6gt
	nnoremap <Esc>7 7gt
	nnoremap <Esc>8 8gt
	nnoremap <Esc>9 9gt
	nnoremap <Esc>0 10gt
endif

" Join lines by <Leader>j because I use J to go to the previous tab.
noremap <Leader>j J

" Make Y yank everything from the cursor to the end of the line.
" This makes Y act more like C or D because by default, Y yanks the current
" line (i.e. the same as yy).
noremap Y y$

" Close the opened HTML tag with Ctrl+_.
inoremap <silent> <C-_> </<C-x><C-o><C-x>

" Join lines without producing any spaces. It works like gJ, but does not keep
" the indentation whitespace.
" Based on http://vi.stackexchange.com/a/440.
function! s:JoinWithoutSpaces()
	normal! gJ
	" Remove any whitespace.
	if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
		normal! dw
	endif
endfunction
noremap <silent> <Leader>J :call <SID>JoinWithoutSpaces()<CR>

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

" Expand %% to the path of the current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Man pages.
" The nnoremap <Leader>man mapping is defined for every language separately.

" Wrap function arguments.
" Requires the vim-argwrap plugin (https://github.com/FooSoft/vim-argwrap).
nnoremap <silent> <Leader>wa :ArgWrap<CR>

" Check for changes in all buffers, automatically reload them, and redraw.
nnoremap <silent> <Leader>rr :set autoread <Bar> checktime <Bar> redraw! <Bar> set noautoread<CR>

" Replaces the current word (and all occurrences).
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/

" Changes the current word (and all occurrences).
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"

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
" Open help in a vertical window instead of in a horizontal window.
cnoreabbrev help vert help
" Translation. It uses https://github.com/soimort/translate-shell, which has to
" be available in $PATH under name 'trs'.
cnoreabbrev toen !trs cs:en
cnoreabbrev tocs !trs en:cs

" Command mistypes.
nnoremap :E :e
nnoremap :Q :q
nnoremap :Tn :tabnew

" English typo corrections.
iabbrev centre center
iabbrev fro for
iabbrev recieve receive
iabbrev recieved received
iabbrev teh the
iabbrev hte the

"------------------------------------------------------------------------------
" File-type specific settings and other autocommands.
"------------------------------------------------------------------------------

augroup file_types
au!
" Consider all .tpl files as Smarty files.
au BufNewFile,BufRead *.tpl setl ft=smarty
" Consider all .php* files (.phps, .phpt etc.) as PHP files.
au BufNewFile,BufRead *.php[0-9a-zA-Z] setl ft=php
" Consider all .ll files as LLVM IR files.
au BufNewFile,BufRead *.ll setl ft=llvm
" Consider all .wsgi files as Python files.
au BufNewFile,BufRead *.wsgi setl ft=python
" Use Vim highlighting when editing Tridactyl's configuration.
au BufNewFile,BufRead .tridactylrc setl ft=vim
" Use tex filetype rather than plaintex.
au BufNewFile,BufRead *.tex setl ft=tex
" Consider all .hql files as Hive files.
au BufNewFile,BufRead *.hql set ft=hive
" Consider all .yar/.yara files as YARA files.
au BufNewFile,BufRead *.yar,*.yara set filetype=yara
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
" Make "gq" on comments work properly.
au FileType c,cpp setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
" Search also in /usr/include.
au FileType c,cpp setl path+=/usr/include

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
au FileType tex,plaintex setl spell
augroup end

" LLVM
augroup llvm
au!
" Indentation settings.
au FileType llvm setl expandtab
au FileType llvm setl tabstop=2
au FileType llvm setl softtabstop=2
au FileType llvm setl shiftwidth=2

" Make "gq" on comments working properly.
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

" MySQL
augroup mysql
au!
" Make "gq" on comments work properly.
au FileType mysql setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:--
augroup end

" PHP
augroup php
au!
" Use <Leader>man to display manual pages for the function under cursor in a browser.
au FileType php nnoremap <buffer> <silent> <Leader>man :call <SID>OpenLink('http://php.net/'.expand('<cword>'))<CR>
" Make "gq" on comments work properly.
au FileType php setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://,:#
augroup end

" Python
augroup python
au!
" Indentation settings.
au FileType python setl expandtab
au FileType python setl tabstop=4
au FileType python setl softtabstop=4
au FileType python setl shiftwidth=4

" Let F10 run the currently opened script.
au FileType python nnoremap <buffer> <F10> :w<CR>:!clear; python %<CR>
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

"------------------------------------------------------------------------------
" Colors and syntax highlighting.
"------------------------------------------------------------------------------

" Highlight mixtures of spaces and tabs.
hi SpacesTabsMixture guifg=red guibg=gray19
" Highlight mixtures only when there are at least two successive spaces to
" prevent highlighting of false positives (e.g. in git diffs, which may begin
" with a space).
match SpacesTabsMixture /^  \+\t\+[\t ]*\|^\t\+  \+[\t ]*/

"------------------------------------------------------------------------------
" Plugin settings.
"------------------------------------------------------------------------------

"---------------------------------------------------------------------------
" AutoFenc: Automatically detects and sets file encoding when opening files.
"---------------------------------------------------------------------------
let g:autofenc_ext_prog_path='enca'
" I am from the Czech Republic, so assume that input files are in a
" Czech-specific encoding when running enca. This improves detection.
let g:autofenc_ext_prog_args='-i -L czech'
" This is what enca prints when the encoding cannot be detected.
let g:autofenc_ext_prog_unknown_fenc='???'
" Sometimes, enca detects UTF-7, which is almost always invalid detection.
let g:autofenc_enc_blacklist='utf-7'

"--------------------------------------------------------
" netrw: Network oriented reading, writing, and browsing.
"--------------------------------------------------------
" Disable the top banner.
let g:netrw_banner=0
" Tree-like view.
let g:netrw_liststyle=3
" Open splits to the right.
let g:netrw_altv=1
" Use a smaller window.
let g:netrw_winsize=25
" Do not perform any magic during sorting (like putting .h files together),
" except for listing directories first.
let g:netrw_sort_sequence='[\/]$'

"--------------------------------------
" targets.vim: Additional text objects.
"--------------------------------------
" When seeking, prefer multiline targets around the cursor over distant targets
" within the cursor line. This works better than the default setting when e.g.
" doing ci{ inside of a block on a line that also contains curly brackets (the
" expected behavior is to change the block, not seek to the curly brackets on
" the current line).
let g:targets_seekRanges = 'cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

"------------------------------------------------------------
" tcomment_vim: An extensible & universal comment vim-plugin.
"------------------------------------------------------------
" Disable leader commands as I don't use them.
let g:tcomment_mapleader1 = ''
let g:tcomment_mapleader2 = ''
" Do not comment blank lines.
let g:tcomment#blank_lines = 0

"-----------------------------
" UltiSnips: Snippets for Vim.
"-----------------------------
let g:snips_author='Petr Zemek <s3rvac@petrzemek.net>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsEnableSnipMate='no'
let g:UltiSnipsSnippetDirectories=[$HOME . '/.config/nvim/snippets']
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
nnoremap <Leader>sni :execute 'tabe ~/.config/nvim/snippets/' . &filetype . '.snippets'<CR>

" ---------------------------------------------------------
" vim-sort-motion: Vim mapping for sorting a range of text.
" ---------------------------------------------------------
" Remove duplicates while sorting.
let g:sort_motion_flags = 'u'

"------------------------------------------------------------------------------
" Projects.
"------------------------------------------------------------------------------

" Gen.
command! GenAddTimeDurations :%!~/bin/gen-add-time-durations

"-------------------------------------------------------------------------------
" Firefox 'Textern' plugin.
"-------------------------------------------------------------------------------

augroup firefox_textern_plugin
au!
let s:opened_file_path = expand('%:p')
if s:opened_file_path =~ 'textern-'
	" Enable Czech spell checking by default.
	au BufRead,BufNewFile *.txt setl spell
	au BufRead,BufNewFile *.txt setl spelllang=cs

	" stackoverflow.com
	if s:opened_file_path =~ 'stackoverflow.com'
		au BufRead,BufNewFile *.txt setl ft=markdown
		au BufRead,BufNewFile *.txt setl spelllang=en
	" github.com
	elseif s:opened_file_path =~ 'github.com'
		au BufRead,BufNewFile *.txt setl ft=markdown
		au BufRead,BufNewFile *.txt setl spelllang=en
	" cs-blog.petrzemek.net
	elseif s:opened_file_path =~ 'cs-blog.petrzemek.net'
		au BufRead,BufNewFile *.txt setl ft=xhtml
	" blog.petrzemek.net
	elseif s:opened_file_path =~ 'blog.petrzemek.net'
		au BufRead,BufNewFile *.txt setl ft=xhtml
		au BufRead,BufNewFile *.txt setl spelllang=en
	" petrzemek.net
	elseif s:opened_file_path =~ 'petrzemek.net'
		au BufRead,BufNewFile *.txt setl ft=xhtml
		au BufRead,BufNewFile *.txt setl spelllang=en
	" Other
	else
		au BufRead,BufNewFile *.txt setl ft=xhtml
	endif
endif
augroup end
