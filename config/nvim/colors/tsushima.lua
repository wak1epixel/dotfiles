vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "tsushima"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- tsushima — one yellow, and white for what it says.
-- There is no yellow ramp. #F6D75C is the colour: text, keywords,
-- types, operators, properties — all of it, unshaded.
-- White is the other quarter, and it goes to what the code says
-- out loud: strings, numbers, constants, and the names it calls.
-- Roughly 75 yellow / 25 white by token.
-- The off-shades are deliberately rare: amber for the handful of
-- tokens that reach outside the file (imports, macros, escapes,
-- self), dim gold for chrome, grey for comments, red for errors.
-- ══════════════════════════════════════════════════════════════
local bg = "#16120b" -- editor background — near-black, warm brown cast
local bg2 = "#1d1811" -- floats, pmenu, statusline
local bg3 = "#241e14" -- cursorline / cursorcolumn

--local gold = "#FFEE8C" -- THE yellow — ~75% of everything on screen
local gold = "#F9E076" -- THE yellow — ~75% of everything on screen
--local white = "#F3EAAF" -- the other voice — literals and call names
local white = "#fffeb6" -- the other voice — literals and call names

-- ── the rare ones ────────────────────────────────────────────
local amber = "#F6D75D" -- reaches outside the file: imports, macros, self
local grey = "#757169" -- comments only
local ember = "#d9553a" -- errors / deletions — the one non-yellow

-- ── chrome (UI, not code) ────────────────────────────────────
local dim = "#E3B778" -- line numbers, borders, folds, punct in chrome
local dim_d = "#3e3620" -- whitespace, indent guides

-- ── dark yellow fills (backgrounds, never text) ──────────────
local sel = "#4e4116" -- pmenu / picker selection, matched paren
local visual = "#3a2f11" -- visual selection
local glow = "#2a2210" -- lsp reference / word-under-cursor

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — this is the part to edit.
-- Most lines point at `gold` on purpose. Moving one to `white`
-- shifts the 75/25 balance, so move them in pairs if you care.
-- ══════════════════════════════════════════════════════════════
local c_text = gold -- variables, properties, plain code — the workhorse
local c_comment = grey -- comments and doc-comments
local c_string = white -- strings, chars, raw text
local c_number = gold -- numbers and named constants — plain yellow, like the code around them
local c_bool = white -- booleans, None / NULL / nil — values spoken out loud
local c_keyword = gold -- if / for / return / const, control flow
local c_func = white -- function names and calls
local c_type = gold -- types, classes, structs, enums
local c_import = amber -- import / include / use, modules, namespaces
local c_punct = gold -- brackets, operators, delimiters
local c_special = amber -- escapes, macros, decorators, self / this
local c_error = ember
local c_warn = amber
local c_hint = dim
local c_info = dim

local bg_alt = bg2 -- floats, pmenu
local bg_visual = visual -- visual selection
local bg_sel = sel -- pmenu / picker selection

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.tsushima_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.tsushima_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = dim, bg = BG_A },
  FloatTitle = { fg = c_func, bg = BG_A, bold = true },
  LineNr = { fg = dim },
  LineNrAbove = { fg = dim },
  LineNrBelow = { fg = dim },
  CursorLineNr = { fg = gold, bold = true },
  CursorLine = { bg = clear and "none" or bg3 },
  CursorColumn = { bg = bg3 },
  ColorColumn = { bg = bg3 },
  Visual = { bg = bg_visual },
  VisualNOS = { bg = bg_visual },
  Search = { fg = bg, bg = gold },
  IncSearch = { fg = bg, bg = amber },
  CurSearch = { fg = bg, bg = amber },
  Substitute = { fg = bg, bg = ember },
  MatchParen = { fg = white, bg = sel, bold = true },
  StatusLine = { fg = bg, bg = gold, bold = true },
  StatusLineNC = { fg = dim, bg = BG_A },
  WinBar = { fg = c_text, bg = BG },
  WinBarNC = { fg = dim, bg = BG },
  TabLine = { fg = dim, bg = BG_A },
  TabLineFill = { bg = BG },
  TabLineSel = { fg = bg, bg = gold, bold = true },
  WinSeparator = { fg = dim, bg = BG },
  VertSplit = { fg = dim, bg = BG },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = white, bg = bg_sel, bold = true },
  PmenuSbar = { bg = bg2 },
  PmenuThumb = { bg = dim },
  PmenuKind = { fg = c_type, bg = BG_A },
  PmenuExtra = { fg = dim, bg = BG_A },
  WildMenu = { fg = bg, bg = gold },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = dim, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = dim },
  Whitespace = { fg = dim_d },
  EndOfBuffer = { fg = clear and dim_d or bg },
  Directory = { fg = c_type },
  Title = { fg = c_func, bold = true },
  Question = { fg = c_hint },
  ModeMsg = { fg = c_keyword, bold = true },
  MsgArea = { fg = c_text },
  MoreMsg = { fg = c_hint },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = dim },
  SpecialKey = { fg = dim },
  Cursor = { fg = bg, bg = gold },
  lCursor = { fg = bg, bg = gold },
  TermCursor = { fg = bg, bg = gold },
  QuickFixLine = { bg = visual, bold = true },
  SpellBad = { undercurl = true, sp = c_error },
  SpellCap = { undercurl = true, sp = c_warn },
  SpellLocal = { undercurl = true, sp = c_info },
  SpellRare = { undercurl = true, sp = c_hint },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError = { fg = c_error },
  DiagnosticWarn = { fg = c_warn },
  DiagnosticInfo = { fg = c_info },
  DiagnosticHint = { fg = c_hint },
  DiagnosticOk = { fg = gold },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk = { undercurl = true, sp = gold },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn = { fg = c_warn },
  DiagnosticVirtualTextInfo = { fg = c_info },
  DiagnosticVirtualTextHint = { fg = c_hint },
  DiagnosticUnnecessary = { fg = dim, undercurl = true, sp = dim },
  DiagnosticDeprecated = { fg = dim, strikethrough = true },

  DiffAdd = { fg = gold, bg = "#282210" },
  DiffDelete = { fg = c_error, bg = "#2c1610" },
  DiffChange = { fg = amber, bg = "#2b2416" },
  DiffText = { fg = white, bg = sel },
  Added = { fg = gold },
  Changed = { fg = amber },
  Removed = { fg = c_error },

  -- ── legacy vim groups (non-treesitter buffers) ───────────
  Comment = { fg = c_comment, italic = true },
  Constant = { fg = c_number },
  String = { fg = c_string },
  Character = { fg = c_string },
  Number = { fg = c_number },
  Boolean = { fg = c_bool },
  Float = { fg = c_number },
  Identifier = { fg = c_text },
  Function = { fg = c_func },
  Statement = { fg = c_keyword },
  Conditional = { fg = c_keyword },
  Repeat = { fg = c_keyword },
  Label = { fg = c_keyword },
  Operator = { fg = c_punct },
  Keyword = { fg = c_keyword },
  Exception = { fg = c_keyword, bold = true },
  PreProc = { fg = c_import },
  Include = { fg = c_import },
  Define = { fg = c_import },
  Macro = { fg = c_special },
  PreCondit = { fg = c_import },
  Type = { fg = c_type },
  StorageClass = { fg = c_keyword },
  Structure = { fg = c_type },
  Typedef = { fg = c_type },
  Special = { fg = c_special },
  SpecialChar = { fg = c_special },
  SpecialComment = { fg = c_comment, bold = true },
  Tag = { fg = c_type },
  Delimiter = { fg = c_punct },
  Debug = { fg = c_special },
  Underlined = { fg = c_type, underline = true },
  Ignore = { fg = dim },
  Error = { fg = c_error, bold = true },
  Todo = { fg = bg, bg = c_func, bold = true },

  -- ── treesitter: text and identifiers ─────────────────────
  ["@variable"] = { fg = c_text },
  ["@variable.member"] = { fg = c_text },
  ["@variable.parameter"] = { fg = c_text, italic = true },
  ["@variable.parameter.builtin"] = { fg = c_special, italic = true },
  ["@variable.builtin"] = { fg = c_special, italic = true }, -- self, this
  ["@property"] = { fg = c_text },
  ["@field"] = { fg = c_text },

  -- ── treesitter: functions ────────────────────────────────
  ["@function"] = { fg = c_func },
  ["@function.call"] = { fg = c_func },
  ["@function.method"] = { fg = c_func },
  ["@function.method.call"] = { fg = c_func },
  ["@function.builtin"] = { fg = c_func, italic = true },
  ["@function.macro"] = { fg = c_special },
  ["@constructor"] = { fg = c_type },

  -- ── treesitter: types ────────────────────────────────────
  ["@type"] = { fg = c_type },
  ["@type.builtin"] = { fg = c_type },
  ["@type.definition"] = { fg = c_type, bold = true },
  ["@type.qualifier"] = { fg = c_keyword, italic = true }, -- const, static
  ["@module"] = { fg = c_import },
  ["@module.builtin"] = { fg = c_import, italic = true },
  ["@namespace"] = { fg = c_import },

  -- ── treesitter: keywords ─────────────────────────────────
  ["@keyword"] = { fg = c_keyword },
  ["@keyword.function"] = { fg = c_keyword },
  ["@keyword.return"] = { fg = c_keyword, bold = true },
  ["@keyword.conditional"] = { fg = c_keyword },
  ["@keyword.conditional.ternary"] = { fg = c_punct },
  ["@keyword.repeat"] = { fg = c_keyword },
  ["@keyword.operator"] = { fg = c_keyword }, -- sizeof, new, not, in
  ["@keyword.exception"] = { fg = c_keyword, bold = true },
  ["@keyword.modifier"] = { fg = c_keyword, italic = true },
  ["@keyword.coroutine"] = { fg = c_keyword, italic = true }, -- async, await
  ["@keyword.type"] = { fg = c_keyword }, -- class, struct, def
  ["@keyword.debug"] = { fg = c_special },

  -- ── treesitter: literals ─────────────────────────────────
  ["@string"] = { fg = c_string },
  ["@string.escape"] = { fg = c_special },
  ["@string.special"] = { fg = c_special },
  ["@string.regexp"] = { fg = c_special },
  ["@character"] = { fg = c_string },
  ["@character.special"] = { fg = c_special },
  ["@number"] = { fg = c_number },
  ["@number.float"] = { fg = c_number },
  ["@boolean"] = { fg = c_bool },
  ["@constant"] = { fg = c_number },
  ["@constant.builtin"] = { fg = c_bool }, -- True, False, None, nullptr
  ["@constant.macro"] = { fg = c_special, bold = true },

  -- ── treesitter: punctuation ──────────────────────────────
  ["@operator"] = { fg = c_punct },
  ["@punctuation"] = { fg = c_punct },
  ["@punctuation.bracket"] = { fg = c_punct },
  ["@punctuation.delimiter"] = { fg = c_punct },
  ["@punctuation.special"] = { fg = c_special }, -- f-string {} braces
  ["@label"] = { fg = c_keyword },
  ["@attribute"] = { fg = c_special, italic = true }, -- decorators, [[attrs]]
  ["@attribute.builtin"] = { fg = c_special, italic = true },

  -- ── treesitter: comments ─────────────────────────────────
  ["@comment"] = { fg = c_comment, italic = true },
  ["@comment.documentation"] = { fg = c_comment, italic = true },
  ["@comment.error"] = { fg = c_error },
  ["@comment.warning"] = { fg = c_warn },
  ["@comment.todo"] = { fg = bg, bg = c_func, bold = true },
  ["@comment.note"] = { fg = bg, bg = c_hint, bold = true },

  -- ── C / C++ ──────────────────────────────────────────────
  ["@keyword.import"] = { fg = c_import }, -- #include, import
  ["@keyword.directive"] = { fg = c_import }, -- #pragma
  ["@keyword.directive.define"] = { fg = c_import }, -- #define
  ["@preproc"] = { fg = c_import },
  ["@string.special.path"] = { fg = c_import, italic = true }, -- <iostream>
  ["@variable.member.cpp"] = { fg = c_text },
  ["@lsp.type.class.cpp"] = { fg = c_type },
  ["@lsp.typemod.variable.fileScope.cpp"] = { fg = c_number },
  ["@lsp.typemod.variable.globalScope.cpp"] = { fg = c_number },

  -- ── Python ───────────────────────────────────────────────
  ["@function.decorator"] = { fg = c_special, italic = true },
  ["@function.decorator.python"] = { fg = c_special, italic = true },
  ["@string.documentation"] = { fg = c_string, italic = true }, -- docstrings
  ["@type.builtin.python"] = { fg = c_type, italic = true }, -- int, str, list
  ["@lsp.type.selfKeyword.python"] = { fg = c_special, italic = true },
  ["@lsp.typemod.variable.readonly.python"] = { fg = c_number },

  -- ── markup ───────────────────────────────────────────────
  ["@markup.heading"] = { fg = c_keyword, bold = true },
  ["@markup.heading.1"] = { fg = c_keyword, bold = true },
  ["@markup.heading.2"] = { fg = c_func, bold = true },
  ["@markup.heading.3"] = { fg = c_type },
  ["@markup.strong"] = { fg = white, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.strikethrough"] = { fg = dim, strikethrough = true },
  ["@markup.link"] = { fg = c_import, underline = true },
  ["@markup.link.url"] = { fg = c_type, underline = true },
  ["@markup.link.label"] = { fg = c_import },
  ["@markup.raw"] = { fg = c_string },
  ["@markup.raw.block"] = { fg = c_string },
  ["@markup.list"] = { fg = c_keyword },
  ["@markup.list.checked"] = { fg = gold },
  ["@markup.list.unchecked"] = { fg = dim },
  ["@markup.quote"] = { fg = c_comment, italic = true },
  ["@diff.plus"] = { fg = gold },
  ["@diff.minus"] = { fg = c_error },
  ["@diff.delta"] = { fg = amber },
  ["@tag"] = { fg = c_type },
  ["@tag.attribute"] = { fg = c_special },
  ["@tag.delimiter"] = { fg = c_punct },

  -- ── LSP semantic tokens (win over treesitter when attached) ──
  ["@lsp.type.class"] = { fg = c_type },
  ["@lsp.type.struct"] = { fg = c_type },
  ["@lsp.type.enum"] = { fg = c_type },
  ["@lsp.type.interface"] = { fg = c_type },
  ["@lsp.type.type"] = { fg = c_type },
  ["@lsp.type.typeParameter"] = { fg = c_type, italic = true },
  ["@lsp.type.namespace"] = { fg = c_import },
  ["@lsp.type.function"] = { fg = c_func },
  ["@lsp.type.method"] = { fg = c_func },
  ["@lsp.type.macro"] = { fg = c_special },
  ["@lsp.type.variable"] = { fg = c_text },
  ["@lsp.type.property"] = { fg = c_text },
  ["@lsp.type.parameter"] = { fg = c_text, italic = true },
  ["@lsp.type.enumMember"] = { fg = c_number },
  ["@lsp.type.keyword"] = { fg = c_keyword },
  ["@lsp.type.operator"] = { fg = c_punct },
  ["@lsp.type.string"] = { fg = c_string },
  ["@lsp.type.number"] = { fg = c_number },
  ["@lsp.type.comment"] = { fg = c_comment, italic = true },
  ["@lsp.type.decorator"] = { fg = c_special, italic = true },
  ["@lsp.mod.readonly"] = { fg = c_number },
  ["@lsp.typemod.variable.readonly"] = { fg = c_number },
  ["@lsp.typemod.function.defaultLibrary"] = { fg = c_func, italic = true },
  ["@lsp.typemod.variable.defaultLibrary"] = { fg = c_special, italic = true },
  ["@lsp.typemod.class.defaultLibrary"] = { fg = c_type, italic = true },
  ["@lsp.typemod.type.defaultLibrary"] = { fg = c_type, italic = true },

  LspReferenceText = { bg = glow },
  LspReferenceRead = { bg = glow },
  LspReferenceWrite = { bg = glow, underline = true },
  LspSignatureActiveParameter = { fg = c_func, bold = true },
  LspInlayHint = { fg = dim, bg = BG_A, italic = true },
  LspCodeLens = { fg = dim, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = c_text, bg = BG_A },
  TelescopeBorder = { fg = dim, bg = BG_A },
  TelescopeSelection = { fg = white, bg = bg_sel },
  TelescopeSelectionCaret = { fg = c_keyword, bg = bg_sel },
  TelescopeMatching = { fg = c_func, bold = true },
  TelescopePromptTitle = { fg = bg, bg = c_keyword, bold = true },
  TelescopeResultsTitle = { fg = bg, bg = c_func, bold = true },
  TelescopePreviewTitle = { fg = bg, bg = amber, bold = true },
  NeoTreeNormal = { fg = c_text, bg = BG },
  NeoTreeNormalNC = { fg = c_text, bg = BG },
  NeoTreeDirectoryName = { fg = c_type },
  NeoTreeDirectoryIcon = { fg = c_type },
  NeoTreeRootName = { fg = c_keyword, bold = true },
  NeoTreeIndentMarker = { fg = dim },
  NeoTreeGitModified = { fg = amber },
  NeoTreeGitAdded = { fg = gold },
  NeoTreeGitDeleted = { fg = c_error },
  NeoTreeGitUntracked = { fg = c_import },
  NvimTreeNormal = { fg = c_text, bg = BG },
  NvimTreeFolderName = { fg = c_type },
  NvimTreeFolderIcon = { fg = c_type },
  NvimTreeRootFolder = { fg = c_keyword, bold = true },
  NvimTreeIndentMarker = { fg = dim },
  WhichKeyFloat = { bg = BG_A },
  WhichKeyNormal = { bg = BG_A },
  WhichKey = { fg = c_keyword },
  WhichKeyGroup = { fg = c_type },
  WhichKeyDesc = { fg = c_text },
  WhichKeySeparator = { fg = dim },
  GitSignsAdd = { fg = gold },
  GitSignsChange = { fg = amber },
  GitSignsDelete = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = grey, italic = true },
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = dim, strikethrough = true },
  CmpItemAbbrMatch = { fg = c_func, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = c_func },
  CmpItemKind = { fg = c_type },
  CmpItemMenu = { fg = dim },
  BlinkCmpMenu = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder = { fg = dim, bg = BG_A },
  BlinkCmpMenuSelection = { fg = white, bg = bg_sel, bold = true },
  BlinkCmpLabelMatch = { fg = c_func, bold = true },
  BlinkCmpKind = { fg = c_type },
  BlinkCmpDoc = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder = { fg = dim, bg = BG_A },
  SnacksNormal = { fg = c_text, bg = BG_A },
  SnacksWinBar = { fg = c_func, bg = BG_A, bold = true },
  SnacksBackdrop = { bg = bg },
  SnacksDashboardHeader = { fg = gold },
  SnacksDashboardIcon = { fg = c_keyword },
  SnacksDashboardDesc = { fg = c_text },
  SnacksDashboardKey = { fg = c_func },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch = { fg = c_func, bold = true },
  SnacksPickerDir = { fg = dim },
  SnacksIndent = { fg = dim_d },
  SnacksIndentScope = { fg = dim },
  IblIndent = { fg = dim_d },
  IblScope = { fg = dim },
  MiniIndentscopeSymbol = { fg = dim },
  FlashLabel = { fg = bg, bg = c_error, bold = true },
  FlashMatch = { fg = white, bg = sel },
  TroubleNormal = { fg = c_text, bg = BG_A },
  TroubleText = { fg = c_text },
  TroubleCount = { fg = c_func, bold = true },
  LazyNormal = { fg = c_text, bg = BG_A },
  LazyH1 = { fg = bg, bg = gold, bold = true },
  LazyButtonActive = { fg = bg, bg = c_func, bold = true },
  LazyProgressDone = { fg = gold },
  MasonNormal = { fg = c_text, bg = BG_A },
  MasonHeader = { fg = bg, bg = gold, bold = true },
  MasonHighlight = { fg = c_type },
  MasonMutedBlock = { fg = c_text, bg = bg_sel },
  NotifyINFOBorder = { fg = c_info },
  NotifyINFOIcon = { fg = c_info },
  NotifyINFOTitle = { fg = c_info },
  NotifyWARNBorder = { fg = c_warn },
  NotifyWARNIcon = { fg = c_warn },
  NotifyWARNTitle = { fg = c_warn },
  NotifyERRORBorder = { fg = c_error },
  NotifyERRORIcon = { fg = c_error },
  NotifyERRORTitle = { fg = c_error },
  IlluminatedWordText = { bg = glow },
  IlluminatedWordRead = { bg = glow },
  IlluminatedWordWrite = { bg = glow },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── terminal palette ────────────────────────────────────────
vim.g.terminal_color_0 = bg2
vim.g.terminal_color_1 = ember
vim.g.terminal_color_2 = dim
vim.g.terminal_color_3 = gold
vim.g.terminal_color_4 = amber
vim.g.terminal_color_5 = "#c9922f"
vim.g.terminal_color_6 = "#e6cf7e"
vim.g.terminal_color_7 = gold
vim.g.terminal_color_8 = grey
vim.g.terminal_color_9 = "#e86b4d"
vim.g.terminal_color_10 = "#a89141"
vim.g.terminal_color_11 = "#ffe783"
vim.g.terminal_color_12 = "#f0b658"
vim.g.terminal_color_13 = "#e0a33c"
vim.g.terminal_color_14 = "#f4e5a8"
vim.g.terminal_color_15 = white
