"------------------------------------------------------------------------------
" s3rvac's Vim color scheme.
"
" Heavily based on the standard 'koehler' color scheme.
"
" Use together with the CSApprox plugin, which makes Vim use the GUI colors in
" the terminal.
"------------------------------------------------------------------------------

hi clear
set background=dark
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="s3rvac"

hi Normal           guifg=white guibg=black
hi Scrollbar        guifg=darkcyan guibg=cyan
hi Menu             guifg=black guibg=cyan
hi Pmenu            guifg=white guibg=gray30
hi PmenuSel         guifg=black guibg=white
hi SpecialKey       guifg=#cc0000
hi NonText          gui=bold guifg=#cc0000
hi Directory        guifg=#cc8000
hi ErrorMsg         guifg=white guibg=red
hi Search           guifg=white guibg=red
hi MoreMsg          gui=bold guifg=green1 guibg=black
hi ModeMsg          gui=bold guifg=white guibg=blue
hi LineNr           guifg=yellow
hi CursorLineNr     guifg=yellow
hi Question         gui=bold guifg=green
hi StatusLine       gui=bold guifg=white guibg=black
hi StatusLineNC     gui=none guifg=black guibg=gray70
hi Title            gui=bold guifg=magenta
hi Visual           guifg=black guibg=grey
hi WarningMsg       guifg=red
hi Cursor           guifg=bg guibg=white
hi Comment          guifg=#80a0ff
hi Constant         guifg=#ffa0a0
hi Special          guifg=orange
hi Identifier       guifg=#40ffff
hi Statement        gui=bold guifg=#ffff60
hi PreProc          guifg=#ff80ff
hi Type             gui=bold guifg=#60ff60
hi Error            guifg=red guibg=black
hi Todo             guifg=blue guibg=yellow
hi CursorLine       guibg=#555555
hi CursorColumn     guibg=#555555
hi MatchParen       guibg=blue
hi TabLine          gui=bold guifg=gray guibg=black
hi TabLineSel       gui=bold guifg=white guibg=black
hi TabLineFill      gui=bold guifg=black guibg=black
hi TabNum           guifg=orange
hi Underlined       gui=bold,underline guifg=lightblue
hi Ignore           guifg=black guibg=black
hi EndOfBuffer      gui=bold guifg=#cc0000
hi Folded           guifg=white guibg=gray30
hi FoldColumn       guifg=white guibg=gray30
hi ColorColumn      guifg=white guibg=gray19
hi VertSplit        gui=none guifg=white guibg=black

hi link IncSearch       Visual
hi link String          Constant
hi link Character       Constant
hi link Number          Constant
hi link Boolean         Constant
hi link Float           Number
hi link Function        Identifier
hi link Conditional     Statement
hi link Repeat          Statement
hi link Label           Statement
hi link Operator        Statement
hi link Keyword         Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link Delimiter       Special
hi link Debug           Special
hi link SpecialComment  Comment
