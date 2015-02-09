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

filetype off " Pathogen needs to run before plugin indent on.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() " Generate helptags for everything in 'runtimepath'.
filetype plugin indent on

"------------------------------------------------------------------------------
" General.
"------------------------------------------------------------------------------

set nocompatible        " Disable vi compatibility.
filetype plugin on      " Turn on filetype plugin.
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
set number              " Show line numbers.
set relativenumber      " Show relative numbers instead of absolute by default.
set showcmd             " Show (partial) command in status line.
set noshowmatch         " Don't show matching brackets when typing them.
set showmode            " Show current mode.
set shortmess+=aIoOtT   " Abbrevation of messages (avoids 'hit enter ...').
set splitbelow          " Open new hsplit panes to bottom rather than top.

" Backup and swap files.
" Store temporary files in a central spot.
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
" a) Enable backup.
" set swapfile            " Enable swap files.
" set backup              " Enable backup files.
" set writebackup         " Backup files before overwriting.
" b) Disable backup.
set noswapfile          " Disable swap files.
set nobackup            " Do not keep a backup file.
set nowritebackup       " Prevents auto write backup before overwriting file.

" History
set history=1000        " Number of lines of command line history.
" Read/write a .viminfo file.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media
" Do not store searches.
set viminfo+=h

" Modelines have historically been a source of security/resource
" vulnerabilities, so disable them.
set nomodeline

" Indention.
set autoindent          " Indent a new line according to the previous one.
set copyindent          " Copy (exact) indention from the previous line.
set nopreserveindent    " Do not try to preserve indention when indenting.
set nosmartindent       " Turn off smartindent.
set nocindent           " Turn off c-style indent.
set fo+=q               " Allow formatting of comments with "gq".
set fo-=r fo-=o         " Turn off automatic insertion of comment characters.
filetype indent off     " Turn off indention by filetype.
" Override previous settings for all file types (I have to do this because
" the previous commands just don't guarantee this...).
au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o

" Whitespace.
set tabstop=4           " Number of spaces <tab> counts for.
set shiftwidth=4        " Number of spaces to use for each step of indent.
set shiftround          " Round indent to multiple of shiftwidth.
set noexpandtab         " Do not expand tab with spaces.

" Wrapping.
set wrap                " Enable text wrapping.
set linebreak           " Break after words only.
set display+=lastline   " Show as much as possible from the last shown line.

" Statusline.
set noruler             " Since I'm using statusline, disable ruler.
set laststatus=2        " Always display statusline.
set statusline=%<%f\ %h%w%m%r%k\ [%{(&fenc\ ==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")},%{&ff}]\ %y\ [\%03.3b,0x\%02.2B,U+%04B]\ %l/%L,%v

" Vimdiff.
if &diff
	set diffopt+=iwhite " Ignore whitespace.
endif

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
" set omnifunc=syntaxcomplete#Complete
" set tags=./tags,./TAGS,tags,TAGS

" Searching.
set hlsearch            " Highlight search matches.
set incsearch           " Incremental search.
" set noignorecase        " Case-sensitive search.
" Case-smart searching (make /-style searches case-sensitive only if there is
" a capital letter in the search expression).
set ignorecase
set smartcase

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Sessions.
set sessionoptions=blank,buffers,curdir,help,resize,tabpages,winsize,winpos

" Disable folds.
set nofoldenable

" No bell sound.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

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
" End of line (unix EOL is preferred over the dos one).
set ffs=unix,dos

" Spellchecker.
" Disable spellchecking by default (F1 toggles it).
set nospell
" Language (use Shift+F1 to toggle between the Czech and English language).
set spelllang=en_us,en_gb
" Spellfile (can add/delete custom words to/from the dictionary) is enabled
" by default and stores into ~/.vim/spell/{spelllang}.{encoding}.add).

" Syntax highlighting.
syntax on

" Highlight mixture of spaces and tabs.
au BufEnter * hi SpacesTabsMixtureGroup guibg=gray18 guifg=red ctermbg=gray ctermfg=red
au BufEnter * match SpacesTabsMixtureGroup /^ \+\t\+\|^\t\+ \+/

" Use the same color in the signs column as it is used in the numbers column.
au BufEnter * hi clear SignColumn

" Graphical Vim.
if has("gui_running")
	" Colors.
	colorscheme koehler
	" Statusline.
	au BufEnter * hi StatusLine guibg=black guifg=white
	au BufEnter * hi StatusLineNC guibg=black guifg=gray70
	" Characters exceeding textwidth or 80 characters.
	au BufEnter * hi ExceedCharsGroup guibg=darkblue guifg=white
	" Wild menu.
	au BufEnter * hi Pmenu guibg=gray30 guifg=white
	au BufEnter * hi PmenuSel guibg=white guifg=black
	" Folds.
	au BufEnter * hi Folded guibg=gray30 guifg=white
	au BufEnter * hi FoldColumn guibg=gray30 guifg=white
	" Cursor.
	au BufEnter * hi Cursor guifg=bg guibg=#54ff52

	" Font.
	set guifont=Monospace\ 10.5

	" Use a Vim icon.
	set guioptions+=i
	" Disable menubar.
	set guioptions-=m
	" Disable toolbar.
	set guioptions-=T
	" Automatically put selected text into the clipboard
	" (paste via the mouse middle button).
	set guioptions+=aA
	" Always display the right scrollbar.
	set guioptions+=r

	" Leave no pixels around the GVim window.
	set guiheadroom=0

	" Enable mouse usage.
	set mouse=a
	" Hide mouse cursor when editing.
	set mousehide
	" Right mouse button pops up a menu.
	set mousemodel=popup_setpos

	" Disable cursor blinking.
	set guicursor=a:blinkon0

	" Always display the tab bar (even when there is only one tab).
	" I need this because GVim can't properly maximize on its own, so I have
	" to set specific options for GVim windows, however there is a view problem
	" when I open a second tab...
	set showtabline=2
" Vim in terminal.
else
	" Statusline.
	" I don't know why, but bg means fg and vice versa in terminal.
	au BufEnter * hi StatusLine ctermbg=white ctermfg=black
	" Characters exceeding textwidth or 80 characters.
	au BufEnter * hi ExceedCharsGroup ctermbg=blue ctermfg=white
	" Mixture between spaces and tabs.
	au BufEnter * hi SpacesTabsMixtureGroup ctermbg=red ctermfg=red
	" Wild menu.
	au BufEnter * hi Pmenu ctermbg=brown ctermfg=white
	au BufEnter * hi PmenuSel ctermbg=white ctermfg=black

	" Change cursor shape according to the mode.
	let &t_SI="\<Esc>]50;CursorShape=1\x7"
	let &t_EI="\<Esc>]50;CursorShape=0\x7"
endif

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

" F3: Toggle line wrapping in normal mode.
nnoremap <silent> <F3> :set nowrap!<CR>:set nowrap?<CR>

" F4: Toggle vim-gitgutter.
" The mapping is defined in the plugin section.

" F5: Refresh file.
nnoremap <silent> <F5> :edit!<CR>

" F6: Toggle relative/absolute numbers.
function! <SID>RelAbsNumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc
nnoremap <silent> <F6> :call <SID>RelAbsNumberToggle()<CR>

" F9: Run tests.
" The mapping is defined separately for each file type.

" F10: Run the current script.
" The mapping is defined separately for each file type.

" F11: Quickfix.
" Executes :make and opens the quickfix windows if there is an error.
nnoremap <F11> mp :echo 'Making...' <Bar> silent make <Bar> botright cw<CR><C-W><Up>

" F12: Syntastic (syntax checker).
" The mapping is defined in the plugin section.

"------------------------------------------------------------------------------
" Abbreviations and other mappings.
"------------------------------------------------------------------------------

" The <Leader> character.
let mapleader=","
let maplocalleader=","

" General command aliases.
cnoreabbrev tn tabnew

" Enable lookup by pressing '\' (it is more easily reachable than '/').
nnoremap \ /

" Word completion.
" TODO Use it or not?
" inoremap <C-Space> <C-n>

" Quit with Q instead of :q!.
noremap <silent> Q :q!<CR>

" Disable K looking stuff up.
noremap K <Nop>

" Quicksave.
noremap  <C-S> :w<CR>
noremap! <C-S> <Esc>:w<CR>

" Quicksave all buffers/tabs.
noremap  <C-A> :wa<CR>
noremap! <C-A> :wa<CR>

" These mappings will reselect the block after shifting, so you'll just have
" to select a block, press < or > as many times as you like, and press <Esc>
" when you're done to deselect the block.
vnoremap < <gv
vnoremap > >gv

" Hitting space in normal mode will make the current search disappear.
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Insert the contents of a clipboard.
nnoremap <silent> <S-Insert> :set paste<CR>"+p:set nopaste<CR>
" TODO: It depends whether I'm at the end of a line or not.
inoremap <silent> <S-Insert> :set paste<CR>"+P:set nopaste<CR>
cnoremap          <S-Insert> <C-R>+
vnoremap          <S-Insert> "+p

" Copy the selected text into the clipboard.
noremap <C-Insert> "+y

" Cut&copy the selected text into the clipboard.
noremap <C-Del> "+d

" Marks: Swap the '<letter> and `<letter> functionality, because
" the ' character is more easily reachable than the ` character.
nnoremap ' `
nnoremap ` '

" Open help in a vertical window on the right side.
noremap :help :vert bo help

" Move by screen lines instead of virtual lines.
" (a) by default
" nnoremap j gj
" nnoremap k gk
" vnoremap j gj
" vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-O>gj
inoremap <Up> <C-O>gk
" (b) use <Alt>+jk/arrows to move by screen lines instead of virtual lines
nnoremap <A-j> gj
nnoremap <A-k> gk
vnoremap <A-j> gj
vnoremap <A-k> gk
" nnoremap <A-Down> gj
" nnoremap <A-Up> gk
" vnoremap <A-Down> gj
" vnoremap <A-Up> gk
" inoremap <A-Down> <C-O>gj
" inoremap <A-Up> <C-O>gk

" Jump between tabs.
" (a) by <Shift>+arrows
noremap  <S-Left>  gT
inoremap <S-Left>  gT
noremap  <S-Right> gt
inoremap <S-Right> gt
" (b)by <Shift>+h/l
noremap <S-h> gT
noremap <S-l> gt

" Jump between windows.
" (a) by <Ctrl>+arrows
noremap  <C-Up>    <C-W><Up>
inoremap <C-Up>    <C-W><Up>
noremap  <C-Down>  <C-W><Down>
inoremap <C-Down>  <C-W><Down>
noremap  <C-Left>  <C-W><Left>
inoremap <C-Left>  <C-W><Left>
noremap  <C-Right> <C-W><Right>
inoremap <C-Right> <C-W><Right>
" (b) by <Ctrl>+h/j/k/l
noremap  <C-k> <C-W><Up>
inoremap <C-k> <C-W><Up>
noremap  <C-j> <C-W><Down>
inoremap <C-j> <C-W><Down>
noremap  <C-h> <C-W><Left>
inoremap <C-h> <C-W><Left>
noremap  <C-l> <C-W><Right>
inoremap <C-l> <C-W><Right>

" Emacs-like beginning and end of line.
" inoremap <C-e> <C-O>$
" inoremap <C-a> <C-O>^

" Opens the selected link in a web browser.
let s:web_browser_path='/usr/bin/firefox'
function! <SID>OpenLink(link)
	exec ':silent !' . s:web_browser_path . ' ' . '"' . a:link . '"'
endfunction
" Open a link under the cursor in a web browser.
nnoremap <silent> gl
	\ :let curr_line = getline('.') <Bar>
	\ let link = matchstr(curr_line, '\(http\\|https\\|ftp\\|file\)://[^ )"]*') <Bar>
	\ if link != '' <Bar>
	\     call <SID>OpenLink(link) <Bar>
	\ endif <CR>

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
			exec "tabnew " . h_file
			exec "vsplit " . c_file
		else
			exec "tabnew " . c_file
		endif
	elseif filereadable(h_file)
		exec "tabnew " . h_file
	else
		echo "No file to open."
	endif
endfunction
command -nargs=1 -complete=file TN :call <SID>OpenCAndHInNewTab(<q-args>)

" Splits the current window by showing the .{c,cc,cpp} file on the left-hand
" side and the corresponding .h file on the right-hand side.
function! <SID>SplitCOrHFile()
	if bufname("") =~ "\\.\\(cpp\\|cc\\|c\\)$"
		let c_file = bufname("")
		let h_file = substitute(bufname(""), "\\.\\(cpp\\|cc\\|c\\)$", ".h", "")
		if filereadable(h_file)
			exec "edit " . h_file
			exec "vsplit " . c_file
		else
			echo "The corresponding .h file does not exist."
		endif
	elseif bufname("") =~ "\\.h$"
		let h_file = bufname("")
		let c_file = <SID>GetCFile(substitute(bufname(""), "\\.h$", ".", ""))
		if filereadable(c_file)
			exec "edit " . h_file
			exec "vsplit " . c_file
		else
			echo "The corresponding .{c,cc,cpp} file does not exist."
		endif
	else
		echo "There is no corresponding source file."
	endif
endfunction
nnoremap <Leader>as :call <SID>SplitCOrHFile()<CR>

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
nnoremap <Leader>ac :call <SID>AlternateCOrHFile()<CR>

" Useful leader commands.
"
" Run `git blame` over the selected lines.
vnoremap <Leader>gbl :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
" Man pages.
" The nnoremap <Leader>man command is defined for every language separately.
" Replace.
nnoremap <Leader>ra :%s/
" Replaces the current word (and all occurrences).
nnoremap <Leader>rc :%s/\<<C-R><C-W>\>/
vnoremap <Leader>rc y:%s/<C-R>"/
" Changes the current word (and all occurrences).
nnoremap <Leader>cc :%s/\<<C-R><C-W>\>/<C-R><C-W>
vnoremap <Leader>cc y:%s/<C-R>"/<C-R>"
" Sort the current paragraph while merging duplicities.
nnoremap <Leader>sap (V)k :sort u<CR>
" Wrap the current paragraph.
nnoremap <Leader>gqp (V)k gqk<CR>
" Replace tabs with spaces.
nnoremap <Leader>rts :%s/	/    /g<CR>
" Makes the current file executable.
nnoremap <Leader>mfx :silent !chmod a+x %:p<CR>
" Other.
nnoremap <Leader>sni :exec 'tabe ~/.vim/snippets/' . &filetype . '.snippets'<CR>
nnoremap <Leader>bsh :tabe ~/.bashrc<CR>
nnoremap <Leader>vim :tabe ~/.vimrc<CR>
" Open the corresponding BibTeX file. It is assumed that there is only a single
" .bib file.
nnoremap <Leader>bib :tabe *.bib<CR>

"------------------------------------------------------------------------------
" Plugins.
"------------------------------------------------------------------------------

"---------------------------------------------------------------
" NERD_Commenter: Easy commenting of code for many filetypes.
"---------------------------------------------------------------

" Note: I use alternate styles for several filetypes. Since I was not able to
"       configure them in .vimrc, I had to modify the sources of the plugin.

" Do not create menu.
let NERDMenuMode=0
" Delimit comments with a single space.
let NERDSpaceDelims=1
" Also remove alternative comments when uncommenting.
let NERDRemoveAltComs=1
" Do not create default mappings (I use my own ones - see below).
let NERDCreateDefaultMappings=0
" Use Ctrl+C to comment/uncoment the selected text according to the first line.
nnoremap <silent> <C-C> :call NERDComment(0, 'toggle')<CR>
vnoremap <silent> <C-C> <ESC>:call NERDComment(1, 'toggle')<CR>
" I have to remap the <C-C> commands for HTML files (because I want
" minimal comments for HTML files).
function! <SID>HtmlComment(is_visual)
	let first_line = getline(a:is_visual ? line("'<") : a:firstline)
	let action = first_line =~ '^\s*<!--' ? 'uncomment' : 'minimal'
	call NERDComment(a:is_visual, action)
endfunction
au FileType html nnoremap <silent> <C-C> :call <SID>HtmlComment(0)<CR>
au FileType html vnoremap <silent> <C-C> <Esc>:call <SID>HtmlComment(1)<CR>

"------------------------------------------------------------------
" DoxygenToolkit: Simplify Doxygen documentation in C, C++, Python.
"------------------------------------------------------------------

" General.
let g:DoxygenToolkit_authorName="Petr Zemek"
" License.
let g:DoxygenToolkit_licenseTag="Copyright (C) " . strftime("%Y") . " " . g:DoxygenToolkit_authorName . "\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "This program is free software; you can redistribute it and/or modify it\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "under the terms of the GNU General Public License as published by the Free\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "Software Foundation; either version 2 of the License, or (at your option)\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "any later version.\<enter>\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "This program is distributed in the hope that it will be useful, but\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "for more details.\<enter>\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "You should have received a copy of the GNU General Public License along\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "with this program; if not, write to the Free Software Foundation, Inc.,\<enter>"
let g:DoxygenToolkit_licenseTag=g:DoxygenToolkit_licenseTag . "59 Temple Place - Suite 330, Boston, MA  02111-1307, USA."
" Special settings for C and C++.
au FileType c,cpp let g:DoxygenToolkit_paramTag_pre="@param[in] "
au FileType c,cpp nnoremap <Leader>dox :Dox<CR>

"----------------------
" Haskell mode for Vim.
"----------------------

" Use GHC functionality for Haskell files.
au FileType haskell compiler ghc
" GHC paths.
let g:ghc="/usr/bin/ghc"
" Configure browser for haskell_doc.vim.
let g:haddock_browser="/usr/bin/firefox"
let g:haddock_browser_callformat="%s %s > /dev/null 2>&1 &"
" Haddock paths.
let g:haddock_docdir="/usr/share/doc/ghc6-doc/"
let g:haddock_indexdir=$HOME."/.vim/tmp/haddock-indexdir/"
let g:haddock_indexfiledir=$HOME."/.vim/tmp/haddock-indexdir/"
" This plugins sets 'cmdheight' to 3, but I want it to be 1.
au FileType haskell set cmdheight=1

"--------------------------------------------------------
" netrw: Network oriented reading, writing, and browsing.
"--------------------------------------------------------
let g:netrw_silent=1

"----------------------------
" UltiSnip: Snippets for Vim.
"----------------------------
let g:snips_author='Petr Zemek <s3rvac@gmail.com>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDirectories=['snippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"-------------------------------------------------
" bib_autocomp: Autocompletion for BibTeX entries.
"-------------------------------------------------
let g:bib_autocomp_entry_mapping = {
	\ 'misc': ['author', 'title', 'howpublished', 'url']
	\ }

"------------------------------------------
" Syntastic: Syntax checking hacks for vim.
"------------------------------------------
" Active and passive file types
let g:syntastic_mode_map = { 'mode': 'passive',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': [] }
" Used checkers.
let g:syntastic_python_checkers = ['pyflakes', 'flake8']
" Care only about errors.
let g:syntastic_quiet_warnings=1
" Auto jump to the first detected error.
let g:syntastic_auto_jump=1
" Auto open the errors list when there are errors.
let g:syntastic_auto_loc_list=1
" Display the number of errors and warnings in the statusline.
let g:syntastic_stl_format = ' [%E{Errors: %fe #%e}%B{, }%W{Warnings: %fw #%w}]'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" F12: Check syntax.
noremap <silent> <F12> :SyntasticCheck<CR>:Errors<CR>
noremap! <silent> <F12> <Esc>:SyntasticCheck<CR>:Errors<CR>
" When saving and there was an error, re-check the syntax automatically.
noremap <silent> <C-S>
	\ :if SyntasticStatuslineFlag() != '' <Bar>
	\   exec 'SyntasticCheck' <Bar>
	\ else <Bar>
	\   write <Bar>
	\ endif <CR>

"----------------------------------------
" python: Syntax highlighting for Python.
"----------------------------------------
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_doctests=1
let python_highlight_indent_errors=0 " I use my own indent errors highlighting.
let python_highlight_string_formatting=0
let python_highlight_string_format=0
let python_highlight_string_templates=0
let python_highlight_space_errors=0
let python_slow_sync=1
let python_print_as_function=1

"-----------------------------------------
" Command-T: Fast file navigation for VIM.
"-----------------------------------------
let g:CommandTMaxCachedDirectories=0 " Do not limit caching.
let g:CommandTMatchWindowReverse=1 " Show the entries in reverse order.
let g:CommandTAcceptSelectionTabMap='<C-CR>' " Open a new tab with Ctrl+Enter.
hi CommandTHighlightColor guibg=darkblue guifg=white
let g:CommandTHighlightColor='CommandTHighlightColor' " Custom highlight color.
let g:CommandTTraverseSCM='pwd' " Use Vim's present working directory as the root.

"-----------------------------------------------
" vim-gitgutter: Shows a git diff in the gutter.
"-----------------------------------------------
let g:gitgutter_enabled = 0 " Disable it by default. Use F4 to toggle it.
let g:gitgutter_realtime = 0 " Stop it from running in realtime.
let g:gitgutter_eager = 0 " Stop it from running too eagerly.
let g:gitgutter_escape_grep = 1
let g:gitgutter_highlight_lines = 1
" F4: Toggle vim-gitgutter.
nnoremap <silent> <F4> :GitGutterToggle<CR>
inoremap <silent> <F4> <C-O>:GitGutterToggle<CR>

"---------------------------------------------------------
" vim-python-test-runner.vim: Running python tests in VIM.
"---------------------------------------------------------
au FileType python nnoremap <Leader>rtf :w<CR>:NosetestFile<CR>
au FileType python nnoremap <Leader>rtc :w<CR>:NosetestClass<CR>
au FileType python nnoremap <Leader>rtm :w<CR>:NosetestMethod<CR>
au FileType python nnoremap <Leader>rtl :w<CR>:RerunLastTests<CR>
au FileType python nnoremap <F9> :w<CR>:!nosetests<CR>

"---------
" xmledit.
"---------
let xml_tag_completion_map = "<C-l>"

"-------
" vmath.
"-------
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap        ++ vip++

"------------------------------------------------------------------------------
" File-type specific settings and other autocommands.
"------------------------------------------------------------------------------

" Remove trailing whitespace when a file is saved.
" TODO: Do not remove whitespace in these situations:
"       - before the space (or tab) there is a back slash (like '\ ').
au BufWritePre * :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" In insert mode, show absolute numbers.
" au InsertEnter * :set norelativenumber
" au InsertLeave * :set relativenumber

" When Vim looses focus, show absolute numbers.
" :au FocusLost   * :set norelativenumber
" :au FocusGained * :set relativenumber

" Consider all .tpl files as Smarty files.
au BufNewFile,BufRead *.tpl set ft=smarty
" Consider all .php* files (.phps, .phpt etc.) as PHP files.
au BufNewFile,BufRead *.php[0-9a-zA-Z] set ft=php
" Consider all .ll files as LLVM IR files.
au BufNewFile,BufRead *.ll set ft=llvm
" Consider all .wsgi files as Python files.
au BufNewFile,BufRead *.wsgi set ft=python
" Use tex filetype rather than plaintex.
au BufNewFile,BufRead *.tex set ft=tex

" Disable automatical wrapping for all files (some filetype plugins sets this
" to a different value and it is really annoying).
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

" C and C++ code.
augroup c_cpp
" Enable spell checking.
au FileType c,cpp set spell
" Use the man ftplugin to display pages from manual.
au FileType c,cpp runtime ftplugin/man.vim
" Use <Leader>man to display manual pages for the function under cursor.
au FileType c,cpp nmap <silent> <Leader>man :Man 3 <cword><CR>
" Use astyle for = command indention.
au FileType c,cpp exec "set equalprg=astyle\\ --mode=c\\ --options=".expand("$HOME")."/.vim/astyle/c-cpp.options"
" Allow "gq" on comments to work properly.
au FileType c,cpp set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
" Add a new include (+ store the current position to 'z').
au FileType c,cpp nnoremap <Leader>inc mz?#include <<CR>:noh<CR>o#include <><Esc>i
au FileType c,cpp nnoremap <Leader>Inc mz?#include \"<CR>:noh<CR>o#include ""<Esc>i
augroup END

" PHP code.
augroup php
" Enable spell checking.
au FileType php set spell
" Use <Leader>man to display manual pages for the function under cursor in a browser.
au FileType php nmap <silent> <Leader>man :call <SID>OpenLink('http://php.net/'.expand('<cword>'))<CR>
" Make "gq" on comments work properly.
au FileType php set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://,:#
augroup END

" LaTeX code.
augroup latex
au FileType tex,plaintext set spell          " Enable spell checking.
au FileType tex,plaintex let mytextwidth=80  " Maximum line length.
" Compilation.
" This errorformat presumes that you are using `pdflatex -file-line-error`
" to compile .tex files.
au FileType tex,plaintex set errorformat=%f:%l:\ %m
" TODO: Add support for compiling files without a Makefile.
augroup END

" Shell code.
augroup sh
au FileType sh set spell        " Enable spell checking.
au FileType sh set noexpandtab  " Use tabs instead of spaces.
augroup END

" MySQL code.
augroup mysql
" Consider .sql files as MySQL files.
au BufNewFile,BufRead *.sql set ft=mysql
" Allow "gq" on comments to work properly.
au FileType mysql set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:--
augroup END

" Python code.
augroup python
" Enable spell checking.
au FileType python set spell

" The following settings are based on these guidelines:
"  - python.org/dev/peps/pep-0008
au FileType python set expandtab      " Use spaces instead of tabs.
au FileType python set tabstop=4      " A tab counts for 4 spaces.
au FileType python set softtabstop=4  " Causes backspace to delete 4 spaces.
au FileType python set shiftwidth=4   " Shift by 4 spaces.
au FileType python let mytextwidth=79 " Maximum line length.

" Add a new import (+ store the current position to 'z').
au FileType python nnoremap <Leader>im mz?^import <CR>:noh<CR>oimport  <Esc>i
au FileType python nnoremap <Leader>fi mz?^from <CR>:noh<CR>ofrom  <Esc>i

" Let F10 run the currently opened script.
au FileType python nnoremap <F10> :w<CR>:!python %<CR>
augroup END

" Ruby code.
augroup ruby
" Enable spell checking.
au FileType ruby set spell

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

" Haskell code.
augroup haskell
" The following settings are based on these guidelines:
"  - urchin.earth.li/~ian/style/haskell.html
"  - cs.caltech.edu/courses/cs11/material/haskell/misc/haskell_style_guide.html
au FileType haskell set expandtab      " Use spaces instead of tabs.
au FileType haskell set tabstop=4      " A tab counts for 4 spaces.
au FileType haskell set softtabstop=4  " Causes backspace to delete 4 spaces.
au FileType haskell set shiftwidth=4   " Shift by 4 spaces.
au FileType haskell let mytextwidth=79 " Maximum line length.
" Use K to display documentation for the function under cursor
" in a browser using the Haskell-mode plugin (via Hoggle).
au FileType haskell nnoremap <silent> K
	\ :echo 'Displaying docs...' <Bar>
	\ call HaskellSearchEngine('hoogle')<CR>
augroup END

" Git commits.
augroup gitcommit
au FileType gitcommit set spell " Enable spellchecking.
augroup END

" Mail.
augroup mail
au FileType mail set spell " Enable spellchecking.
au FileType mail set spelllang=cs
augroup END

"-------------------------------------------------------------------------------
" Firefox "It's all text plugin".
"-------------------------------------------------------------------------------

" Firefox "It's all text plugin".
let s:opened_file_path = expand('%:p')
if s:opened_file_path =~ '\.mozilla/firefox/'
	" Enable Czech spell checking by default.
	au BufRead,BufNewFile *.txt set spell
	au BufRead,BufNewFile *.txt set spelllang=cs

	au BufRead,BufNewFile *.txt set ft=html
endif

"------------------------------------------------------------------------------
" Correct typos
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

"------------------------------------------------------------------------------
" Local settings.
"------------------------------------------------------------------------------

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
