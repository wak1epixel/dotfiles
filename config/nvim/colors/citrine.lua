vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "citrine"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- citrine — a single hue family: yellow.
-- Every code colour is a yellow. Separation comes from where it
-- sits on the yellow arc — green-leaning citron on one end,
-- orange-leaning amber on the other — plus lightness.
-- The only non-yellow is the error red, so a mistake can't hide.
-- ══════════════════════════════════════════════════════════════
local bg = "#13110a" -- editor background — near-black, warm olive cast
local bg2 = "#1a1710" -- floats, pmenu, statusline
local bg3 = "#211d13" -- cursorline / cursorcolumn

-- ── the yellow arc: green-leaning ➜ orange-leaning ────────────
local citron = "#aeb857" -- green-yellow — strings
local lemon = "#e4e07f" -- pale yellow, faint green cast — types
local cream = "#f8f1c9" -- lightest tone — numbers, constants
local honey = "#f6d366" -- bright warm yellow — functions
local gold = "#e8b73f" -- saturated core yellow — keywords
local amber = "#f0a94e" -- orange-yellow — escapes, macros, self
local ochre = "#c9922f" -- deep orange-yellow — imports, modules

-- ── the dim end: text and chrome ─────────────────────────────
local flax = "#d6ca9e" -- desaturated pale yellow — plain code
local straw = "#9a8f64" -- brackets, operators — recedes
local moss = "#6f6a47" -- comments — dim, slightly green
local husk = "#5a5238" -- line numbers, borders, folds
local husk_d = "#2b2718" -- whitespace, indent guides

local ember = "#e05a3a" -- errors / deletions — the one non-yellow

-- ── dark yellow fills (backgrounds, never text) ──────────────
local sel = "#4e4318" -- pmenu / picker selection, matched paren
local visual = "#3a3212" -- visual selection
local glow = "#2b2611" -- lsp reference / word-under-cursor

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — this is the part to edit.
-- Every highlight below points at one of these, so changing a
-- line here re-themes everything that uses it.
-- ══════════════════════════════════════════════════════════════
local c_text = flax -- variables, properties, plain code — the workhorse
local c_comment = moss -- comments and doc-comments
local c_string = citron -- strings, chars, raw text
local c_number = cream -- numbers, booleans, constants — palest, pops out
local c_keyword = gold -- if / for / return / const, control flow
local c_func = honey -- function names and calls
local c_type = lemon -- types, classes, structs, enums
local c_import = ochre -- import / include / use, modules, namespaces
local c_punct = straw -- brackets, operators, delimiters — recedes
local c_special = amber -- escapes, macros, decorators, self / this
local c_error = ember
local c_warn = gold
local c_hint = citron
local c_info = straw

local bg_alt = bg2 -- floats, pmenu
local bg_visual = visual -- visual selection
local bg_sel = sel -- pmenu / picker selection

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.citrine_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.citrine_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = husk, bg = BG_A },
  FloatTitle = { fg = c_func, bg = BG_A, bold = true },
  LineNr = { fg = husk },
  LineNrAbove = { fg = husk },
  LineNrBelow = { fg = husk },
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
  MatchParen = { fg = cream, bg = sel, bold = true },
  StatusLine = { fg = bg, bg = gold, bold = true },
  StatusLineNC = { fg = husk, bg = BG_A },
  WinBar = { fg = c_text, bg = BG },
  WinBarNC = { fg = husk, bg = BG },
  TabLine = { fg = husk, bg = BG_A },
  TabLineFill = { bg = BG },
  TabLineSel = { fg = bg, bg = gold, bold = true },
  WinSeparator = { fg = husk, bg = BG },
  VertSplit = { fg = husk, bg = BG },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = cream, bg = bg_sel, bold = true },
  PmenuSbar = { bg = bg2 },
  PmenuThumb = { bg = husk },
  PmenuKind = { fg = c_type, bg = BG_A },
  PmenuExtra = { fg = husk, bg = BG_A },
  WildMenu = { fg = bg, bg = gold },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = husk, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = husk },
  Whitespace = { fg = husk_d },
  EndOfBuffer = { fg = clear and husk_d or bg },
  Directory = { fg = c_type },
  Title = { fg = c_func, bold = true },
  Question = { fg = c_hint },
  ModeMsg = { fg = c_keyword, bold = true },
  MsgArea = { fg = c_text },
  MoreMsg = { fg = c_hint },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = husk },
  SpecialKey = { fg = husk },
  Cursor = { fg = bg, bg = flax },
  lCursor = { fg = bg, bg = flax },
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
  DiagnosticOk = { fg = citron },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk = { undercurl = true, sp = citron },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn = { fg = c_warn },
  DiagnosticVirtualTextInfo = { fg = c_info },
  DiagnosticVirtualTextHint = { fg = c_hint },
  DiagnosticUnnecessary = { fg = husk, undercurl = true, sp = husk },
  DiagnosticDeprecated = { fg = husk, strikethrough = true },

  DiffAdd = { fg = citron, bg = "#1f2410" },
  DiffDelete = { fg = c_error, bg = "#2c1610" },
  DiffChange = { fg = c_func, bg = "#282111" },
  DiffText = { fg = cream, bg = sel },
  Added = { fg = citron },
  Changed = { fg = c_func },
  Removed = { fg = c_error },

  -- ── legacy vim groups (non-treesitter buffers) ───────────
  Comment = { fg = c_comment, italic = true },
  Constant = { fg = c_number },
  String = { fg = c_string },
  Character = { fg = c_string },
  Number = { fg = c_number },
  Boolean = { fg = c_number },
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
  Ignore = { fg = husk },
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
  ["@boolean"] = { fg = c_number },
  ["@constant"] = { fg = c_number, bold = true },
  ["@constant.builtin"] = { fg = c_number, bold = true }, -- True, False, None, nullptr
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
  ["@markup.strong"] = { fg = cream, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.strikethrough"] = { fg = husk, strikethrough = true },
  ["@markup.link"] = { fg = c_import, underline = true },
  ["@markup.link.url"] = { fg = c_type, underline = true },
  ["@markup.link.label"] = { fg = c_import },
  ["@markup.raw"] = { fg = c_string },
  ["@markup.raw.block"] = { fg = c_string },
  ["@markup.list"] = { fg = c_keyword },
  ["@markup.list.checked"] = { fg = citron },
  ["@markup.list.unchecked"] = { fg = husk },
  ["@markup.quote"] = { fg = c_comment, italic = true },
  ["@diff.plus"] = { fg = citron },
  ["@diff.minus"] = { fg = c_error },
  ["@diff.delta"] = { fg = c_func },
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
  LspInlayHint = { fg = husk, bg = BG_A, italic = true },
  LspCodeLens = { fg = husk, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = c_text, bg = BG_A },
  TelescopeBorder = { fg = husk, bg = BG_A },
  TelescopeSelection = { fg = cream, bg = bg_sel },
  TelescopeSelectionCaret = { fg = c_keyword, bg = bg_sel },
  TelescopeMatching = { fg = c_func, bold = true },
  TelescopePromptTitle = { fg = bg, bg = c_keyword, bold = true },
  TelescopeResultsTitle = { fg = bg, bg = c_func, bold = true },
  TelescopePreviewTitle = { fg = bg, bg = citron, bold = true },
  NeoTreeNormal = { fg = c_text, bg = BG },
  NeoTreeNormalNC = { fg = c_text, bg = BG },
  NeoTreeDirectoryName = { fg = c_type },
  NeoTreeDirectoryIcon = { fg = c_type },
  NeoTreeRootName = { fg = c_keyword, bold = true },
  NeoTreeIndentMarker = { fg = husk },
  NeoTreeGitModified = { fg = c_func },
  NeoTreeGitAdded = { fg = citron },
  NeoTreeGitDeleted = { fg = c_error },
  NeoTreeGitUntracked = { fg = c_import },
  NvimTreeNormal = { fg = c_text, bg = BG },
  NvimTreeFolderName = { fg = c_type },
  NvimTreeFolderIcon = { fg = c_type },
  NvimTreeRootFolder = { fg = c_keyword, bold = true },
  NvimTreeIndentMarker = { fg = husk },
  WhichKeyFloat = { bg = BG_A },
  WhichKeyNormal = { bg = BG_A },
  WhichKey = { fg = c_keyword },
  WhichKeyGroup = { fg = c_type },
  WhichKeyDesc = { fg = c_text },
  WhichKeySeparator = { fg = husk },
  GitSignsAdd = { fg = citron },
  GitSignsChange = { fg = c_func },
  GitSignsDelete = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = husk, italic = true },
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = husk, strikethrough = true },
  CmpItemAbbrMatch = { fg = c_func, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = c_func },
  CmpItemKind = { fg = c_type },
  CmpItemMenu = { fg = husk },
  BlinkCmpMenu = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder = { fg = husk, bg = BG_A },
  BlinkCmpMenuSelection = { fg = cream, bg = bg_sel, bold = true },
  BlinkCmpLabelMatch = { fg = c_func, bold = true },
  BlinkCmpKind = { fg = c_type },
  BlinkCmpDoc = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder = { fg = husk, bg = BG_A },
  SnacksNormal = { fg = c_text, bg = BG_A },
  SnacksWinBar = { fg = c_func, bg = BG_A, bold = true },
  SnacksBackdrop = { bg = bg },
  SnacksDashboardHeader = { fg = gold },
  SnacksDashboardIcon = { fg = c_keyword },
  SnacksDashboardDesc = { fg = c_text },
  SnacksDashboardKey = { fg = c_func },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch = { fg = c_func, bold = true },
  SnacksPickerDir = { fg = husk },
  SnacksIndent = { fg = husk_d },
  SnacksIndentScope = { fg = husk },
  IblIndent = { fg = husk_d },
  IblScope = { fg = husk },
  MiniIndentscopeSymbol = { fg = husk },
  FlashLabel = { fg = bg, bg = c_error, bold = true },
  FlashMatch = { fg = cream, bg = sel },
  TroubleNormal = { fg = c_text, bg = BG_A },
  TroubleText = { fg = c_text },
  TroubleCount = { fg = c_func, bold = true },
  LazyNormal = { fg = c_text, bg = BG_A },
  LazyH1 = { fg = bg, bg = gold, bold = true },
  LazyButtonActive = { fg = bg, bg = c_func, bold = true },
  LazyProgressDone = { fg = citron },
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
vim.g.terminal_color_2 = citron
vim.g.terminal_color_3 = gold
vim.g.terminal_color_4 = ochre
vim.g.terminal_color_5 = amber
vim.g.terminal_color_6 = lemon
vim.g.terminal_color_7 = flax
vim.g.terminal_color_8 = husk
vim.g.terminal_color_9 = "#ef7350"
vim.g.terminal_color_10 = "#c6d167"
vim.g.terminal_color_11 = honey
vim.g.terminal_color_12 = "#dfab54"
vim.g.terminal_color_13 = "#f7bd72"
vim.g.terminal_color_14 = "#f0eca6"
vim.g.terminal_color_15 = cream
