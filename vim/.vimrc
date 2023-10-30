"------------------------------------------------------------------------------
" File:     $HOME/.vimrc
" Author:   Petr Zemek <s3rvac@petrzemek.net>
"
" Based on http://www.hermann-uwe.de/files/vimrc.
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Pathogen (http://www.vim.org/scripts/script.php?script_id=2332).
"------------------------------------------------------------------------------

filetype off " Pathogen needs to run before 'plugin on'.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() " Generate helptags for everything in 'runtimepath'.
filetype plugin on

"------------------------------------------------------------------------------
" General.
"------------------------------------------------------------------------------

set nocompatible        " Disable vi compatibility.
set undolevels=200      " Number of undo levels.
set scrolloff=10        " Keep a context (rows) when scrolling vertically.
set sidescroll=5        " Keep a context (columns) when scrolling horizontally.
set tabpagemax=1000     " Maximum number of tabs to open by the -p argument.
set esckeys             " Cursor keys in insert mode.
set ttyfast             " Improves redrawing for newer computers.
set lazyredraw          " Don't redraw during complex operations (e.g. macros).
set autowrite           " Automatically save before :next, :make etc.
set confirm             " Ask to save file before operations like :q or :e fail.
set magic               " Use 'magic' patterns (extended regular expressions).
set hidden              " Allow switching edited buffers without saving.
set nostartofline       " Keep the cursor in the current column with page cmds.
set nojoinspaces        " Insert just one space joining lines with J.
set showcmd             " Show (partial) command in the status line.
set noshowmatch         " Don't show matching brackets when typing them.
set showmode            " Show the current mode.
set shortmess+=aIoOtT   " Abbreviation of messages (avoids 'hit enter ...').
set path=.,,**          " Search in dir of the current file, cwd, and subdirs.
set nrformats-=octal    " Make incrementing 007 result into 008 rather than 010.

" Backup and swap files.
set nobackup            " Disable backup files.
set noswapfile          " Disable swap files.
set nowritebackup       " Disable auto backup before overwriting a file.

" History
set history=1000        " Number of lines of command line history.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media " Read/write a .viminfo file.
set viminfo+=h          " Do not store searches.

" Line numbers.
set number              " Show line numbers.
set relativenumber      " Show relative numbers instead of absolute ones.

" Splitting.
set splitright          " Open new vertical panes in the right rather than left.
set splitbelow          " Open new horizontal panes in the bottom rather than top.

" Security.
set secure              " Forbid loading of .vimrc under $PWD.
set nomodeline          " Modelines have been a source of vulnerabilities.

" Indention and formatting.
set autoindent          " Indent a new line according to the previous one.
set copyindent          " Copy (exact) indention from the previous line.
set nopreserveindent    " Do not try to preserve indention when indenting.
set nosmartindent       " Turn off smartindent.
set nocindent           " Turn off C-style indent.
set fo+=q               " Allow formatting of comments with "gq".
set fo-=r fo-=o         " Turn off automatic insertion of comment characters.
set fo+=j               " Remove a comment leader when joining comment lines.
filetype indent off     " Turn off indention by filetype.
" Override the previous settings for all file types (some filetype plugins set
" these options to different values, which is really annoying).
au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o fo+=j

" Whitespace.
set tabstop=4           " Number of spaces a tab counts for.
set shiftwidth=4        " Number of spaces to use for each step of indent.
set shiftround          " Round indent to multiple of shiftwidth.
set noexpandtab         " Do not expand tab with spaces.

" Wrapping.
set wrap                " Enable text wrapping.
set linebreak           " Break after words only.
set display+=lastline   " Show as much as possible from the last shown line.
set textwidth=0         " Don't automatically wrap lines.
" Disable automatic wrapping for all files (some filetype plugins set this to
" a different value, which is really annoying).
au FileType * set textwidth=0

" Tabline.
set showtabline=1       " Display a tabline only if there are at least two tabs.
" Use a custom function that displays tab numbers in the tabline. Based on
" http://superuser.com/a/477221.
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

" Statusline.
set laststatus=2        " Always display a statusline.
set noruler             " Since I'm using a statusline, disable ruler.
set statusline=%<%f                          " Path to the file in the buffer.
set statusline+=\ %h%w%m%r%k                 " Flags (e.g. [+], [RO]).
set statusline+=\ [%{(&fenc\ ==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")},%{&ff}] " Encoding and line endings.
set statusline+=\ %y                         " File type.
set statusline+=\ [\%03.3b,0x\%02.2B,U+%04B] " Codes of the character under cursor.
set statusline+=\ [%l/%L\ (%p%%),%v]         " Line and column numbers.

" Tell Vim which characters to show for expanded tabs, trailing whitespace,
" ends of lines, and non-breakable space.
set listchars=tab:>-,trail:#,eol:$,nbsp:~,extends:>,precedes:<

" Allow arrows at the end/beginning of lines to move to the next/previous line.
set whichwrap+=<,>,[,]

" Path/file/command completion.
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

" Code completion.
set completeopt=longest,menuone
" Do not search in included/imported files (it slows down completion, mostly
" on network filesystems).
set complete-=i
" Enable omni completion.
set omnifunc=syntaxcomplete#Complete
" set tags=./tags,./TAGS,tags,TAGS

" Searching.
set hlsearch            " Highlight search matches.
set incsearch           " Incremental search.
" Case-smart searching (make /-style searches case-sensitive only if there is
" a capital letter in the search expression).
set ignorecase
set smartcase

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Sessions.
set sessionoptions=blank,buffers,curdir,globals,help,localoptions,resize,tabpages,winpos,winsize

" Disable folds by default (i.e. automatically open all folds).
set nofoldenable

" No bell sounds.
set noerrorbells visualbell t_vb=
if has('gui_running')
	au GUIEnter * set visualbell t_vb=
endif

" Encoding and end of line.
" Default file encoding for new files.
setglobal fenc=utf-8
" Detect file encoding when opening a file and try to choose from the following
" encoding list (to check what file encoding was selected run ":set fenc").
set fencs=ucs-bom,utf-8,cp1250,latin2,latin1
" Internal encoding used by Vim buffers, help and commands.
set enc=utf-8
" Terminal encoding used for input and terminal display.
set tenc=utf-8
" End of line (unix EOL is preferred over the dos one and before the mac one).
set ffs=unix,dos,mac

" Spellchecker.
" Disable spellchecking by default (F1 toggles it).
set nospell
" Language (use Shift+F1 to toggle between the Czech and English language).
set spelllang=en_us,en_gb
" Spellfile (can add/delete custom words to/from the dictionary) is enabled
" by default and stores into ~/.vim/spell/{spelllang}.{encoding}.add).

" Graphical Vim.
if has('gui_running')
	" Font.
	set guifont=Monospace\ 11

	" GUI options:
	"  - aA: Enable autoselection.
	"  - c: Use console dialogs.
	"  - i: Use a Vim icon.
	" Menubar, toolbar, scrollbars etc. are disabled.
	set guioptions=aAci

	" Leave no pixels around the GVim window.
	set guiheadroom=0

	" Enable mouse usage.
	set mouse=a

	" Hide mouse cursor when editing.
	set mousehide

	" Disable cursor blinking.
	set guicursor=a:blinkon0
" Vim in terminal.
else
	" Lower the timeout when entering normal mode from insert mode.
	set ttimeoutlen=0

	" Check for changes in files more often. This makes Vim in terminal behaves
	" more like GVim, although sadly not the same.
	augroup file_change_check
	au!
	au BufEnter * silent! checktime
	augroup end

	" Make some key combinations work when running Vim in Tmux.
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
	endif
endif

"------------------------------------------------------------------------------
" Colors.
"------------------------------------------------------------------------------

" Syntax highlighting.
syntax on

" Color scheme (my own scheme based on the standard 'koehler' color scheme).
" Thanks to the CSApprox plugin, I can use the same scheme in both the
" graphical and terminal Vims.
colorscheme s3rvac

" Highlight mixture of spaces and tabs.
hi SpacesTabsMixture guifg=red guibg=gray19
" Highlight mixtures only when there are at least two successive spaces to
" prevent highlighting of false positives (e.g. in git diffs, which may begin
" with a space).
match SpacesTabsMixture /^  \+\t\+[\t ]*\|^\t\+  \+[\t ]*/

"------------------------------------------------------------------------------
" Function keys.
"------------------------------------------------------------------------------

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

" F11: Make.
" The mapping is defined separately for each file type.

"------------------------------------------------------------------------------
" General-purpose commands.
"------------------------------------------------------------------------------

" Runs silently the given shell command.
command! -nargs=1 SilentExecute execute ':silent !' . <q-args> | execute ':redraw!'

" Opens multiple files at once.
" Usage example: Etabs dir/*.cpp
" Based on http://vim.wikia.com/wiki/Load_multiple_files_with_a_single_command.
command! -complete=file -nargs=+ Etabs call s:ETW('tabnew', <f-args>)
command! -complete=file -nargs=+ Ewindows call s:ETW('new', <f-args>)
command! -complete=file -nargs=+ Evwindows call s:ETW('vnew', <f-args>)
function! s:ETW(what, ...)
	for f1 in a:000
		let files = glob(f1)
		if files == ''
			execute a:what . ' ' . escape(f1, '\ "')
		else
			for f2 in split(files, '\n')
				execute a:what . ' ' . escape(f2, '\ "')
			endfor
		endif
	endfor
endfunction

" Opens all files in the quickfix window in buffers/tabs.
" Based on http://vimrcfu.com/snippet/143.
command! Cbufs call s:Copenall('edit')
command! Ctabs call s:Copenall('tabedit')
function! s:Copenall(edit_cmd)
	let files = {}
	for entry in getqflist()
		let filename = bufname(entry.bufnr)
		let files[filename] = 1
	endfor
	for file in keys(files)
		silent execute a:edit_cmd . ' ' . fnameescape(file)
	endfor
endfunction

"------------------------------------------------------------------------------
" Abbreviations and other mappings.
"------------------------------------------------------------------------------

" The leader and local-leader characters.
let mapleader = ','
let maplocalleader = ','

" General command aliases.
cnoreabbrev tn tabnew
" Open help in a vertical window instead of in a horizontal window.
cnoreabbrev help vert help
" Translation. It uses https://github.com/soimort/translate-shell, which has to
" be available in $PATH under name 'trs'.
cnoreabbrev toen !trs cs:en
cnoreabbrev tocs !trs en:cs

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

" Make Ctrl-e jump to the end of the line in the insert mode.
inoremap <C-e> <C-o>$

" Stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" Quickly select the text I just pasted.
noremap gV `[v`]

" Hitting space in normal/visual mode will make the current search disappear.
noremap <silent> <Space> :silent nohlsearch<CR>

" Insert the contents of the clipboard.
nnoremap <silent> <Leader>P :set paste<CR>"+]P:set nopaste<CR>
nnoremap <silent> <Leader>p :set paste<CR>"+]p:set nopaste<CR>
vnoremap          <Leader>p "+p

" Copy the selected text into the clipboard.
noremap <Leader>y "+y

" Cut the selected text into the clipboard.
noremap <Leader>d "+d

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

" Switch to the last active tab.
let g:last_tab = 1
au TabLeave * let g:last_tab = tabpagenr()
nmap <Leader>lt :execute 'tabnext ' . g:last_tab<CR>

" Show a list of buffers and initiate a moving into a buffer (type e.g. buffer
" number or name after pressing 'gb').
nnoremap <silent> gb :ls<CR>:b<Space>

" Join lines by <Leader>+j because I use J to go to the previous tab.
noremap <Leader>j J

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

" Make Y yank everything from the cursor to the end of the line.
" This makes Y act more like C or D because by default, Y yanks the current
" line (i.e. the same as yy).
noremap Y y$

" Close the opened HTML tag with Ctrl+_ (I do not use vim-closetag because it
" often fails with an error).
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

" Open a link under the cursor in a web browser (similar to gx, but faster).
let s:web_browser_path='/usr/bin/firefox'
function! s:OpenLinkUnderCursor()
	let curr_line = getline('.')
	let link = matchstr(curr_line, '\(http\|https\|ftp\|file\)://[^ )"]*')
	if link != ''
		execute ':silent !' . s:web_browser_path . ' ' . '"' . link . '"'
	endif
endfunction
nnoremap <silent> gl :call <SID>OpenLinkUnderCursor()<CR>

" A text object for the entire file ("a file").
onoremap af :<C-u>normal! ggVG<CR>

" Expand %% to the path of the current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Git leader commands.
" They require https://github.com/tpope/vim-fugitive.
noremap <Leader>gbl :Gblame<CR>

" Man pages.
" The nnoremap <Leader>man command is defined for every language separately.

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

" Short the hash under the cursor to 10 characters.
nnoremap <Leader>sh b10lde

" Format the current file (or the selected area) as JSON.
nnoremap <Leader>fj :%!python -m json.tool<CR>
vnoremap <Leader>fj :!python -m json.tool<CR>

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
nnoremap <Leader>mfx :call <SID>MakeFileExecutable()<CR>

" Opening files in tabs.
nnoremap <Leader>sni :execute 'tabe ~/.vim/snippets/' . &filetype . '.snippets'<CR>
nnoremap <Leader>bash :tabe ~/.bashrc<CR>
nnoremap <Leader>vim :tabe ~/.vimrc<CR>
" Open the corresponding BibTeX file. It is assumed that there is only a single
" .bib file.
nnoremap <Leader>bib :tabe *.bib<CR>

"------------------------------------------------------------------------------
" Plugins.
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

"------------------------------------
" vim-grepper: Helps you win at grep.
"------------------------------------
let g:grepper={}
" Use the quickfix window.
let g:grepper.quickfix=1
" Open the quickfix window after the search finishes.
let g:grepper.open=1
" Switch to the quickfix window after the search finishes.
let g:grepper.switch=1
" Show the prompt by default.
let g:grepper.prompt=1
" Supported tools (use 'git' before 'ag').
let g:grepper.tools=['git', 'ag', 'ack', 'grep', 'findstr', 'sift', 'pt']
" Works like /, but uses vim-grepper to do the searching.
nnoremap <Leader>/ :Grepper<CR>
" Works like *, but uses vim-grepper to do the searching.
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

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

"-----------------------------
" UltiSnips: Snippets for Vim.
"-----------------------------
let g:snips_author='Petr Zemek <s3rvac@petrzemek.net>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsEnableSnipMate='no'
let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/snippets']
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

"----------------------------------------
" python: Syntax highlighting for Python.
"----------------------------------------
let g:python_highlight_builtins=0
let g:python_highlight_exceptions=0
let g:python_highlight_doctests=1
let g:python_highlight_indent_errors=0 " I use my own highlighting of these.
let g:python_highlight_space_errors=0
let g:python_highlight_string_formatting=0
let g:python_highlight_string_format=0
let g:python_highlight_string_templates=0
let g:python_slow_sync=1
let g:python_print_as_function=1

"--------------------------------------
" rust.vim: Vim configuration for Rust.
"--------------------------------------
" I set Vim indentation and textwrap manually.
let g:rust_recommended_style=0
" Customize the syntax highlighting (the default one is too colorful for my
" taste).
hi def link rustDeriveTrait Normal
hi def link rustEnum        Normal
hi def link rustFuncCall    Normal
hi def link rustIdentifier  Normal
hi def link rustModPath     Normal
hi def link rustModPathSep  Normal
hi def link rustOperator    Normal
hi def link rustSigil       Normal
hi def link rustTrait       Normal

"-----------------------------------------
" Command-T: Fast file navigation for VIM.
"-----------------------------------------
let g:CommandTMaxCachedDirectories=0 " Do not limit caching.
let g:CommandTMatchWindowReverse=1 " Show the entries in reverse order.
let g:CommandTMaxHeight=10 " Show at most 10 matches.
hi CommandTHighlightColor guibg=darkblue guifg=white
let g:CommandTHighlightColor='CommandTHighlightColor' " Custom highlight color.
let g:CommandTTraverseSCM='pwd' " Use Vim's present working directory as the root.
let g:CommandTCancelMap=['<Esc>', '<C-c>'] " Keys to close the search window.

" ---------------------------------------------------------
" vim-sort-motion: Vim mapping for sorting a range of text.
" ---------------------------------------------------------
let g:sort_motion_flags = 'u' " Remove duplicates while sorting.

" -----------------------------------------------------
" vim-mail-refs: Adding references when writing emails.
" -----------------------------------------------------
augroup vim_mail_refs
au!
au FileType mail nnoremap <buffer> <Leader>ar :AddMailRef<CR>
au FileType mail nnoremap <buffer> <Leader>aR :AddMailRefFromMenu<CR>
au FileType mail nnoremap <buffer> <Leader>fr :FixMailRefs<CR>
augroup end

"---------
" xmledit.
"---------
let g:xml_tag_completion_map = '<C-l>'

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
" Disable leader commands (I don't use them).
let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''
" Do not comment blank lines.
let g:tcomment#blank_lines = 0
" Custom comment types.
call tcomment#DefineType('c', tcomment#GetLineC('// %s'))
call tcomment#DefineType('gdb', '# %s')
call tcomment#DefineType('llvm', '; %s')
call tcomment#DefineType('yara', tcomment#GetLineC('// %s'))

"------------------------------------------------------------------------------
" File-type specific settings and other autocommands.
"------------------------------------------------------------------------------

augroup trailing_whitespace
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
" trailing whitespace (sometimes, this is handy).
command! W :set eventignore=BufWritePre | w | set eventignore=""
augroup end

augroup file_types
au!
" Consider all .tpl files as Smarty files.
au BufNewFile,BufRead *.tpl setl ft=smarty
" Consider all .php* files (.phps, .phpt etc.) as PHP files.
au BufNewFile,BufRead *.php[0-9a-zA-Z] setl ft=php
" Consider all .ll files as LLVM IR files.
au BufNewFile,BufRead *.ll setl ft=llvm
" Consider all .dsm files as files containing disassembly from the retdec.com
" decompilation service.
au BufNewFile,BufRead *.dsm setl ft=retdecdsm
" Consider all .yar/.yara files as YARA files.
au BufNewFile,BufRead *.yar,*.yara setl ft=yara
" Consider all .wsgi files as Python files.
au BufNewFile,BufRead *.wsgi setl ft=python
" Use Vim highlighting when editing Tridactyl's configuration.
au BufNewFile,BufRead .tridactylrc setl ft=vim
" Use tex filetype rather than plaintex.
au BufNewFile,BufRead *.tex setl ft=tex
" Consider all .hql files as Hive files.
au BufNewFile,BufRead *.hql set ft=hive
" Use mysql filetype rather than sql.
au BufNewFile,BufRead *.sql setl ft=mysql
augroup end

" C and C++
augroup c_cpp
au!
" Use the man ftplugin to display pages from manual.
au FileType c,cpp runtime ftplugin/man.vim
" Use <Leader>man to display manual pages for the function under cursor.
au FileType c,cpp nnoremap <buffer> <silent> <Leader>man :Man 3 <cword><CR>
" Use astyle for = command indention.
au FileType c,cpp execute 'setl equalprg=astyle\ --mode=c\ --options=' . $HOME . '/.vim/astyle/c-cpp.options'
" Make "gq" on comments work properly.
au FileType c,cpp setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
" Go to includes.
au FileType c,cpp nnoremap <buffer> <Leader>inc /^#include <<CR>:nohlsearch<CR>:echo<CR>
au FileType c,cpp nnoremap <buffer> <Leader>Inc /^#include "<CR>:nohlsearch<CR>:echo<CR>
" Search also in /usr/include.
au FileType c,cpp setl path+=/usr/include

" Open both a .c|cpp|cc file and the corresponding .h file in a new tab.
function! s:GetCFile(base_name)
	" a:base_name should end with a dot (".")
	if filereadable(a:base_name . 'cc')
		return a:base_name . 'cc'
	elseif filereadable(a:base_name . 'cpp')
		return a:base_name . 'cpp'
	else
		return a:base_name . 'c'
	endif
endfunction
function! s:OpenCAndHInNewTab(base_name)
	if a:base_name =~ '\.h$'
		let h_file = a:base_name
		let c_file = s:GetCFile(substitute(a:base_name, '\\.h$', '.', ''))
	elseif a:base_name =~ '\.cc$'
		let h_file = substitute(a:base_name, '\.cc$', '.h', '')
		let c_file = a:base_name
	elseif a:base_name =~ '\.cpp$'
		let h_file = substitute(a:base_name, '\.cpp$', '.h', '')
		let c_file = a:base_name
	elseif a:base_name =~ '\.c$'
		let h_file = substitute(a:base_name, '\.c$', '.h', '')
		let c_file = a:base_name
	elseif a:base_name =~ '\.$'
		let h_file = a:base_name . 'h'
		let c_file = s:GetCFile(a:base_name)
	else
		let h_file = a:base_name . '.h'
		let c_file = s:GetCFile(a:base_name . '.')
	endif
	if filereadable(c_file)
		if filereadable(h_file)
			execute 'tabnew ' . c_file
			execute 'vsplit ' . h_file
		else
			execute 'tabnew ' . c_file
		endif
	elseif filereadable(h_file)
		execute 'tabnew ' . h_file
	else
		echo 'No file to open.'
	endif
endfunction
au FileType c,cpp command! -nargs=1 -complete=file TN :call s:OpenCAndHInNewTab(<q-args>)

" Splits the current window by showing the .{c,cc,cpp} file on the left-hand
" side and the corresponding .h file on the right-hand side.
function! s:SplitCOrHFile()
	if bufname('') =~ '\.\(cpp\|cc\|c\)$'
		let c_file = bufname('')
		let h_file = substitute(bufname(''), '\.\(cpp\|cc\|c\)$', '.h', '')
		if filereadable(h_file)
			execute 'edit ' . c_file
			execute 'vsplit ' . h_file
		else
			echo 'The corresponding .h file does not exist.'
		endif
	elseif bufname('') =~ '\.h$'
		let h_file = bufname('')
		let c_file = s:GetCFile(substitute(bufname(''), '\.h$', '.', ''))
		if filereadable(c_file)
			execute 'edit ' . c_file
			execute 'vsplit ' . h_file
		else
			echo 'The corresponding .{c,cc,cpp} file does not exist.'
		endif
	else
		echo 'There is no corresponding source file.'
	endif
endfunction
au FileType c,cpp nnoremap <buffer> <Leader>as :call <SID>SplitCOrHFile()<CR>

" Alternates between a .{c,cc,cpp} file and a .h file.
function! s:AlternateCOrHFile()
	if bufname('') =~ '\.\(cpp\|cc\|c\)$'
		let h_file = substitute(bufname(''), '\.\(cpp\|cc\|c\)$', '.h', '')
		if filereadable(h_file)
			execute 'edit ' . h_file
		else
			echo 'The corresponding .h file does not exist.'
		endif
	elseif bufname('') =~ '\.h$'
		let c_file = s:GetCFile(substitute(bufname(''), '\.h$', '.', ''))
		if filereadable(c_file)
			execute 'edit ' . c_file
		else
			echo 'The corresponding .{c,cc,cpp} file does not exist.'
		endif
	else
		echo 'There is no corresponding source file.'
	endif
endfunction
au FileType c,cpp nnoremap <buffer> <Leader>ac :call <SID>AlternateCOrHFile()<CR>

" Re-formatting via `clang-format`.
au FileType c,cpp nnoremap <buffer> <silent> <Leader>rf :%!clang-format --style=file<CR>

" Let F10 compile and run the currently edited code
" (F10 -> use GCC, S-F10 -> use Clang).
au FileType c nnoremap <buffer> <F10> :w<CR>:!clear; gcc -std=c11 -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
au FileType c nnoremap <buffer> <S-F10> :w<CR>:!clear; clang -std=c11 -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
au FileType cpp nnoremap <buffer> <F10> :w<CR>:!clear; g++ -std=c++1z -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
au FileType cpp nnoremap <buffer> <S-F10> :w<CR>:!clear; clang++ -std=c++1z -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out; rm -f /tmp/a.out<CR>
augroup end

" PHP
augroup php
au!
" Use <Leader>man to display manual pages for the function under cursor in a browser.
au FileType php nnoremap <buffer> <silent> <Leader>man :call <SID>OpenLink('http://php.net/'.expand('<cword>'))<CR>
" Make "gq" on comments work properly.
au FileType php setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://,:#
augroup end

" LaTeX
augroup latex
au!
au FileType tex,plaintex setl spell    " Enable spell checking.
" Compilation. Requires the LaTeX-Box plugin.
" After the command finishes, the quickfix window is opened. In such a case,
" move to the original window.
au FileType tex,plaintex nnoremap <buffer> <F11> :wa<CR>:Latexmk<CR><C-w><Up>
augroup end

" Shell
augroup sh
au!
" Let F10 run the currently opened script.
au FileType sh nnoremap <buffer> <F10> :w<CR>:!clear; sh %<CR>
augroup end

" MySQL
augroup mysql
au!
" Make "gq" on comments work properly.
au FileType mysql setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:--
augroup end

" Kotlin
augroup kotlin
au!
au FileType kotlin setl expandtab     " Use spaces instead of tabs.
au FileType kotlin setl tabstop=4     " A tab counts for 4 spaces.
au FileType kotlin setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType kotlin setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" Python
augroup python
au!
" The following settings are based on these guidelines:
"  - python.org/dev/peps/pep-0008
au FileType python setl expandtab     " Use spaces instead of tabs.
au FileType python setl tabstop=4     " A tab counts for 4 spaces.
au FileType python setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType python setl shiftwidth=4  " Shift by 4 spaces.

" Go to imports.
au FileType python nnoremap <buffer> <Leader>im /^\(from\\|import\) <CR>:nohlsearch<CR>:echo<CR>

" Let F9 run the currently opened tests.
au FileType python nnoremap <buffer> <F9> :wa<CR>:!clear; nosetests %<CR>

" Let Shift+F9 run all tests.
au FileType python nnoremap <buffer> <S-F9> :wa<CR>:!clear; nosetests tests<CR>

" Let F10 run the currently opened script.
au FileType python nnoremap <buffer> <F10> :w<CR>:!clear; python %<CR>

" Splits the current window by showing the corresponding test file on the
" right-hand side.
function! s:ShowPythonTestsInSplit()
	" For e.g. main_package/subpackage/module.py, the tests are in
	" tests/subpackage/module_tests.py (a convention that I use in my
	" projects).
	let module_rel_path = expand('%')
	let tests_rel_path = substitute(module_rel_path, '\.\py$', '_tests.py', '')
	let tests_rel_path = substitute(tests_rel_path, '^[^/]*/', 'tests/', '')
	execute 'vsplit ' . tests_rel_path
endfunction
" The mapping is mimicking <Leader>as for c,cpp.
au FileType python nnoremap <buffer> <Leader>as :call <SID>ShowPythonTestsInSplit()<CR>
augroup end

" Rust
augroup rust
au!
" The following settings are based on these guidelines:
"  - https://github.com/rust-lang/rust/tree/master/src/doc/style
au FileType rust setl expandtab     " Use spaces instead of tabs.
au FileType rust setl tabstop=4     " A tab counts for 4 spaces.
au FileType rust setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType rust setl shiftwidth=4  " Shift by 4 spaces.

" Let F9 compile and run tests for the current project.
au FileType rust nnoremap <buffer> <F10> :w<CR>:!clear; cargo test<CR>

" Let F10 compile and run the current project.
au FileType rust nnoremap <buffer> <F10> :w<CR>:!clear; cargo run<CR>

" Re-formatting via `RustFmt` from the rust.vim plugin.
au FileType rust nnoremap <buffer> <silent> <Leader>rf :RustFmt<CR>
augroup end

" Go
augroup go
au!
" The default indentation settings are fine (Go uses tabs).

" Re-format via `gofmt`.
au FileType go nnoremap <buffer> <silent> <Leader>rf
	\ :w <Bar>
	\ set autoread <Bar>
	\ SilentExecute gofmt -w % <Bar>
	\ set noautoread<CR>

" Let F10 compile and run the current file.
au FileType go nnoremap <buffer> <F10> :w<CR>:!clear; go run %<CR>
augroup end

" Ruby
augroup ruby
au!
" The following settings are based on these guidelines:
"  - https://raw.github.com/chneukirchen/styleguide/master/RUBY-STYLE
au FileType ruby setl expandtab     " Use spaces instead of tabs.
au FileType ruby setl tabstop=2     " A tab counts for 2 spaces.
au FileType ruby setl softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType ruby setl shiftwidth=2  " Shift by 2 spaces.

" Let F10 run the currently opened script.
au FileType ruby nnoremap <buffer> <F10> :w<CR>:!clear; ruby %<CR>
augroup end

" Haskell
augroup haskell
au!
" The following settings are based on these guidelines:
"  - https://github.com/tibbe/haskell-style-guide/blob/master/haskell-style.md
"  - http://urchin.earth.li/~ian/style/haskell.html
"  - http://cs.caltech.edu/courses/cs11/material/haskell/misc/haskell_style_guide.html
au FileType haskell setl expandtab     " Use spaces instead of tabs.
au FileType haskell setl tabstop=4     " A tab counts for 4 spaces.
au FileType haskell setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType haskell setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" Hive
augroup hive
au!
au FileType hive setl expandtab     " Use spaces instead of tabs.
au FileType hive setl tabstop=4     " A tab counts for 4 spaces.
au FileType hive setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType hive setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" JavaScript
augroup javascript
au!
" Additional syntax highlighting that is missing in the original syntax file.
au FileType javascript syn keyword javaScriptOperator of
augroup end

" LLVM
augroup llvm
au!
au FileType llvm setl expandtab     " Use spaces instead of tabs.
au FileType llvm setl tabstop=2     " A tab counts for 2 spaces.
au FileType llvm setl softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType llvm setl shiftwidth=2  " Shift by 2 spaces.
" Make "gq" on comments working properly.
au FileType llvm setl comments=bO:;
augroup end

" Git commits
augroup gitcommit
au!
au FileType gitcommit setl spell         " Enable spellchecking.
au FileType gitcommit setl expandtab     " Use spaces instead of tabs.
au FileType gitcommit setl tabstop=4     " A tab counts for 4 spaces.
au FileType gitcommit setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType gitcommit setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" YAML
augroup yaml
au!
au FileType yaml setl expandtab     " Use spaces instead of tabs.
au FileType yaml setl tabstop=2     " A tab counts for 2 spaces.
au FileType yaml setl softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType yaml setl shiftwidth=2  " Shift by 2 spaces.

" Reformat via `yq`.
au FileType yaml nnoremap <buffer> <silent> <Leader>rf
	\ :w <Bar>
	\ set autoread <Bar>
	\ SilentExecute yq --inplace % <Bar>
	\ set noautoread<CR>
augroup end

" Dokuwiki
augroup dokuwiki
au!
au FileType dokuwiki setl spell         " Enable spell checking.
au FileType dokuwiki setl expandtab     " Use spaces instead of tabs.
au FileType dokuwiki setl tabstop=2     " Lists are indented with 2 spaces.
au FileType dokuwiki setl softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType dokuwiki setl shiftwidth=2  " Shift by 2 spaces.
augroup end

" reStructured Text
augroup rst
au!
au FileType rst setl spell         " Enable spellchecking.
au FileType rst setl expandtab     " Use spaces instead of tabs.
au FileType rst setl tabstop=4     " A tab counts for 4 spaces.
au FileType rst setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType rst setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" Markdown
augroup markdown
au!
au FileType markdown setl spell         " Enable spellchecking.
au FileType markdown setl expandtab     " Use spaces instead of tabs.
au FileType markdown setl tabstop=4     " Lists are indented with 4 spaces.
au FileType markdown setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType markdown setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" Mail
augroup mail
au!
au FileType mail setl spell         " Enable spellchecking.
au FileType mail setl spelllang=cs
au FileType mail setl expandtab     " Use spaces instead of tabs.
augroup end

" INI files
" I dislike the change in the original syntax/dosini.vim file that caused
" values to be highlighted as strings. I want them to be highlighted as regular
" text (the original highlighting).
hi def link dosiniValue Normal

" Terraform
augroup terraform
au!
au FileType terraform setl expandtab     " Use spaces instead of tabs.
au FileType terraform setl tabstop=2     " A tab counts for 2 spaces.
au FileType terraform setl softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType terraform setl shiftwidth=2  " Shift by 2 spaces.

" Reformat (via the vim-terraform plugin).
au FileType terraform nnoremap <buffer> <silent> <Leader>rf
	\ :w <Bar>
	\ TerraformFmt<CR>
augroup end

" Terragrunt (.hcl)
augroup hcl
au!
au FileType hcl setl expandtab     " Use spaces instead of tabs.
au FileType hcl setl tabstop=2     " A tab counts for 2 spaces.
au FileType hcl setl softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType hcl setl shiftwidth=2  " Shift by 2 spaces.

" Reformat via `terragrunt hclfmt`.
au FileType hcl nnoremap <buffer> <silent> <Leader>rf
	\ :w <Bar>
	\ set autoread <Bar>
	\ SilentExecute terragrunt hclfmt %<Bar>
	\ set noautoread<CR>
augroup end
"-------------------------------------------------------------------------------
" Firefox "Textern" plugin.
"-------------------------------------------------------------------------------

augroup firefox_textern_plugin
au!
let s:opened_file_path = expand('%:p')
if s:opened_file_path =~ 'textern-'
	" Enable Czech spell checking by default.
	au BufRead,BufNewFile *.txt setl spell
	au BufRead,BufNewFile *.txt setl spelllang=cs

	" GitHub
	if s:opened_file_path =~ 'github.com'
		au BufRead,BufNewFile *.txt setl ft=markdown
		au BufRead,BufNewFile *.txt setl spelllang=en
	" Stack Overflow
	elseif s:opened_file_path =~ 'stackoverflow.com'
		au BufRead,BufNewFile *.txt setl ft=markdown
		au BufRead,BufNewFile *.txt setl spelllang=en
	" Other
	else
		au BufRead,BufNewFile *.txt setl ft=html
	endif
endif
augroup end

"------------------------------------------------------------------------------
" Typos correction.
"------------------------------------------------------------------------------

" English.
iabbrev centre center
iabbrev fro for
iabbrev fucntion function
iabbrev recieve receive
iabbrev recieved received
iabbrev teh the
iabbrev hte the

" Command mistypes.
nnoremap :E :e
nnoremap :Q :q
nnoremap :Set :set
nnoremap :Vsp :vsp
nnoremap :Tn :tabnew

"------------------------------------------------------------------------------
" Local settings.
"------------------------------------------------------------------------------

" Source a local configuration file if available.
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif
