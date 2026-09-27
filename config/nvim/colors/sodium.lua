vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "sodium"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- sodium — streetlights on a blue night.
-- Blue is the night: plain code, names, calls, punctuation,
-- everything that is simply there. It comes in three steps, from
-- pale mist (text) to clear sky (functions) to deep harbour
-- (modules, imports).
-- Orange is the lamps: keywords, types, strings, the things that
-- give the code its shape and its words. It comes in three steps
-- too, from hot sodium (keywords) to amber (types) to apricot
-- (strings).
-- Roughly 60 blue / 40 orange by token. The only colours outside
-- the two families are grey for comments and red for errors.
-- ══════════════════════════════════════════════════════════════
local bg = "#0b111b" -- editor background — near-black navy
local bg2 = "#101926" -- floats, pmenu, statusline
local bg3 = "#152031" -- cursorline / cursorcolumn

-- ── the night (blue) ─────────────────────────────────────────
local mist = "#c6d4e9" -- plain code — the workhorse
local sky = "#7fb0f5" -- function names and calls
local harbour = "#5a88cc" -- modules, imports, namespaces
local frost = "#a9c8f0" -- numbers and constants
local slate = "#8a9dba" -- punctuation and operators

-- ── the lamps (orange) ───────────────────────────────────────
local sodium = "#f28b3a" -- keywords, control flow — THE orange
local amber = "#f5b066" -- types, classes, structs
local apricot = "#f2c79c" -- strings, chars
local flare = "#ff9f5a" -- booleans, nil, self, escapes, macros

-- ── the rare ones ────────────────────────────────────────────
local grey = "#5d6b82" -- comments only
local ember = "#e5534b" -- errors / deletions

-- ── chrome (UI, not code) ────────────────────────────────────
local dim = "#3f5274" -- line numbers, borders, folds
local dim_d = "#1d2940" -- whitespace, indent guides

-- ── dark blue fills (backgrounds, never text) ────────────────
local sel = "#1f3a60" -- pmenu / picker selection, matched paren
local visual = "#1a2e4c" -- visual selection
local glow = "#162439" -- lsp reference / word-under-cursor

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — this is the part to edit.
-- Blue roles on the left of the balance, orange on the right.
-- Swapping one across shifts the 60/40 split.
-- ══════════════════════════════════════════════════════════════
local c_text = mist -- variables, properties, plain code
local c_comment = grey -- comments and doc-comments
local c_string = apricot -- strings, chars, raw text
local c_number = frost -- numbers and named constants
local c_bool = flare -- booleans, None / NULL / nil
local c_keyword = sodium -- if / for / return / const, control flow
local c_func = sky -- function names and calls
local c_type = amber -- types, classes, structs, enums
local c_import = harbour -- import / include / use, modules, namespaces
local c_punct = slate -- brackets, operators, delimiters
local c_special = flare -- escapes, macros, decorators, self / this
local c_error = ember
local c_warn = amber
local c_hint = harbour
local c_info = sky

local bg_alt = bg2 -- floats, pmenu
local bg_visual = visual -- visual selection
local bg_sel = sel -- pmenu / picker selection

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.sodium_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.sodium_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = dim, bg = BG_A },
  FloatTitle = { fg = sodium, bg = BG_A, bold = true },
  LineNr = { fg = dim },
  LineNrAbove = { fg = dim },
  LineNrBelow = { fg = dim },
  CursorLineNr = { fg = sodium, bold = true },
  CursorLine = { bg = clear and "none" or bg3 },
  CursorColumn = { bg = bg3 },
  ColorColumn = { bg = bg3 },
  Visual = { bg = bg_visual },
  VisualNOS = { bg = bg_visual },
  Search = { fg = bg, bg = sky },
  IncSearch = { fg = bg, bg = sodium },
  CurSearch = { fg = bg, bg = sodium },
  Substitute = { fg = bg, bg = ember },
  MatchParen = { fg = sodium, bg = sel, bold = true },
  StatusLine = { fg = mist, bg = BG_A },
  StatusLineNC = { fg = dim, bg = BG_A },
  WinBar = { fg = c_text, bg = BG },
  WinBarNC = { fg = dim, bg = BG },
  TabLine = { fg = dim, bg = BG_A },
  TabLineFill = { bg = BG },
  TabLineSel = { fg = bg, bg = sodium, bold = true },
  WinSeparator = { fg = dim, bg = BG },
  VertSplit = { fg = dim, bg = BG },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = sodium, bg = bg_sel, bold = true },
  PmenuSbar = { bg = bg2 },
  PmenuThumb = { bg = dim },
  PmenuKind = { fg = c_type, bg = BG_A },
  PmenuExtra = { fg = dim, bg = BG_A },
  WildMenu = { fg = bg, bg = sodium },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = dim, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = dim },
  Whitespace = { fg = dim_d },
  EndOfBuffer = { fg = clear and dim_d or bg },
  Directory = { fg = c_func },
  Title = { fg = sodium, bold = true },
  Question = { fg = c_info },
  ModeMsg = { fg = c_keyword, bold = true },
  MsgArea = { fg = c_text },
  MoreMsg = { fg = c_info },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = dim },
  SpecialKey = { fg = dim },
  Cursor = { fg = bg, bg = sodium },
  lCursor = { fg = bg, bg = sodium },
  TermCursor = { fg = bg, bg = sodium },
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
  DiagnosticOk = { fg = sky },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk = { undercurl = true, sp = sky },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn = { fg = c_warn },
  DiagnosticVirtualTextInfo = { fg = c_info },
  DiagnosticVirtualTextHint = { fg = c_hint },
  DiagnosticUnnecessary = { fg = dim, undercurl = true, sp = dim },
  DiagnosticDeprecated = { fg = dim, strikethrough = true },

  -- blue for added, orange for changed, red for removed
  DiffAdd = { fg = sky, bg = "#122640" },
  DiffDelete = { fg = c_error, bg = "#2a1418" },
  DiffChange = { fg = amber, bg = "#241e1c" },
  DiffText = { fg = sodium, bg = "#3a2616" },
  Added = { fg = sky },
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
  Underlined = { fg = c_func, underline = true },
  Ignore = { fg = dim },
  Error = { fg = c_error, bold = true },
  Todo = { fg = bg, bg = sodium, bold = true },

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
  ["@type.builtin"] = { fg = c_type, italic = true },
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
  ["@comment.todo"] = { fg = bg, bg = sodium, bold = true },
  ["@comment.note"] = { fg = bg, bg = sky, bold = true },

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
  ["@markup.heading"] = { fg = sodium, bold = true },
  ["@markup.heading.1"] = { fg = sodium, bold = true },
  ["@markup.heading.2"] = { fg = sky, bold = true },
  ["@markup.heading.3"] = { fg = amber },
  ["@markup.heading.4"] = { fg = frost },
  ["@markup.strong"] = { fg = mist, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.strikethrough"] = { fg = dim, strikethrough = true },
  ["@markup.link"] = { fg = c_func, underline = true },
  ["@markup.link.url"] = { fg = c_import, underline = true },
  ["@markup.link.label"] = { fg = c_func },
  ["@markup.raw"] = { fg = c_string },
  ["@markup.raw.block"] = { fg = c_string },
  ["@markup.list"] = { fg = c_keyword },
  ["@markup.list.checked"] = { fg = sky },
  ["@markup.list.unchecked"] = { fg = dim },
  ["@markup.quote"] = { fg = c_comment, italic = true },
  ["@diff.plus"] = { fg = sky },
  ["@diff.minus"] = { fg = c_error },
  ["@diff.delta"] = { fg = amber },
  ["@tag"] = { fg = c_keyword },
  ["@tag.attribute"] = { fg = c_func },
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
  LspSignatureActiveParameter = { fg = sodium, bold = true },
  LspInlayHint = { fg = dim, bg = BG_A, italic = true },
  LspCodeLens = { fg = dim, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = c_text, bg = BG_A },
  TelescopeBorder = { fg = dim, bg = BG_A },
  TelescopeSelection = { fg = mist, bg = bg_sel },
  TelescopeSelectionCaret = { fg = sodium, bg = bg_sel },
  TelescopeMatching = { fg = sodium, bold = true },
  TelescopePromptTitle = { fg = bg, bg = sodium, bold = true },
  TelescopeResultsTitle = { fg = bg, bg = sky, bold = true },
  TelescopePreviewTitle = { fg = bg, bg = amber, bold = true },
  NeoTreeNormal = { fg = c_text, bg = BG },
  NeoTreeNormalNC = { fg = c_text, bg = BG },
  NeoTreeDirectoryName = { fg = c_func },
  NeoTreeDirectoryIcon = { fg = c_func },
  NeoTreeRootName = { fg = sodium, bold = true },
  NeoTreeIndentMarker = { fg = dim },
  NeoTreeGitModified = { fg = amber },
  NeoTreeGitAdded = { fg = sky },
  NeoTreeGitDeleted = { fg = c_error },
  NeoTreeGitUntracked = { fg = flare },
  NvimTreeNormal = { fg = c_text, bg = BG },
  NvimTreeFolderName = { fg = c_func },
  NvimTreeFolderIcon = { fg = c_func },
  NvimTreeRootFolder = { fg = sodium, bold = true },
  NvimTreeIndentMarker = { fg = dim },
  WhichKeyFloat = { bg = BG_A },
  WhichKeyNormal = { bg = BG_A },
  WhichKey = { fg = sodium },
  WhichKeyGroup = { fg = sky },
  WhichKeyDesc = { fg = c_text },
  WhichKeySeparator = { fg = dim },
  GitSignsAdd = { fg = sky },
  GitSignsChange = { fg = amber },
  GitSignsDelete = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = grey, italic = true },
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = dim, strikethrough = true },
  CmpItemAbbrMatch = { fg = sodium, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = sodium },
  CmpItemKind = { fg = c_func },
  CmpItemMenu = { fg = dim },
  BlinkCmpMenu = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder = { fg = dim, bg = BG_A },
  BlinkCmpMenuSelection = { fg = mist, bg = bg_sel, bold = true },
  BlinkCmpLabelMatch = { fg = sodium, bold = true },
  BlinkCmpKind = { fg = c_func },
  BlinkCmpDoc = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder = { fg = dim, bg = BG_A },
  SnacksNormal = { fg = c_text, bg = BG_A },
  SnacksWinBar = { fg = sodium, bg = BG_A, bold = true },
  SnacksBackdrop = { bg = bg },
  SnacksDashboardHeader = { fg = sodium },
  SnacksDashboardIcon = { fg = sky },
  SnacksDashboardDesc = { fg = c_text },
  SnacksDashboardKey = { fg = amber },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch = { fg = sodium, bold = true },
  SnacksPickerDir = { fg = dim },
  SnacksIndent = { fg = dim_d },
  SnacksIndentScope = { fg = dim },
  IblIndent = { fg = dim_d },
  IblScope = { fg = dim },
  MiniIndentscopeSymbol = { fg = dim },
  FlashLabel = { fg = bg, bg = sodium, bold = true },
  FlashMatch = { fg = mist, bg = sel },
  TroubleNormal = { fg = c_text, bg = BG_A },
  TroubleText = { fg = c_text },
  TroubleCount = { fg = sodium, bold = true },
  LazyNormal = { fg = c_text, bg = BG_A },
  LazyH1 = { fg = bg, bg = sodium, bold = true },
  LazyButtonActive = { fg = bg, bg = sky, bold = true },
  LazyProgressDone = { fg = sodium },
  MasonNormal = { fg = c_text, bg = BG_A },
  MasonHeader = { fg = bg, bg = sodium, bold = true },
  MasonHighlight = { fg = sky },
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
vim.g.terminal_color_2 = "#6fb3a8"
vim.g.terminal_color_3 = amber
vim.g.terminal_color_4 = harbour
vim.g.terminal_color_5 = sodium
vim.g.terminal_color_6 = sky
vim.g.terminal_color_7 = mist
vim.g.terminal_color_8 = grey
vim.g.terminal_color_9 = "#f06b5f"
vim.g.terminal_color_10 = "#8cc9bd"
vim.g.terminal_color_11 = apricot
vim.g.terminal_color_12 = sky
vim.g.terminal_color_13 = flare
vim.g.terminal_color_14 = frost
vim.g.terminal_color_15 = "#e6eef9"
