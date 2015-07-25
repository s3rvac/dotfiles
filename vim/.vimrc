"------------------------------------------------------------------------------
" File:     $HOME/.vimrc
" Author:   Petr Zemek <s3rvac@gmail.com>
" Encoding: utf-8
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
set textwidth=0         " Don't wrap words.
set scrolloff=10        " Keep a context (rows) when scrolling vertically.
set sidescroll=5        " Keep a context (columns) when scrolling horizontally.
set tabpagemax=1000     " Maximum number of tabs to open by the -p argument.
set esckeys             " Cursor keys in insert mode.
set ttyfast             " Improves redrawing for newer computers.
set autowrite           " Automatically save before :next, :make etc.
set confirm             " Ask to save a file when operations like :q or :e fail.
set magic               " Use 'magic' patterns (extended regular expressions).
set hidden              " Allow switching edited buffers without saving.
set nostartofline       " Keep the cursor in the current column with page cmds.
set nojoinspaces        " Insert just one space joining lines with J.
set showcmd             " Show (partial) command in the status line.
set noshowmatch         " Don't show matching brackets when typing them.
set showmode            " Show the current mode.
set shortmess+=aIoOtT   " Abbreviation of messages (avoids 'hit enter ...').
set path=$PWD/**        " Include all directories/files under $PWD into the path.
set nrformats-=octal    " Make incrementing 007 result into 008 rather than 010.

" Backup and swap files.
" Store temporary files in a central spot.
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set nobackup            " Disable backup.
set noswapfile          " Disable swap files.
set nowritebackup       " Disable auto backup before overwriting a file.

" History
set history=1000        " Number of lines of command line history.
" Read/write a .viminfo file.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media
" Do not store searches.
set viminfo+=h

" Line numbers.
set number              " Show line numbers.
set relativenumber      " Show relative numbers instead of absolute by default.

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
" Override previous settings for all file types (I have to do this because
" the previous commands don't guarantee this...).
au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o fo+=j

" Whitespace.
set tabstop=4           " Number of spaces <tab> counts for.
set shiftwidth=4        " Number of spaces to use for each step of indent.
set shiftround          " Round indent to multiple of shiftwidth.
set noexpandtab         " Do not expand tab with spaces.

" Wrapping.
set wrap                " Enable text wrapping.
set linebreak           " Break after words only.
set display+=lastline   " Show as much as possible from the last shown line.

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
			if getbufvar(bufnr, "&modified")
				let s .= '[+]'
				break
			endif
		endfor
	endwhile
	let s .= '%T%#TabLineFill#%='
	return s
endfunction
set tabline=%!MyTabLine()
highlight link TabNum Special

" Statusline.
set noruler             " Since I'm using a statusline, disable ruler.
set laststatus=2        " Always display a statusline.
set statusline=%<%f                          " Path to the file in the buffer.
set statusline+=\ %h%w%m%r%k                 " Flags (e.g. [+], [RO]).
set statusline+=\ [%{(&fenc\ ==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")},%{&ff}] " Encoding and line endings.
set statusline+=\ %y                         " File type.
set statusline+=\ [\%03.3b,0x\%02.2B,U+%04B] " Codes of the character under cursor.
set statusline+=\ [%l/%L\ (%p%%),%v]         " Line and column numbers.

" Tell Vim which characters to show for expanded TABs, trailing whitespace,
" ends of lines, and non-breakable space.
set listchars=tab:>-,trail:#,eol:$,nbsp:~,extends:>,precedes:<

" Allow arrows at the end/beginning of lines to move to the next/previous line.
set whichwrap+=<,>,[,]

" Path/file/command completion.
set wildmenu
set wildchar=<tab>
set wildmode=list:longest
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg,.git,.svn
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Code completion.
set completeopt=longest,menuone
" Do not search in included/imported files (this slows down completion, mostly
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

" Disable folds.
set nofoldenable

" No bell sounds.
set noerrorbells visualbell t_vb=
au GUIEnter * set visualbell t_vb=

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
if has("gui_running")
	" Font.
	set guifont=Monospace\ 10.5

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
	au BufEnter * silent! checktime

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

" Color scheme. Thanks to the CSApprox plugin, we may use the same scheme in
" both graphical and terminal Vims.
colorscheme koehler

" Use a dark background.
set background=dark

" Highlight mixture of spaces and tabs.
au BufEnter * hi SpacesTabsMixtureGroup guibg=gray18 guifg=red ctermbg=darkgray ctermfg=red
au BufEnter * match SpacesTabsMixtureGroup /^ \+\t\+\|^\t\+ \+/

" Statusline.
au BufEnter * hi StatusLine guibg=black guifg=white ctermbg=black ctermfg=white
au BufEnter * hi StatusLineNC guibg=black guifg=gray70 ctermbg=black ctermfg=gray

" Characters exceeding textwidth or 80 characters.
au BufEnter * hi ExceedCharsGroup guibg=darkblue guifg=white ctermbg=darkblue ctermfg=white

" Wild menu.
au BufEnter * hi Pmenu guibg=gray30 guifg=white ctermbg=darkgray ctermfg=white
au BufEnter * hi PmenuSel guibg=white guifg=black ctermbg=white ctermfg=black

" Folds.
au BufEnter * hi Folded guibg=gray30 guifg=white ctermbg=gray ctermfg=white
au BufEnter * hi FoldColumn guibg=gray30 guifg=white ctermbg=gray ctermfg=white

" Tab colors.
au BufEnter * hi TabLine guibg=black guifg=gray ctermbg=black ctermfg=gray
au BufEnter * hi TabLineSel guibg=black guifg=white ctermbg=black ctermfg=white
au BufEnter * hi TabLineFill guibg=black guifg=black ctermbg=black ctermfg=black

" Messages.
au BufEnter * hi MoreMsg guibg=black guifg=green1 ctermbg=black ctermfg=46

" Splits.
au BufEnter * hi VertSplit guibg=white guifg=black ctermbg=white ctermfg=black

" Cursor.
au BufEnter * hi Cursor guibg=white guifg=bg

" Visual selection.
au BufEnter * hi Visual guibg=black guifg=gray ctermfg=gray

" Use the same color in the signs column as it is used in the numbers column.
au BufEnter * hi clear SignColumn

"------------------------------------------------------------------------------
" Function keys.
"------------------------------------------------------------------------------

" F1: Toggle spell checker.
nnoremap <silent> <F1>
	\ :if &spell == 0 <Bar>
	\   set spell <Bar>
	\   echo 'spell checking: enabled' <Bar>
	\ else <Bar>
	\   set nospell <Bar>
	\   echo 'spell checking: disabled' <Bar>
	\ endif <CR>

" Shift+F1: Toggle English/Czech spell dictionary.
nnoremap <silent> <S-F1>
	\ :if &spelllang =~ 'en' <Bar>
	\   set spelllang=cs <Bar>
	\ else <Bar>
	\   set spelllang=en_us,en_gb <Bar>
	\ endif <Bar>
	\ echo 'spelllang: '.&spelllang <CR>

" F2: Toggle the display of unprintable characters.
nnoremap <silent> <F2> :set list!<CR>

" Shift+F2: Toggle highlighting characters exceeding textwidth or 80 characters.
nnoremap <silent> <S-F2>
	\ :if exists('w:long_line_match') <Bar>
	\   silent! call matchdelete(w:long_line_match) <Bar>
	\   unlet w:long_line_match <Bar>
	\ elseif &textwidth > 0 <Bar>
	\   let w:long_line_match=matchadd('ExceedCharsGroup', '\%>'.&tw.'v.\+', -1) <Bar>
	\ elseif exists('mytextwidth') <Bar>
	\   let w:long_line_match=matchadd('ExceedCharsGroup', '\%>'.mytextwidth.'v.\+', -1) <Bar>
	\ else <Bar>
	\   let w:long_line_match=matchadd('ExceedCharsGroup', '\%>80v.\+', -1) <Bar>
	\ endif <CR>

" F3: Toggle line wrapping.
nnoremap <silent> <F3> :set nowrap!<CR>:set nowrap?<CR>

" F4: Toggle hexdump view of binary files.
function! <SID>ToggleHexdumpView()
	if (&filetype == 'xxd')
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
function! <SID>ToggleObjdumpView()
	if (&filetype == 'objdump')
		" Turn off objdump view.
		" Replace the buffer with the original content of the buffer, stored in
		" the Z register.
		normal ggVG"ZP
		set filetype=
		set noreadonly
	else
		" Turn on objdump view.
		" Cut the original content of the buffer into the Z register so we can
		" use it later to restore the original content.
		normal ggVG"Zd
		" Get the output from objdump and paste it into the buffer.
		silent! :read !objdump -S %
		" Go to the beginning of the file.
		normal ggdd
		" Set a proper file type to enable syntax highlighting through
		" http://www.vim.org/scripts/script.php?script_id=530.
		set filetype=objdump
		" Prevent accidental overwrites.
		set readonly
	endif
endfunction
nnoremap <silent> <S-F4> :call <SID>ToggleObjdumpView()<CR>

" F5: Refresh file.
nnoremap <silent> <F5> :edit!<CR>

" F6: Toggle relative/absolute numbers.
function! <SID>RelAbsNumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunction
nnoremap <silent> <F6> :call <SID>RelAbsNumberToggle()<CR>

" F9: Run tests for the given file.
" The mapping is defined separately for each file type.

" Shift+F9: Run all tests.
" The mapping is defined separately for each file type.

" F10: Run the current script.
" The mapping is defined separately for each file type.

" F11: Quickfix.
" Executes :make and opens the quickfix windows if there is an error.
nnoremap <F11> mp :echo 'Making...' <Bar> silent make <Bar> botright cw<CR><C-w><Up>

"------------------------------------------------------------------------------
" General-purpose commands.
"------------------------------------------------------------------------------

" Runs silently the given shell command.
command! -nargs=1 SilentExecute execute ':silent !' . <q-args> | execute ':redraw!'

"------------------------------------------------------------------------------
" Abbreviations and other mappings.
"------------------------------------------------------------------------------

" The <Leader> character.
let mapleader = ","
let maplocalleader = ","

" General command aliases.
cnoreabbrev tn tabnew
" Translation. It uses https://github.com/soimort/translate-shell, which has to
" be available in $PATH under name 'trs'.
cnoreabbrev toen !trs cs:en
cnoreabbrev tocs !trs en:cs

" Quit with Q instead of :q!.
noremap <silent> Q :q!<CR>

" Quicksave all buffers/tabs.
" (Use both :w and :wa to force write of the currently edited buffer, even if
" there are no changes. This forces removal of trailing whitespace from the
" buffer and also overwrites of the file even if it has changed, which is
" sometimes handy.)
nnoremap <silent> <C-s> :w<CR>:wa<CR>
inoremap <silent> <C-s> <Esc>:w<CR><Esc>:wa<CR>
vnoremap <silent> <C-s> <Esc>:w<CR><Esc>:wa<CR>

" Make Ctrl-e jump to the end of the line in the insert mode.
inoremap <C-e> <C-o>$

" Stay in visual mode when indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" Quickly select the text you just pasted.
noremap gV `[v`]

" Hitting space in normal mode will make the current search disappear.
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

" Open help in a vertical window on the right side.
noremap :help :vert bo help

" Disable arrows until I properly learn to use hjkl.
noremap <Down> <nop>
inoremap <Down> <nop>
noremap <Left> <nop>
inoremap <Left> <nop>
noremap <Up> <nop>
inoremap <Up> <nop>
noremap <Right> <nop>
inoremap <Right> <nop>

" Make j and k move by virtual lines instead of physical lines, but only when
" not used in the count mode (e.g. 3j). This is great when 'wrap' and
" 'relativenumber' are used.
" Based on http://stackoverflow.com/a/21000307/2580955
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')

" Jump between tabs by J/K.
noremap <silent> <S-j> gT
noremap <silent> <S-k> gt

" Join lines by <Leader>+j because I use J to go to the previous tab.
noremap <Leader>j <S-j>

" Join lines without producing any spaces. It works like gJ, but does not keep
" the indentation whitespace.
" Based on http://vi.stackexchange.com/a/440.
function! <SID>JoinWithoutSpaces()
    execute 'normal gJ'
    " Remove any whitespace.
    if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
        execute 'normal dw'
    endif
endfunction
noremap <silent> <Leader>J :call <SID>JoinWithoutSpaces()<CR>

" Make Y yank everything from the cursor to the end of the line.
" This makes Y act more like C or D because by default, Y yanks the current
" line (i.e. the same as yy).
noremap Y y$

" Close the opened HTML tag with Ctrl+_ (I do not use vim-closetag because it
" often fails with an error).
inoremap <silent> <C-_> </<C-X><C-O><C-X>

" Smart window switching with awareness of Tmux panes. Now, I can use Ctrl+hjkl
" in both Vim and Tmux (without using the prefix). Based on
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.
" Note: I do not use https://github.com/christoomey/vim-tmux-navigator because
"       it does not work when vim is run over ssh.
if exists('$TMUX')
	function! <SID>TmuxOrSplitSwitch(wincmd, tmuxdir)
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

" Opens the selected link in a web browser.
let s:web_browser_path='/usr/bin/firefox'
function! <SID>OpenLink(link)
	exec ':silent !' . s:web_browser_path . ' ' . '"' . a:link . '"'
endfunction
" Open a link under the cursor in a web browser (similar to gx, but faster).
nnoremap <silent> gl
	\ :let curr_line = getline('.') <Bar>
	\ let link = matchstr(curr_line, '\(http\\|https\\|ftp\\|file\)://[^ )"]*') <Bar>
	\ if link != '' <Bar>
	\     call <SID>OpenLink(link) <Bar>
	\ endif <CR>

" Git leader commands.
" They require https://github.com/tpope/vim-fugitive.
noremap <Leader>gbl :Gblame<CR>

" Man pages.
" The nnoremap <Leader>man command is defined for every language separately.

" Wrap function arguments.
" Requires the https://github.com/jakobwesthoff/argumentrewrap plugin.
nnoremap <silent> <Leader>wa :call argumentrewrap#RewrapArguments()<CR>

" Replaces the current word (and all occurrences).
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/

" Changes the current word (and all occurrences).
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"

" Replace tabs with spaces.
nnoremap <Leader>rts :%s/	/    /g<CR>

" Makes the current file executable.
" Based on http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
function! <SID>MakeFileExecutable()
	let fname = expand("%:p")
	checktime
	execute "au FileChangedShell " . fname . " :echo"
	silent !chmod a+x %
	checktime
	execute "au! FileChangedShell " . fname
	" Fix display issues in terminal Vim.
	redraw!
endfunction
nnoremap <Leader>mfx :call <SID>MakeFileExecutable()<CR>

" Opening files in tabs.
nnoremap <Leader>sni :exec 'tabe ~/.vim/snippets/' . &filetype . '.snippets'<CR>
nnoremap <Leader>bash :tabe ~/.bashrc<CR>
nnoremap <Leader>vim :tabe ~/.vimrc<CR>
" Open the corresponding BibTeX file. It is assumed that there is only a single
" .bib file.
nnoremap <Leader>bib :tabe *.bib<CR>

"------------------------------------------------------------------------------
" Plugins.
"------------------------------------------------------------------------------

"----------------------------
" UltiSnip: Snippets for Vim.
"----------------------------
let g:snips_author='Petr Zemek <s3rvac@gmail.com>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDirectories=['snippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"----------------------------------------
" python: Syntax highlighting for Python.
"----------------------------------------
let python_highlight_builtins=0
let python_highlight_exceptions=0
let python_highlight_doctests=1
let python_highlight_indent_errors=0 " I use my own indent errors highlighting.
let python_highlight_space_errors=0
let python_highlight_string_formatting=0
let python_highlight_string_format=0
let python_highlight_string_templates=0
let python_slow_sync=1
let python_print_as_function=1

"-----------------------------------------
" Command-T: Fast file navigation for VIM.
"-----------------------------------------
let g:CommandTMaxCachedDirectories=0 " Do not limit caching.
let g:CommandTMatchWindowReverse=1 " Show the entries in reverse order.
let g:CommandTMaxHeight=10 " Show at most 10 matches.
let g:CommandTFileScanner='git' " Use `git ls-files`, then fallback to `find`.
hi CommandTHighlightColor guibg=darkblue guifg=white
let g:CommandTHighlightColor='CommandTHighlightColor' " Custom highlight color.
let g:CommandTTraverseSCM='pwd' " Use Vim's present working directory as the root.
let g:CommandTCancelMap=['<Esc>', '<C-c>'] " Keys to close the search window.

"---------------------------------------------
" Colorizer: Colors hex codes and color names.
"---------------------------------------------
let g:colorizer_auto_color = 0 " Do not start automatically.
let g:colorizer_colornames = 1 " Highlight color names as well.
let g:colorizer_x11_names = 1 " Support X11 colors as well.

" ---------------------------------------------------------
" vim-sort-motion: Vim mapping for sorting a range of text.
" ---------------------------------------------------------
let g:sort_motion_flags = "u" " Remove duplicates while sorting.

"---------
" xmledit.
"---------
let xml_tag_completion_map = "<C-l>"

"------------------------------------------------------------
" tcomment_vim: An extensible & universal comment vim-plugin.
"------------------------------------------------------------
" Disable leader commands (I don't use them).
let g:tcommentMapLeader1 = ""
let g:tcommentMapLeader2 = ""
" Do not comment blank lines.
let g:tcomment#blank_lines = 0
" Custom comment types.
call tcomment#DefineType('c', tcomment#GetLineC('// %s'))

"------------------------------------------------------------------------------
" File-type specific settings and other autocommands.
"------------------------------------------------------------------------------

" Remove trailing whitespace when a file is saved.
" TODO: Do not remove whitespace in these situations:
"       - before the space (or tab) there is a back slash (like '\ ').
au BufWritePre * :if ! &bin | call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Consider all .tpl files as Smarty files.
au BufNewFile,BufRead *.tpl set ft=smarty
" Consider all .php* files (.phps, .phpt etc.) as PHP files.
au BufNewFile,BufRead *.php[0-9a-zA-Z] set ft=php
" Consider all .ll files as LLVM IR files.
au BufNewFile,BufRead *.ll set ft=llvm
" Consider all .wsgi files as Python files.
au BufNewFile,BufRead *.wsgi set ft=python
" Use Vim highlighting when editing Vimperator's configuration.
au BufNewFile,BufRead .vimperatorrc set ft=vim
" Use tex filetype rather than plaintex.
au BufNewFile,BufRead *.tex set ft=tex

" Disable automatic wrapping for all files (some filetype plugins sets this to
" a different value, which is really annoying).
au FileType * set textwidth=0

" Quickfix.
" If there is a Makefile in the current directory,
" use the `make` command instead of a concrete program.
" TODO: Does it work correctly?
" TODO: Rewrite it so I don't use a function.
function <SID>SetMakeprg()
	if filereadable('Makefile') || filereadable('makefile')
		set makeprg='make'
	endif
endfunction
au FileType * call <SID>SetMakeprg()

" C and C++.
augroup c_cpp
" Use the man ftplugin to display pages from manual.
au FileType c,cpp runtime ftplugin/man.vim
" Use <Leader>man to display manual pages for the function under cursor.
au FileType c,cpp nmap <silent> <Leader>man :Man 3 <cword><CR>
" Use astyle for = command indention.
au FileType c,cpp exec "set equalprg=astyle\\ --mode=c\\ --options=".expand("$HOME")."/.vim/astyle/c-cpp.options"
" Allow "gq" on comments to work properly.
au FileType c,cpp set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
" Add a new include (+ store the current position to 'z').
au FileType c,cpp nnoremap <Leader>inc mz?#include <<CR>:nohlsearch<CR>o#include <><Esc>i
au FileType c,cpp nnoremap <Leader>Inc mz?#include \"<CR>:nohlsearch<CR>o#include ""<Esc>i

" Open both a .c|cpp|cc file and the corresponding .h file in a new tab.
function! <SID>GetCFile(base_name)
	" a:base_name should end with a dot (".")
	if filereadable(a:base_name . "cc")
		return a:base_name . "cc"
	elseif filereadable(a:base_name . "cpp")
		return a:base_name . "cpp"
	else
		return a:base_name . "c"
	endif
endfunction
function! <SID>OpenCAndHInNewTab(base_name)
	if a:base_name =~ "\\.h$"
		let h_file = a:base_name
		let c_file = <SID>GetCFile(substitute(a:base_name, "\\.h$", ".", ""))
	elseif a:base_name =~ "\.cc$"
		let h_file = substitute(a:base_name, "\\.cc$", ".h", "")
		let c_file = a:base_name
	elseif a:base_name =~ "\\.cpp$"
		let h_file = substitute(a:base_name, "\\.cpp$", ".h", "")
		let c_file = a:base_name
	elseif a:base_name =~ "\\.c$"
		let h_file = substitute(a:base_name, "\\.c$", ".h", "")
		let c_file = a:base_name
	elseif a:base_name =~ "\\.$"
		let h_file = a:base_name . "h"
		let c_file = <SID>GetCFile(a:base_name)
	else
		let h_file = a:base_name . ".h"
		let c_file = <SID>GetCFile(a:base_name . ".")
	endif
	if filereadable(c_file)
		if filereadable(h_file)
			exec "tabnew " . c_file
			exec "vsplit " . h_file
		else
			exec "tabnew " . c_file
		endif
	elseif filereadable(h_file)
		exec "tabnew " . h_file
	else
		echo "No file to open."
	endif
endfunction
au FileType c,cpp command! -nargs=1 -complete=file TN :call <SID>OpenCAndHInNewTab(<q-args>)

" Splits the current window by showing the .{c,cc,cpp} file on the left-hand
" side and the corresponding .h file on the right-hand side.
function! <SID>SplitCOrHFile()
	if bufname("") =~ "\\.\\(cpp\\|cc\\|c\\)$"
		let c_file = bufname("")
		let h_file = substitute(bufname(""), "\\.\\(cpp\\|cc\\|c\\)$", ".h", "")
		if filereadable(h_file)
			exec "edit " . c_file
			exec "vsplit " . h_file
		else
			echo "The corresponding .h file does not exist."
		endif
	elseif bufname("") =~ "\\.h$"
		let h_file = bufname("")
		let c_file = <SID>GetCFile(substitute(bufname(""), "\\.h$", ".", ""))
		if filereadable(c_file)
			exec "edit " . c_file
			exec "vsplit " . h_file
		else
			echo "The corresponding .{c,cc,cpp} file does not exist."
		endif
	else
		echo "There is no corresponding source file."
	endif
endfunction
au FileType c,cpp nnoremap <Leader>as :call <SID>SplitCOrHFile()<CR>

" Alternates between a .{c,cc,cpp} file and a .h file.
function! <SID>AlternateCOrHFile()
	if bufname("") =~ "\\.\\(cpp\\|cc\\|c\\)$"
		let h_file = substitute(bufname(""), "\\.\\(cpp\\|cc\\|c\\)$", ".h", "")
		if filereadable(h_file)
			exec "edit " . h_file
		else
			echo "The corresponding .h file does not exist."
		endif
	elseif bufname("") =~ "\\.h$"
		let c_file = <SID>GetCFile(substitute(bufname(""), "\\.h$", ".", ""))
		if filereadable(c_file)
			exec "edit " . c_file
		else
			echo "The corresponding .{c,cc,cpp} file does not exist."
		endif
	else
		echo "There is no corresponding source file."
	endif
endfunction
au FileType c,cpp nnoremap <Leader>ac :call <SID>AlternateCOrHFile()<CR>

" Let F10 compile and run the currently edited code.
au FileType c nnoremap <F10> :w<CR>:gcc -std=c11 -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out<CR>
au FileType cpp nnoremap <F10> :w<CR>:g++ -std=c++14 -pedantic -Wall -Wextra -o /tmp/a.out % && /tmp/a.out<CR>

augroup END

" PHP.
augroup php
" Use <Leader>man to display manual pages for the function under cursor in a browser.
au FileType php nmap <silent> <Leader>man :call <SID>OpenLink('http://php.net/'.expand('<cword>'))<CR>
" Make "gq" on comments work properly.
au FileType php set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://,:#
augroup END

" LaTeX.
augroup latex
au FileType tex,plaintex set spell          " Enable spell checking.
au FileType tex,plaintex let mytextwidth=80 " Maximum line length.
" Compilation.
" This errorformat presumes that you are using `pdflatex -file-line-error`
" to compile .tex files.
au FileType tex,plaintex set errorformat=%f:%l:\ %m
" TODO: Add support for building files without a Makefile.
augroup END

" Shell.
augroup sh
au FileType sh set noexpandtab  " Use tabs instead of spaces.
augroup END

" MySQL.
augroup mysql
" Consider .sql files as MySQL files.
au BufNewFile,BufRead *.sql set ft=mysql
" Allow "gq" on comments to work properly.
au FileType mysql set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:--
augroup END

" Python.
augroup python
" The following settings are based on these guidelines:
"  - python.org/dev/peps/pep-0008
au FileType python set expandtab      " Use spaces instead of tabs.
au FileType python set tabstop=4      " A tab counts for 4 spaces.
au FileType python set softtabstop=4  " Causes backspace to delete 4 spaces.
au FileType python set shiftwidth=4   " Shift by 4 spaces.
au FileType python let mytextwidth=79 " Maximum line length.

" Add a new import (+ store the current position to 'z').
au FileType python nnoremap <Leader>im mz?^import <CR>:nohlsearch<CR>oimport  <Esc>i
au FileType python nnoremap <Leader>fr mz?^from <CR>:nohlsearch<CR>ofrom  <Esc>i

" Let F9 run the currently opened tests.
au FileType python nnoremap <F9> :wa<CR>:!nosetests %<CR>

" Let Shift+F9 run all tests.
au FileType python nnoremap <S-F9> :wa<CR>:!nosetests tests<CR>

" Let F10 run the currently opened script.
au FileType python nnoremap <F10> :w<CR>:!python %<CR>

" Splits the current window by showing the corresponding test file on the
" right-hand side.
function! <SID>ShowPythonTestsInSplit()
	" For e.g. main_package/subpackage/module.py, the tests are in
	" tests/subpackage/module_tests.py (a convention that I use in my
	" projects).
	let module_rel_path = expand("%")
	let tests_rel_path = substitute(module_rel_path, "\\.\\py$", "_tests.py", "")
	let tests_rel_path = substitute(tests_rel_path, "^[^/]*/", "tests/", "")
	exec "vsplit " . tests_rel_path
endfunction
" The mapping is mimicking <Leader>as for c,cpp.
au FileType python nnoremap <Leader>as :call <SID>ShowPythonTestsInSplit()<CR>
augroup END

" Ruby.
augroup ruby
" The following settings are based on these guidelines:
"  - https://raw.github.com/chneukirchen/styleguide/master/RUBY-STYLE
au FileType ruby set expandtab      " Use spaces instead of tabs.
au FileType ruby set tabstop=2      " A tab counts for 2 spaces.
au FileType ruby set softtabstop=2  " Causes backspace to delete 2 spaces.
au FileType ruby set shiftwidth=2   " Shift by 2 spaces.
au FileType ruby let mytextwidth=80 " Maximum line length.

" Let F10 run the currently opened script.
au FileType ruby nnoremap <F10> :w<CR>:!ruby %<CR>
augroup END

" Haskell.
augroup haskell
" The following settings are based on these guidelines:
"  - urchin.earth.li/~ian/style/haskell.html
"  - cs.caltech.edu/courses/cs11/material/haskell/misc/haskell_style_guide.html
au FileType haskell set expandtab      " Use spaces instead of tabs.
au FileType haskell set tabstop=4      " A tab counts for 4 spaces.
au FileType haskell set softtabstop=4  " Causes backspace to delete 4 spaces.
au FileType haskell set shiftwidth=4   " Shift by 4 spaces.
au FileType haskell let mytextwidth=79 " Maximum line length.
augroup END

" LLVM.
augroup llvm
au FileType llvm set expandtab     " Use spaces instead of tabs.
au FileType llvm set tabstop=2     " A tab counts for 2 spaces.
au FileType llvm set softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType llvm set shiftwidth=2  " Shift by 2 spaces.
augroup END

" Git commits.
augroup gitcommit
au FileType gitcommit set spell     " Enable spellchecking.
au FileType gitcommit set expandtab " Use spaces instead of tabs.
augroup END

" Dokuwiki.
augroup dokuwiki
au FileType dokuwiki set spell         " Enable spell checking.
au FileType dokuwiki set expandtab     " Use spaces instead of tabs.
au FileType dokuwiki set tabstop=2     " Lists are indented with 2 spaces.
au FileType dokuwiki set softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType dokuwiki set shiftwidth=2  " Shift by 2 spaces.
augroup END

" reStructured Text
augroup rst
au FileType rst set spell              " Enable spellchecking.
au FileType rst set expandtab          " Use spaces instead of tabs.
augroup END

" Markdown.
augroup markdown
au FileType markdown set spell         " Enable spellchecking.
au FileType markdown set expandtab     " Use spaces instead of tabs.
au FileType markdown set tabstop=2     " Lists are indented with 2 spaces.
au FileType markdown set softtabstop=2 " Causes backspace to delete 2 spaces.
au FileType markdown set shiftwidth=2  " Shift by 2 spaces.
augroup END

" Mail.
augroup mail
au FileType mail set spell         " Enable spellchecking.
au FileType mail set spelllang=cs
au FileType mail set expandtab     " Use spaces instead of tabs.
augroup END

"-------------------------------------------------------------------------------
" Firefox "It's all text plugin".
"-------------------------------------------------------------------------------

let s:opened_file_path = expand('%:p')
if s:opened_file_path =~ '\.mozilla/firefox/'
	" Enable Czech spell checking by default.
	au BufRead,BufNewFile *.txt set spell
	au BufRead,BufNewFile *.txt set spelllang=cs

	au BufRead,BufNewFile *.txt set ft=html
endif

"------------------------------------------------------------------------------
" Typos correction.
"------------------------------------------------------------------------------

" English.
iab centre     center
iab fro        for
iab fucntion   function
iab recieve    receive
iab recieved   received
iab teh        the
iab hte        the

" Command mistypes.
nmap :W :w
nmap :Q :q
nmap :Set :set
nmap :Vsp :vsp

"------------------------------------------------------------------------------
" Local settings.
"------------------------------------------------------------------------------

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
