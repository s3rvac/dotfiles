local fns = require("s3rvac.functions")

-------------------------------------------------------------------------------
-- General settings.
-------------------------------------------------------------------------------

-- Preserve context (rows) when scrolling vertically.
vim.opt.scrolloff = 10

-- Preserve context (columns) when scrolling horizontally.
vim.opt.sidescroll = 10

-- Maximum number of tabs to open by the -p argument.
vim.opt.tabpagemax = 100

-- Automatically save before :next, :make etc.
vim.opt.autowrite = true

-- Ask to save file before operations like :q or :e fail.
vim.opt.confirm = true

-- Abbreviation of messages (avoids "hit enter ..." messages).
vim.opt.shortmess:append("aIoOtT")

-- Search in the directory of the current file, cwd, and subdirectories.
vim.opt.path = ".,,**"

-- Set the window title. I need this in the Tmux configuration to determine
-- whether Neovim is running or not.
vim.opt.title = true

-- What to store in sessions.
vim.opt.sessionoptions = "curdir,folds,globals,tabpages"

-- Disable folds by default (i.e. automatically open all folds).
vim.opt.foldenable = false

-- Case-smart searching (make /-style searches case-sensitive only if there is
-- a capital letter in the search expression).
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Treat dash-separated words as a single word (e.g. "well-written"), which
-- makes e.g. `w` jump over the whole hyphenated word and the nvim-cmp plugin
-- to complete the whole hyphenated word (very useful, at least for me). This
-- basically makes '-' being treated in the same way as '_'.
vim.opt.iskeyword = vim.opt.iskeyword + "-"

-- Open new vertical panes in the right rather than left.
vim.opt.splitright = true

-- Open new horizontal panes in the bottom rather than top.
vim.opt.splitbelow = true

-- Enable project-local configuration by automatically executing .nvim.lua,
-- .nvimrc, and .exrc files in the current directory if the file is in the
-- trust list.
vim.opt.exrc = true

-- Force Neovim to always use the system version of Python. Otherwise, when
-- opening Neovim from within a virtual environment (e.g. Python's venv),
-- Python plugins in Neovim would complain that `pynvim` is not installed.
vim.g.python3_host_prog = "/usr/bin/python3"

-------------------------------------------------------------------------------
-- Line numbers, sign column.
-------------------------------------------------------------------------------

-- Show line numbers.
vim.opt.number = true

-- Show relative numbers instead of absolute ones.
vim.opt.relativenumber = true

-- Always show the sign column so that the whole screen does not move when
-- there is a diagnostic message.
vim.opt.signcolumn = "yes:1"

-------------------------------------------------------------------------------
-- Indentation, whitespace.
-------------------------------------------------------------------------------

-- Number of spaces a tab counts for.
vim.opt.tabstop = 4

-- Number of spaces to use for each step of indent.
vim.opt.shiftwidth = 4

-- Round indent to multiple of shiftwidth.
vim.opt.shiftround = true

-- Do not expand tab with spaces.
vim.opt.expandtab = false

-- Tell Vim which characters to show for expanded tabs, trailing whitespace,
-- ends of lines, and non-breakable space.
vim.opt.listchars = "tab:>-,trail:#,eol:$,nbsp:~,extends:>,precedes:<"

-- Indent a new line according to the previous one.
vim.opt.autoindent = true

-- Copy (exact) indention from the previous line.
vim.opt.copyindent = true

-- Do not try to preserve indention when indenting.
vim.opt.preserveindent = false

-- Turn off smartindent.
vim.opt.smartindent = false

-- Turn off C-style indent.
vim.opt.cindent = false

-- Turn off automatic insertion of comment characters.
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

-- Turn off indention by filetype (I use custom settings for each filetype).
-- Override the previous settings for all file types (some filetype plugins set
-- these options to different values, which is really annoying).
vim.cmd([[
  filetype indent off
  au FileType * set autoindent nosmartindent nocindent formatoptions-=r formatoptions-=o
]])

-------------------------------------------------------------------------------
-- Backup, undo, swap.
-------------------------------------------------------------------------------

-- Disable auto backup before overwriting a file.
vim.opt.writebackup = false

-- Do not preserve undo history across Vim runs. I know that this can be very
-- useful, but I currently find it annoying. Indeed, when I open a file, do some
-- changes, and then hit undo a couple of times, I expect to end up in a state
-- when the file was opened, not in a state e.g. a month ago.
vim.opt.undofile = false

-- Disable swap files.
vim.opt.swapfile = false

-------------------------------------------------------------------------------
-- Security.
-------------------------------------------------------------------------------

-- Forbid loading of .vimrc under $PWD.
vim.opt.secure = true

-- Modelines have been a source of vulnerabilities.
vim.opt.modeline = false

-------------------------------------------------------------------------------
-- Text wrapping.
-------------------------------------------------------------------------------

-- Enable text wrapping.
vim.opt.wrap = true

-- Break after words only.
vim.opt.linebreak = true

-- Allow arrows at the end/beginning of lines to move to the next/previous line.
vim.opt.whichwrap:append("<,>,[,]")

-- Show as much as possible from the last shown line.
vim.opt.display:append("lastline")

-- Disable automatic wrapping for all files (some filetype plugins set this to
-- a different value, which is really annoying).
vim.cmd([[au FileType * set textwidth=0]])

-------------------------------------------------------------------------------
-- Completion.
-------------------------------------------------------------------------------

-- Completion mode.
-- - list: When more than one match, list all matches.
-- - longest: Complete till longest common string. If this does not result in a
--            longer string, use the next part.
vim.opt.wildmode = "list:longest"

-- Ignore various binary/temporary files.
vim.opt.wildignore:append("*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg")

-- Ignore various version-control directories.
vim.opt.wildignore:append(".git,.svn,.hg")

-- Ignore various Python-related directories.
vim.opt.wildignore:append(
  "*.egg-info,.mypy_cache,.pytest_cache,coverage,htmlcov,dist,venv,virtualenv"
)

-- Suffixes that get lower priority when doing tab completion for filenames.
-- These files are less likely to be edited.
vim.opt.suffixes:append(
  ".bak,~,.swp,.o,.info,.aux,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc"
)

-- Options for the completion menu.
vim.opt.completeopt = "menu,menuone,longest"

-- Do not search in included/imported files (it slows down completion, mostly
-- on network filesystems).
vim.opt.complete:remove("i")

-- Maximal number of items in completion menus.
vim.opt.pumheight = 15

-------------------------------------------------------------------------------
-- Encoding, end of line.
-------------------------------------------------------------------------------

-- Default file encoding for new files.
vim.opt_global.fenc = "utf-8"

-- Detect file encoding when opening a file and try to choose from the following
-- encoding list (to check what file encoding was selected run `:set fenc`).
vim.opt.fencs = "ucs-bom,utf-8,cp1250,latin2,latin1"

-- Internal encoding used by Vim buffers, help and commands.
vim.opt.enc = "utf-8"

-- End of line. Unix EOL is preferred over the dos one and before the mac one.
vim.opt.ffs = "unix,dos,mac"

-------------------------------------------------------------------------------
-- Spell checking.
-------------------------------------------------------------------------------

-- Disable spellchecking by default (F1 toggles it).
vim.opt.spell = false

-- Language (use Shift+F1 to toggle between the Czech and English language).
vim.opt.spelllang = "en_us,en_gb"

-- Spellfile (can add/delete custom words to/from the dictionary) is enabled
-- by default and stored into ~/.vim/spell/{spelllang}.{encoding}.add).

-------------------------------------------------------------------------------
-- netrw: Neovim's built-in filesystem browser (including network oriented
-- reading, writing, and browsing).
-------------------------------------------------------------------------------

-- Disable the top banner.
vim.g.netrw_banner = 0

-- Tree-like view.
vim.g.netrw_liststyle = 3

-- Open splits to the right.
vim.g.netrw_altv = 1

-- Use a smaller window.
vim.g.netrw_winsize = 25

-- Do not perform any magic during sorting (like putting .h files together),
-- except for listing directories first.
vim.g.netrw_sort_sequence = "[/]$"

-------------------------------------------------------------------------------
-- Terminal/graphical Neovim + UI.
-------------------------------------------------------------------------------

-- Use true (24-bit) colors in the terminal.
vim.opt.termguicolors = true

-- Disable mouse usage by default (I want to be able to select text via
-- terminal-provided facilities).
vim.opt.mouse = ""

-- Hide mouse cursor when editing.
vim.opt.mousehide = true

-- Lower the timeout when entering normal mode from insert mode.
vim.opt.ttimeoutlen = 0

-- Keep the cursor fat in all modes (including insert mode) and disable
-- cursor blinking. Works both in GUI as well as in the terminal.
vim.opt.guicursor = "a:block,a:blinkon0"

if fns.is_running_in_gui() then
  -- Running in a GUI.

  -- Enable mouse usage in the GUI.
  vim.opt.mouse = "a"

  -- Set up a default font and size. This allows me to change the font in one
  -- nvim-qt window without affecting all the other windows.
  vim.opt.guifont = "Monospace:h12"

  -- Make the GUI version check for changes in files upon gaining focus, which
  -- is what the terminal version does by default.
  vim.api.nvim_create_autocmd({ "FocusGained" }, {
    callback = function()
      vim.cmd(":checktime")
    end,
  })
else
  -- Running in a terminal.

  -- Make some key combinations work when running Neovim in the terminal, Tmux,
  -- and Midnight Commander.
  vim.cmd([[
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
  ]])
end

-------------------------------------------------------------------------------
-- Firefox 'Textern' plugin.
-------------------------------------------------------------------------------

vim.cmd([[
let s:opened_file_path = expand('%:p')
if s:opened_file_path =~ 'textern-'
  augroup firefox_textern_plugin
  au!

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
    au BufRead,BufNewFile *.txt setl ft=html
  " blog.petrzemek.net
  elseif s:opened_file_path =~ 'blog.petrzemek.net'
    au BufRead,BufNewFile *.txt setl ft=html
    au BufRead,BufNewFile *.txt setl spelllang=en
  " petrzemek.net
  elseif s:opened_file_path =~ 'petrzemek.net'
    au BufRead,BufNewFile *.txt setl ft=html
    au BufRead,BufNewFile *.txt setl spelllang=en
  " Other
  else
    au BufRead,BufNewFile *.txt setl ft=html
  endif

  augroup end
endif
]])
