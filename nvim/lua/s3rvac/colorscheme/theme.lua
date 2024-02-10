-- Palette.
p = {
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
    CurSearch = { link = "Search" },
    Cursor = { fg = p.black, bg = "#00ff00" },
    CursorColumn = { fg = p.none, bg = "#555555" },
    CursorIM = { fg = p.none, bg = fg },
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
    Label = { link = "Statement" },
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
    QuickFixLine = { fg = p.black, bg = "#ffd700" },
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
    StatusLineNC = { fg = p.black, bg = "gray70" },
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
    CmpItemKindMethod = { link="CmpItemKindFunction" },
    CmpItemKindVariable = { fg = "#33b1ff", bg = p.none },
    CmpItemKindProperty = { link = "CmpItemKindVariable" },
    CmpItemKindClass = { fg = "#ffbf00", bg = p.none },
    CmpItemKindInterface = { link = "CmpItemKindClass" },
    CmpItemKindModule = { fg = "#bd95ff", bg = p.none },
    CmpItemKindConstant = { fg = "#ffafaf", bg = p.none },
    CmpItemKindKeyword = { fg = "#d4d4d4", bg = p.none },
    CmpItemKindUnit = { link = "CmpItemKindKeyword" },
    CmpItemKindText = { fg = p.white, bg = p.none },

    -- nvim-treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter
    -- ["@attribute"] = {},
    ["@boolean"] = { link = "Boolean" },
    ["@character"] = { link = "Character" },
    -- ["@character.special"] = {},
    ["@comment"] = { link = "Comment" },
    -- ["@comment.documentation"] = {},
    -- ["@comment.error"] = {},
    -- ["@comment.note"] = {},
    -- ["@comment.todo"] = {},
    -- ["@comment.warning"] = {},
    ["@conditional"] = { link = "Conditional" },
    -- ["@conditional.ternary"] = {},
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Constant" },
    -- ["@constant.macro"] = {},
    ["@constructor"] = { link = "Function" },
    ["@constructor.call"] = { link = "Identifier" },
    ["@define"] = { link = "Define" },
    -- ["@diff.delta"] = {},
    -- ["@diff.minus"] = {},
    -- ["@diff.plus"] = {},
    ["@error"] = { link = "Error" },
    ["@exception"] = { link = "Exception" },
    -- ["@field"] = {},
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Identifier" },
    ["@function.call"] = { link = "Identifier" },
    ["@function.macro"] = { link = "PreProc" },
    ["@function.method"] = { link = "Function" },
    ["@include"] = { link = "Include" },
    ["@keyword"] = { link = "Keyword" },
    -- ["@keyword.conditional"] = {},
    -- ["@keyword.conditional.ternary"] = {},
    -- ["@keyword.coroutine"] = {},
    -- ["@keyword.debug"] = {},
    -- ["@keyword.directive"] = {},
    -- ["@keyword.directive.define"] = {},
    -- ["@keyword.exception"] = {},
    -- ["@keyword.function"] = {},
    -- ["@keyword.import"] = {},
    -- ["@keyword.operator"] = {},
    -- ["@keyword.repeat"] = {},
    -- ["@keyword.return"] = {},
    -- ["@keyword.storage"] = {},
    ["@label"] = { link = "Label" },
    -- ["@markup.environment"] = {},
    -- ["@markup.heading"] = {},
    -- ["@markup.italic"] = {},
    -- ["@markup.link"] = {},
    -- ["@markup.link.label"] = {},
    -- ["@markup.link.url"] = {},
    -- ["@markup.list"] = {},
    -- ["@markup.list.checked"] = {},
    -- ["@markup.list.unchecked"] = {},
    -- ["@markup.math"] = {},
    -- ["@markup.quote"] = {},
    -- ["@markup.raw"] = {},
    -- ["@markup.raw.block"] = {},
    -- ["@markup.strikethrough"] = {},
    -- ["@markup.strong"] = {},
    -- ["@markup.underline"] = {},
    ["@method"] = { link = "Function" },
    ["@method.call"] = { link = "Identifier" },
    -- ["@module"] = {},
    -- ["@module.builtin"] = {},
    -- ["@namespace"] = {},
    ["@number"] = { link = "Number" },
    -- ["@number.float"] = {},
    ["@operator"] = { link = "Operator" },
    ["@preproc"] = { link = "PreProc" },
    -- ["@property"] = {},
    ["@punctuation.bracket"] = { link = "Normal" },
    ["@punctuation.delimiter"] = { link = "Normal" },
    ["@punctuation.special"] = { link = "Special" },
    ["@repeat"] = { link = "Repeat" },
    ["@string"] = { link = "String" },
    -- ["@string.documentation"] = {},
    -- ["@string.escape"] = {},
    -- ["@string.regexp"] = {},
    ["@string.special"] = { link = "Special" },
    -- ["@string.special.path"] = {},
    -- ["@string.special.symbol"] = {},
    -- ["@string.special.url"] = {},
    -- ["@symbol"] = {},
    ["@tag"] = { link = "Tag" },
    -- ["@tag.attribute"] = {},
    -- ["@tag.delimiter"] = {},
    -- ["@text"] = {},
    -- ["@text.danger"] = {},
    ["@text.emphasis"] = { italic = true },
    -- ["@text.environment"] = {},
    -- ["@text.environment.name"] = {},
    ["@text.literal"] = { link = "String" },
    ["@text.literal.block"] = { link = "String" },
    -- ["@text.math"] = {},
    -- ["@text.note"] = {},
    -- ["@text.reference"] = {},
    ["@text.strike"] = { strikethrough = true },
    ["@text.strong"] = { bold = true },
    ["@text.title"] = { link = "Title"},
    -- ["@text.todo"] = {},
    -- ["@text.todo.checked"] = {},
    -- ["@text.todo.unchecked"] = {},
    ["@text.underline"] = { link = "Underline" },
    -- ["@text.uri"] = {},
    -- ["@text.warning"] = {},
    ["@type"] = { link = "Identifier" },
    ["@type.builtin"] = { link = "Type" },
    ["@type.definition"] = { link = "Identifier" },
    ["@type.qualifier"] = { link = "Type" },
    ["@variable"] = { fg = p.white },
    -- ["@variable.builtin"] = {},
    -- ["@variable.member"] = {},
    -- ["@variable.parameter"] = {},

    -- Language-specific highlights.
    --
    -- Bash
    ["@function.builtin.bash"] = { link = "Function" },
    ["@function.call.bash"] = { link = "Function" },
    ["@operator.bash"] = { link = "Statement" },
    ["@punctuation.bracket.bash"] = { link = "Special" },
    ["@punctuation.delimiter.bash"] = { link = "Statement" },
    ["@punctuation.special.bash"] = { link = "Special" },
    -- Git
    gitconfigVariable = { link = "Function" },
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
    htmlTag = { link = "Function" },
    htmlEndTag = { link = "Function" },
    -- INI
    dosiniHeader = { link = "PreProc" },
    dosiniLabel = { link = "Identifier" },
    dosiniValue = { link = "String" },
    -- JSON
    -- ["@punctuation.bracket.json"] = { link = "Special" }, XXX
    -- Lua
    ["@constructor.lua"] = { link = "Identifier" },
    -- Makefile
    makeIdent = { link = "Function" },
    makeCommands = { link = "Normal" },
    -- Markdown
    ["@label.markdown"] = { link = "Constant" },
    ["@punctuation.bracket.markdown_inline"] = { link = "Special" },
    ["@text.quote.markdown"] = { link = "Comment" },
    ["@text.reference.markdown_inline"] = { link = "Underlined" },
    ["@text.uri.markdown_inline"] = { link = "Constant" },
    -- Python
    pythonBuiltin = { link = "Identifier" },
    pythonOperator = { link = "Statement" },
    -- SQL
    ["@attribute.sql"] = { link = "Statement" },
    -- Terraform
    hclBraces = { link = "Normal" },
    -- TOML
    tomlTable = { link = "PreProc" },
    tomlTableArray = { link = "PreProc" },
    -- Vim
    ["@variable.builtin.vim"] = { link = "PreProc" },
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

  -- Hide all semantic highlights.
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
