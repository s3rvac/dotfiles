-- Palette.
local p = {
  black = "#000000",
  white = "#ffffff",
  none = "none",
}

local theme = {}

function theme.setup()
  theme.highlights = {
    -- Base highlights
    Boolean = { link = "Number" },
    Character = { link = "String" },
    ColorColumn = { fg = p.white, bg = "gray19" },
    Comment = { fg = "#87afff", bg = p.none },
    Conceal = { fg = "#e5e5e5", bg = "#a9a9a9" },
    Conditional = { link = "Statement" },
    Constant = { fg = "#ffafaf", bg = p.none },
    CurSearch = { fg = "#ff0000", bg = "#ffff60", bold = true },
    Cursor = { fg = p.black, bg = "#00ff00" },
    CursorColumn = { fg = p.none, bg = "#555555" },
    CursorIM = { fg = p.none, bg = p.none },
    CursorLine = { fg = p.none, bg = "#555555" },
    CursorLineFold = { link = "CursorLine" },
    CursorLineNr = { fg = "#ffff00", bg = p.none, bold = true },
    CursorLineSign = { link = "CursorLine" },
    Debug = { link = "Special" },
    Define = { link = "PreProc" },
    Delimiter = { link = "Special" },
    DiffAdd = { fg = p.white, bg = "#000087" },
    DiffChange = { fg = p.white, bg = "#870087" },
    DiffDelete = { fg = "#0000ff", bg = "#008787", bold = true },
    DiffText = { fg = p.white, bg = "#ff0000", bold = true },
    Directory = { fg = "#cc8000", bg = p.none },
    EndOfBuffer = { fg = "#ff0000", bg = p.none, bold = true },
    Error = { fg = "#ff0000", bg = p.none },
    ErrorMsg = { fg = "#ff0000", bg = p.none },
    Exception = { link = "Statement" },
    Float = { link = "Number" },
    FloatBorder = { fg = p.white, bg = p.none },
    FoldColumn = { fg = p.white, bg = "gray30" },
    Folded = { fg = p.white, bg = "gray30" },
    Function = { fg = "#5fffff", bg = p.none },
    Identifier = { fg = p.white, bg = p.none },
    Ignore = { fg = p.black, bg = p.black },
    IncSearch = { link = "Search" },
    Include = { link = "PreProc" },
    Keyword = { link = "Statement" },
    Label = { link = "Special" },
    LineNr = { fg = "#ffff00", bg = p.none },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    Macro = { link = "PreProc" },
    MatchParen = { fg = p.none, bg = "#0000ff" },
    MessageWindow = { link = "Pmenu" },
    ModeMsg = { fg = p.white, bg = "#0000ff", bold = true },
    MoreMsg = { fg = "#00ff00", bg = p.none, bold = true },
    MsgSeparator = { fg = p.white, bg = p.black },
    NonText = { fg = "#cc0000", bg = p.none, bold = true },
    Normal = { fg = p.white, bg = p.black },
    NormalFloat = { bg = p.black },
    NormalNC = { fg = p.white, bg = p.black },
    Number = { link = "Constant" },
    Operator = { fg = p.white, bg = p.none },
    Pmenu = { fg = p.white, bg = "#282828" },
    PmenuSbar = { fg = p.none, bg = p.none },
    PmenuSel = { fg = p.black, bg = p.white },
    PmenuThumb = { fg = p.none, bg = p.white },
    PopupNotification = { link = "Todo" },
    PopupSelected = { link = "PmenuSel" },
    PreCondit = { link = "PreProc" },
    PreProc = { fg = "#ff80ff", bg = p.none },
    Question = { link = "MoreMsg" },
    QuickFixLine = { fg = p.black, bg = "#bcbcbc" },
    Repeat = { link = "Statement" },
    Search = { fg = p.black, bg = "#ffff60" },
    SignColumn = { fg = "#00ffff", bg = p.none },
    Special = { fg = "#ffa500", bg = p.none },
    SpecialChar = { link = "Special" },
    SpecialComment = { link = "Special" },
    SpecialKey = { fg = "#cc0000", bg = p.none },
    SpellBad = { sp = "#ff4040", undercurl = true },
    SpellCap = { sp = "#00aaff", undercurl = true },
    SpellLocal = { sp = "#00ffff", undercurl = true },
    SpellRare = { sp = "#ff00ff", undercurl = true },
    Statement = { fg = "#ffff60", bg = p.none, bold = true },
    StatusLine = { fg = p.white, bg = p.black, bold = true },
    StatusLineNC = { fg = p.black, bg = "#555555", bold = false },
    StatusLineTerm = { link = "StatusLine" },
    StatusLineTermNC = { link = "StatusLineNC" },
    StorageClass = { link = "Type" },
    String = { fg = "#ffafaf", bg = p.none },
    Structure = { link = "Type" },
    Substitute = { link = "Search" },
    TabLine = { fg = "#bcbcbc", bg = p.black, bold = true },
    TabLineFill = { fg = p.black, bg = p.black, bold = true },
    TabLineSel = { fg = p.white, bg = p.black, bold = true },
    TabNum = { fg = "orange", bg = p.black },
    Tag = { link = "Special" },
    Terminal = { link = "Normal" },
    Title = { fg = "#ff00ff", bg = p.none, bold = true },
    Todo = { fg = "#0000ff", bg = "#ffff00" },
    ToolbarButton = { fg = p.black, bg = "#e5e5e5", bold = true },
    ToolbarLine = { fg = p.none, bg = p.none },
    Type = { fg = "#5fff5f", bg = p.none, bold = true },
    Typedef = { link = "Type" },
    Underlined = { fg = "#add8e6", bg = p.none, bold = true, underline = true },
    VertSplit = { fg = p.white, bg = p.black },
    Visual = { fg = p.black, bg = "#bcbcbc" },
    VisualNOS = { fg = p.none, bg = p.black, bold = true, underline = true },
    WarningMsg = { fg = "#ffbf00", bg = p.none },
    Whitespace = { fg = "#ff0000", bg = p.none },
    WildMenu = { fg = p.black, bg = "#ffff00" },
    lCursor = { link = "Cursor" },

    -- The checkhealth command
    helpHeader = { link = "PreProc" },
    healthError = { link = "Error" },
    healthHelp = { link = "Normal" },
    healthSuccess = { fg = "#5fff00", bg = p.none },
    healthWarning = { link = "WarningMsg" },

    -- LSP
    LspInfoTitle = { link = "PreProc" },
    LspInfoList = { link = "Function" },
    LspInfoFiletype = { fg = "#5fff5f", bg = p.none },
    LspInfoTip = { link = "Comment" },
    LspInfoBorder = { link = "FloatBorder" },
    LspSignatureActiveParameter = { link = "Visual" },
    LspInlayHint = { fg = "#808080" },

    -- Diagnostics
    DiagnosticError = { fg = "#ff0000" },
    DiagnosticWarn = { fg = "#dbc074" },
    DiagnosticInfo = { fg = "#719cd6" },
    DiagnosticHint = { fg = "#c3ccdc" },
    DiagnosticOk = { fg = "#21c7a8" },
    DiagnosticUnderlineError = { sp = "#ff0000", undercurl = true },
    DiagnosticUnderlineWarn = { sp = "#dbc074", undercurl = true },
    DiagnosticUnderlineInfo = { sp = "#719cd6", undercurl = true },
    DiagnosticUnderlineHint = { sp = "#c3ccdc", undercurl = true },
    DiagnosticUnderlineOk = { sp = "#21c7a8", undercurl = true },
    DiagnosticVirtualTextError = { fg = "#ff0000", bg = "#3c2c3c" },
    DiagnosticVirtualTextWarn = { fg = "#dbc074", bg = "#40423e" },
    DiagnosticVirtualTextInfo = { fg = "#719cd6", bg = "#2b3b51" },
    DiagnosticVirtualTextHint = { fg = "#c3ccdc", bg = "#2e4045" },
    DiagnosticVirtualTextOk = { fg = "#21c7a8", bg = "#2e4045" },
    DiagnosticFloatingError = { link = "DiagnosticError" },
    DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
    DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
    DiagnosticFloatingHint = { link = "DiagnosticHint" },
    DiagnosticFloatingOk = { link = "DiagnosticOk" },
    DiagnosticSignError = { link = "DiagnosticError" },
    DiagnosticSignWarn = { link = "DiagnosticWarn" },
    DiagnosticSignInfo = { link = "DiagnosticInfo" },
    DiagnosticSignHint = { link = "DiagnosticHint" },
    DiagnosticSignOk = { link = "DiagnosticOk" },
    DiagnosticDeprecated = { sp = "#ff0000", strikethrough = true },
    DiagnosticUnnecessary = { sp = "#c3ccdc", undercurl = true },

    -- GitHub Copilot
    -- https://github.com/github/copilot.vim
    CopilotSuggestion = { fg = "#808080" },

    -- nvim-cmp
    -- https://github.com/hrsh7th/nvim-cmp
    CmpItemAbbrDeprecated = { fg = "#808080", bg = p.none, strikethrough = true },
    CmpItemAbbrMatch = { fg = "#33b1ff", bg = p.none },
    CmpItemAbbrMatchFuzzy = { link = "CmpIntemAbbrMatch" },
    CmpItemKindFunction = { fg = "#5fffff", bg = p.none },
    CmpItemKindMethod = { link = "CmpItemKindFunction" },
    CmpItemKindVariable = { fg = "#33b1ff", bg = p.none },
    CmpItemKindProperty = { link = "CmpItemKindVariable" },
    CmpItemKindClass = { fg = "#ffbf00", bg = p.none },
    CmpItemKindInterface = { link = "CmpItemKindClass" },
    CmpItemKindModule = { fg = "#bd95ff", bg = p.none },
    CmpItemKindConstant = { fg = "#ffafaf", bg = p.none },
    CmpItemKindKeyword = { fg = "#d4d4d4", bg = p.none },
    CmpItemKindUnit = { link = "CmpItemKindKeyword" },
    CmpItemKindText = { fg = p.white, bg = p.none },

    -- LuaSnip
    -- https://github.com/L3MON4D3/LuaSnip
    snippet = { fg = "#ffff60", bg = p.none, bold = true },

    -- nvim-treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter
    -- https://neovim.io/doc/user/treesitter.html#treesitter-highlight-groups
    ["@attribute"] = { link = "PreProc" },
    ["@attribute.builtin"] = { link = "@attribute" },
    ["@boolean"] = { link = "Boolean" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "Special" },
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "@comment" },
    ["@comment.error"] = { link = "@comment" },
    ["@comment.note"] = { link = "@comment" },
    ["@comment.todo"] = { link = "@comment" },
    ["@comment.warning"] = { link = "@comment" },
    ["@conditional"] = { link = "Conditional" },
    ["@conditional.ternary"] = { link = "Operator" },
    ["@constant"] = { link = "Identifier" },
    ["@constant.builtin"] = { link = "Constant" },
    ["@constant.macro"] = { link = "Constant" },
    ["@constructor"] = { link = "Identifier" },
    ["@constructor.call"] = { link = "Identifier" },
    ["@define"] = { link = "Define" },
    ["@diff.delta"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@diff.minus"] = { fg = "#b21818", bg = p.none },
    ["@diff.plus"] = { fg = "#18b218", bg = p.none },
    ["@error"] = { link = "Error" },
    ["@exception"] = { link = "Exception" },
    ["@field"] = { link = "Identifier" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Identifier" },
    ["@function.call"] = { link = "Identifier" },
    ["@function.macro"] = { link = "PreProc" },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "Identifier" },
    ["@include"] = { link = "Include" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.conditional"] = { link = "Keyword" },
    ["@keyword.conditional.ternary"] = { link = "Keyword" },
    ["@keyword.coroutine"] = { link = "Keyword" },
    ["@keyword.debug"] = { link = "Keyword" },
    ["@keyword.directive"] = { link = "PreProc" },
    ["@keyword.directive.define"] = { link = "PreProc" },
    ["@keyword.exception"] = { link = "Keyword" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@keyword.import"] = { link = "PreProc" },
    ["@keyword.modifier"] = { link = "Type" },
    ["@keyword.operator"] = { link = "Keyword" },
    ["@keyword.repeat"] = { link = "Keyword" },
    ["@keyword.return"] = { link = "Keyword" },
    ["@keyword.storage"] = { link = "Type" },
    ["@keyword.type"] = { link = "Type" },
    ["@label"] = { link = "Label" },
    ["@markup.environment"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@markup.heading"] = { link = "Title" },
    ["@markup.italic"] = { italic = true },
    ["@markup.link"] = { link = "Special" },
    ["@markup.link.label"] = { link = "Constant" },
    ["@markup.link.url"] = { link = "Underlined" },
    ["@markup.list"] = { link = "Special" },
    ["@markup.list.checked"] = { link = "Special" },
    ["@markup.list.unchecked"] = { link = "Special" },
    ["@markup.math"] = { link = "Special" },
    ["@markup.quote"] = { link = "Comment" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.raw.block"] = { link = "String" },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.underline"] = { underline = true },
    ["@method"] = { link = "Function" },
    ["@method.call"] = { link = "Identifier" },
    ["@module"] = { link = "Identifier" },
    ["@module.builtin"] = { link = "Identifier" },
    ["@namespace"] = { link = "Identifier" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "@number" },
    ["@operator"] = { link = "Operator" },
    ["@preproc"] = { link = "PreProc" },
    ["@property"] = { link = "Identifier" },
    ["@punctuation.bracket"] = { link = "Normal" },
    ["@punctuation.delimiter"] = { link = "Normal" },
    ["@punctuation.special"] = { link = "Special" },
    ["@repeat"] = { link = "Repeat" },
    ["@string"] = { link = "String" },
    ["@string.documentation"] = { link = "String" },
    ["@string.escape"] = { link = "@string.special" },
    ["@string.regexp"] = { link = "Special" }, -- E.g. regexes in Go
    ["@string.special"] = { link = "Special" },
    ["@string.special.path"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@string.special.symbol"] = { link = "Special" }, -- E.g. BibTeX entries
    ["@string.special.url"] = { link = "Underlined" }, -- E.g. HTML <a>
    ["@symbol"] = { link = "Constant" },
    ["@tag"] = { link = "Tag" },
    ["@tag.attribute"] = { link = "Type" },
    ["@tag.builtin"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@tag.delimiter"] = { link = "Function" },
    ["@text"] = { link = "Normal" },
    ["@text.danger"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.emphasis"] = { italic = true },
    ["@text.environment"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.environment.name"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.literal"] = { link = "String" },
    ["@text.literal.block"] = { link = "String" },
    ["@text.math"] = { link = "Special" },
    ["@text.note"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.reference"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.strike"] = { strikethrough = true },
    ["@text.strong"] = { bold = true },
    ["@text.title"] = { link = "Title" },
    ["@text.todo"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.todo.checked"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.todo.unchecked"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@text.underline"] = { link = "Underlined" },
    ["@text.uri"] = { link = "Underlined" },
    ["@text.warning"] = { fg = "red", bg = p.none }, -- TODO when encountered
    ["@type"] = { link = "Identifier" },
    ["@type.builtin"] = { link = "Type" },
    ["@type.definition"] = { link = "Identifier" },
    ["@type.qualifier"] = { link = "Type" },
    ["@variable"] = { link = "Identifier" },
    ["@variable.builtin"] = { link = "Identifier" },
    ["@variable.member"] = { link = "Identifier" },
    ["@variable.parameter"] = { link = "Identifier" },
    ["@variable.parameter.builtin"] = { link = "Identifier" },

    -- Language-specific highlights.
    --
    -- Bash
    ["@constant.bash"] = { link = "Identifier" },
    ["@function.builtin.bash"] = { link = "Function" },
    ["@function.call.bash"] = { link = "Function" },
    ["@operator.bash"] = { link = "Statement" },
    ["@punctuation.bracket.bash"] = { link = "Special" },
    ["@punctuation.delimiter.bash"] = { link = "Statement" },
    ["@punctuation.special.bash"] = { link = "Special" },
    -- C++
    ["@contructor.cpp"] = { link = "Function" },
    -- BibTeX
    ["@function.builtin.bibtex"] = { link = "Function" },
    ["@symbol.bibtex"] = { link = "Special" },
    -- CMake
    ["@function.builtin.cmake"] = { link = "Function" },
    ["@type.cmake"] = { link = "Type" },
    -- CSS
    cssBraces = { link = "Normal" },
    cssAttrComma = { link = "Normal" },
    -- Doxygen (I do not like any fancy syntax highlight; I prefer just comments)
    ["@keyword.doxygen"] = { link = "Comment" },
    ["@keyword.modifier.doxygen"] = { link = "Comment" },
    ["@punctuation.bracket.doxygen"] = { link = "Comment" },
    ["@variable.doxygen"] = { link = "Comment" },
    ["@variable.parameter.doxygen"] = { link = "Comment" },
    -- Gitconfig
    gitconfigVariable = { link = "Function" },
    -- Gitattributes
    ["@variable.builtin.gitattributes"] = { link = "Function" },
    -- Gitcommit (use similar colors to `git diff`)
    gitcommitDiff = { fg = "#b2b2b2", bg = p.none },
    diffAdded = { fg = "#18b218", bg = p.none },
    diffRemoved = { fg = "#b21818", bg = p.none },
    diffFile = { fg = p.white, bg = p.none, bold = true },
    diffLine = { fg = "#18b2b2", bg = p.none },
    diffIndexLine = { fg = p.white, bg = p.none, bold = true },
    diffSubName = { fg = "#b2b2b2", bg = p.none },
    -- Gitrebase
    gitrebaseCommit = { link = "Special" },
    gitrebaseHash = { link = "Special" },
    gitrebaseSummary = { link = "Normal" },
    gitrebasePick = { link = "Type" },
    gitrebaseReword = { link = "PreProc" },
    gitrebaseEdit = { link = "PreProc" },
    gitrebaseSquash = { link = "PreProc" },
    gitrebaseFixup = { link = "PreProc" },
    gitrebaseExec = { link = "PreProc" },
    gitrebaseBreak = { link = "PreProc" },
    gitrebaseDrop = { link = "PreProc" },
    gitrebaseNoop = { link = "PreProc" },
    gitrebaseMerge = { link = "PreProc" },
    gitrebaseLabel = { link = "PreProc" },
    gitrebaseReset = { link = "PreProc" },
    -- Haskell
    ["@constructor.haskell"] = { link = "Identifier" },
    ["@function.call.haskell"] = { link = "Function" },
    -- HTML
    ["@tag.html"] = { link = "Statement" },
    ["@constant.html"] = { link = "Constant" },
    htmlTag = { link = "Function" },
    htmlEndTag = { link = "Function" },
    -- INI
    dosiniHeader = { link = "PreProc" },
    dosiniLabel = { link = "Identifier" },
    dosiniValue = { link = "String" },
    -- JSON
    ["@property.json"] = { link = "Statement" },
    -- Kotlin
    ktAnnotation = { link = "PreProc" },
    -- Lua
    luaTable = { link = "Normal" },
    luaParenError = { link = "Normal" },
    luaError = { link = "Normal" },
    ["@constructor.lua"] = { link = "Identifier" },
    -- Makefile
    makeIdent = { link = "Function" },
    makeCommands = { link = "Normal" },
    -- Markdown
    ["@label.markdown"] = { link = "Constant" },
    -- Markdown (inline)
    ["@punctuation.bracket.markdown_inline"] = { link = "Special" },
    -- Proto
    ["@keyword.type.proto"] = { link = "Keyword" },
    ["@type.proto"] = { link = "Type" },
    -- Python
    pythonBuiltin = { link = "Identifier" },
    pythonOperator = { link = "Statement" },
    pythonDecoratorName = { link = "PreProc" },
    ["@type.builtin.python"] = { link = "Identifier" },
    ["@type.definition.python"] = { link = "Function" },
    -- RST
    rstInterpretedTextOrHyperlinkReference = { link = "Function" },
    -- Ruby
    ["@label.ruby"] = { link = "Identifier" },
    -- SQL
    ["@attribute.sql"] = { link = "Statement" },
    -- Terraform
    ["@keyword.terraform"] = { link = "Type" },
    ["@type.terraform"] = { link = "Type" },
    -- Tmux
    tmuxFlags = { link = "Function" },
    -- TOML
    ["@type.toml"] = { link = "PreProc" },
    tomlTable = { link = "PreProc" },
    tomlTableArray = { link = "PreProc" },
    -- Vim
    ["@variable.builtin.vim"] = { link = "PreProc" },
    -- Vimdoc
    ["@text.reference.vimdoc"] = { link = "Function" },
    ["@text.note.vimdoc"] = { link = "Normal" },
    -- XML
    ["@punctuation.delimiter.xml"] = { link = "String" },
    ["@tag.xml"] = { link = "Statement" },
    -- YAML
    yamlBlockMappingKey = { link = "Function" },
  }

  -- Set terminal colors.
  theme.terminal_colors = {
    terminal_color_0 = "#000000",
    terminal_color_1 = "#cd0000",
    terminal_color_2 = "#00cd00",
    terminal_color_3 = "#cdcd00",
    terminal_color_4 = "#0000ee",
    terminal_color_5 = "#cd00cd",
    terminal_color_6 = "#00cdcd",
    terminal_color_7 = "#e5e5e5",
    terminal_color_8 = "#7f7f7f",
    terminal_color_9 = "#ff0000",
    terminal_color_10 = "#00ff00",
    terminal_color_11 = "#ffff00",
    terminal_color_12 = "#5c5cff",
    terminal_color_13 = "#ff00ff",
    terminal_color_14 = "#00ffff",
    terminal_color_15 = "#ffffff",
  }
  for option, value in pairs(theme.terminal_colors) do
    vim.g[option] = value
  end

  -- Clear all semantic highlights as they break syntax highlighting in certain
  -- cases.
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end

  -- Set the highlights.
  for group, colors in pairs(theme.highlights) do
    if colors.style then
      if type(colors.style) == "table" then
        colors = vim.tbl_extend("force", colors, colors.style)
      end
      colors.style = nil
    end
    vim.api.nvim_set_hl(0, group, colors)
  end
end

return theme
