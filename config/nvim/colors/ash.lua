vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "ash"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- PALETTE — monochrome: white → gray ramp, one accent hue.
-- Everything below is neutral (r == g == b) except `accent`.
-- Hierarchy comes from brightness / bold / italic, not from hue.
-- ══════════════════════════════════════════════════════════════
local bg = "#121212" -- editor background
local bg2 = "#181818" -- floats, pmenu, statusline
local bg3 = "#1f1f1f" -- cursorline / cursorcolumn
local bg4 = "#282828" -- visual selection, indent guides

local gray_d = "#343434" -- whitespace dots, scope lines
local gray = "#565656" -- line numbers, borders, punctuation
local gray_m = "#6e6e6e" -- comments
local gray_l = "#909090" -- strings
local silver = "#bdbdbd" -- types, imports
local white = "#d8d8d8" -- plain text — the workhorse
local white_b = "#f2f2f2" -- brightest — functions, numbers, emphasis

-- ══════════════════════════════════════════════════════════════
-- MOOD SWAP — the only hue in the scheme.
-- Comment out the active line, uncomment another. Every accented
-- highlight follows, including the tints derived just below.
-- ══════════════════════════════════════════════════════════════
local accent = "#986161" -- dusty brick rose (default)

-- yellows
-- local accent = "#b8912f" -- ochre
-- local accent = "#c9a94f" -- muted gold
-- local accent = "#ddc471" -- pale butter

-- blues
-- local accent = "#4f708f" -- dusty steel
-- local accent = "#6c8fb8" -- muted cornflower
-- local accent = "#93b3d6" -- pale ice

-- accent tints: same hue, blended toward white / background, so a
-- swap above carries through without editing anything else.
local function blend(a, b, t)
  local function ch(c, i)
    return tonumber(c:sub(i, i + 1), 16)
  end
  return string.format(
    "#%02x%02x%02x",
    math.floor(ch(a, 2) + (ch(b, 2) - ch(a, 2)) * t + 0.5),
    math.floor(ch(a, 4) + (ch(b, 4) - ch(a, 4)) * t + 0.5),
    math.floor(ch(a, 6) + (ch(b, 6) - ch(a, 6)) * t + 0.5)
  )
end

local accent_l = blend(accent, white_b, 0.35) -- escapes, macros, self
local accent_d = blend(accent, bg, 0.62) -- pmenu / picker selection
local accent_dd = blend(accent, bg, 0.80) -- diff + reference backgrounds

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — this is the part to edit.
-- Every highlight below points at one of these.
-- ══════════════════════════════════════════════════════════════
local c_text = white -- variables, properties, plain code
local c_comment = gray_m -- comments and doc-comments
local c_string = gray_l -- strings, chars, raw text — recedes
local c_number = white_b -- numbers, booleans, constants — pops out
local c_keyword = accent -- if / for / return / const — the accent lives here
local c_func = white_b -- function names and calls (bold at call sites)
local c_type = silver -- types, classes, structs, enums
local c_import = silver -- import / include / use, modules, namespaces
local c_punct = gray -- brackets, operators, delimiters — recedes
local c_special = accent_l -- escapes, macros, decorators — kept sparse
local c_ident_b = silver -- self / this and builtin vars — italic, but neutral
local c_error = accent
local c_warn = accent_l
local c_hint = silver
local c_info = gray_l

local bg_alt = bg2 -- floats, pmenu
local bg_visual = bg4 -- visual selection — stays neutral
local bg_sel = accent_d -- pmenu / picker selection — accented

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.ash_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.ash_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = gray, bg = BG_A },
  FloatTitle = { fg = c_keyword, bg = BG_A, bold = true },
  LineNr = { fg = gray },
  LineNrAbove = { fg = gray },
  LineNrBelow = { fg = gray },
  CursorLineNr = { fg = accent, bold = true },
  CursorLine = { bg = clear and "none" or bg3 },
  CursorColumn = { bg = bg3 },
  ColorColumn = { bg = bg3 },
  Visual = { bg = bg_visual },
  VisualNOS = { bg = bg_visual },
  Search = { fg = bg, bg = silver },
  IncSearch = { fg = bg, bg = accent },
  CurSearch = { fg = bg, bg = accent },
  Substitute = { fg = bg, bg = accent },
  MatchParen = { fg = white_b, bg = accent_d, bold = true },
  StatusLine = { fg = white_b, bg = bg4, bold = true },
  StatusLineNC = { fg = gray, bg = BG_A },
  WinBar = { fg = c_text, bg = BG },
  WinBarNC = { fg = gray, bg = BG },
  TabLine = { fg = gray, bg = BG_A },
  TabLineFill = { bg = BG },
  TabLineSel = { fg = bg, bg = silver, bold = true },
  WinSeparator = { fg = gray_d, bg = BG },
  VertSplit = { fg = gray_d, bg = BG },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = white_b, bg = bg_sel, bold = true },
  PmenuSbar = { bg = bg2 },
  PmenuThumb = { bg = gray },
  PmenuKind = { fg = c_type, bg = BG_A },
  PmenuExtra = { fg = gray, bg = BG_A },
  WildMenu = { fg = bg, bg = silver },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = gray, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = gray_d },
  Whitespace = { fg = gray_d },
  EndOfBuffer = { fg = clear and gray_d or bg },
  Directory = { fg = c_type },
  Title = { fg = accent, bold = true },
  Question = { fg = c_hint },
  ModeMsg = { fg = accent, bold = true },
  MsgArea = { fg = c_text },
  MoreMsg = { fg = c_hint },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = gray },
  SpecialKey = { fg = gray },
  Cursor = { fg = bg, bg = white_b },
  lCursor = { fg = bg, bg = white_b },
  TermCursor = { fg = bg, bg = accent },
  QuickFixLine = { bg = accent_dd, bold = true },
  SpellBad = { undercurl = true, sp = c_error },
  SpellCap = { undercurl = true, sp = c_warn },
  SpellLocal = { undercurl = true, sp = c_info },
  SpellRare = { undercurl = true, sp = c_hint },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError = { fg = c_error },
  DiagnosticWarn = { fg = c_warn },
  DiagnosticInfo = { fg = c_info },
  DiagnosticHint = { fg = c_hint },
  DiagnosticOk = { fg = silver },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk = { undercurl = true, sp = silver },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn = { fg = c_warn },
  DiagnosticVirtualTextInfo = { fg = c_info },
  DiagnosticVirtualTextHint = { fg = c_hint },
  DiagnosticUnnecessary = { fg = gray, undercurl = true, sp = gray },
  DiagnosticDeprecated = { fg = gray, strikethrough = true },

  DiffAdd = { fg = white_b, bg = bg4 },
  DiffDelete = { fg = c_error, bg = accent_dd },
  DiffChange = { fg = silver, bg = bg3 },
  DiffText = { fg = white_b, bg = accent_d },
  Added = { fg = white_b },
  Changed = { fg = silver },
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
  Ignore = { fg = gray },
  Error = { fg = c_error, bold = true },
  Todo = { fg = bg, bg = accent, bold = true },

  -- ── treesitter: text and identifiers ─────────────────────
  ["@variable"] = { fg = c_text },
  ["@variable.member"] = { fg = c_text },
  ["@variable.parameter"] = { fg = c_text, italic = true },
  ["@variable.parameter.builtin"] = { fg = c_ident_b, italic = true },
  ["@variable.builtin"] = { fg = c_ident_b, italic = true }, -- self, this
  ["@property"] = { fg = c_text },
  ["@field"] = { fg = c_text },

  -- ── treesitter: functions ────────────────────────────────
  ["@function"] = { fg = c_func, bold = true },
  ["@function.call"] = { fg = c_func },
  ["@function.method"] = { fg = c_func, bold = true },
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
  ["@comment.todo"] = { fg = bg, bg = accent, bold = true },
  ["@comment.note"] = { fg = bg, bg = silver, bold = true },

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
  ["@lsp.type.selfKeyword.python"] = { fg = c_ident_b, italic = true },
  ["@lsp.typemod.variable.readonly.python"] = { fg = c_number },

  -- ── markup ───────────────────────────────────────────────
  ["@markup.heading"] = { fg = accent, bold = true },
  ["@markup.heading.1"] = { fg = accent, bold = true },
  ["@markup.heading.2"] = { fg = white_b, bold = true },
  ["@markup.heading.3"] = { fg = silver, bold = true },
  ["@markup.strong"] = { fg = white_b, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.strikethrough"] = { fg = gray, strikethrough = true },
  ["@markup.link"] = { fg = c_import, underline = true },
  ["@markup.link.url"] = { fg = gray_l, underline = true },
  ["@markup.link.label"] = { fg = c_import },
  ["@markup.raw"] = { fg = c_string },
  ["@markup.raw.block"] = { fg = c_string },
  ["@markup.list"] = { fg = c_keyword },
  ["@markup.list.checked"] = { fg = silver },
  ["@markup.list.unchecked"] = { fg = gray },
  ["@markup.quote"] = { fg = c_comment, italic = true },
  ["@diff.plus"] = { fg = white_b },
  ["@diff.minus"] = { fg = c_error },
  ["@diff.delta"] = { fg = silver },
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
  ["@lsp.typemod.variable.defaultLibrary"] = { fg = c_ident_b, italic = true },
  ["@lsp.typemod.class.defaultLibrary"] = { fg = c_type, italic = true },
  ["@lsp.typemod.type.defaultLibrary"] = { fg = c_type, italic = true },

  LspReferenceText = { bg = accent_dd },
  LspReferenceRead = { bg = accent_dd },
  LspReferenceWrite = { bg = accent_dd, underline = true },
  LspSignatureActiveParameter = { fg = accent, bold = true },
  LspInlayHint = { fg = gray, bg = BG_A, italic = true },
  LspCodeLens = { fg = gray, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = c_text, bg = BG_A },
  TelescopeBorder = { fg = gray, bg = BG_A },
  TelescopeSelection = { fg = white_b, bg = bg_sel },
  TelescopeSelectionCaret = { fg = accent_l, bg = bg_sel },
  TelescopeMatching = { fg = accent, bold = true },
  TelescopePromptTitle = { fg = bg, bg = accent, bold = true },
  TelescopeResultsTitle = { fg = bg, bg = silver, bold = true },
  TelescopePreviewTitle = { fg = bg, bg = gray_l, bold = true },
  NeoTreeNormal = { fg = c_text, bg = BG },
  NeoTreeNormalNC = { fg = c_text, bg = BG },
  NeoTreeDirectoryName = { fg = c_type },
  NeoTreeDirectoryIcon = { fg = c_type },
  NeoTreeRootName = { fg = accent, bold = true },
  NeoTreeIndentMarker = { fg = gray_d },
  NeoTreeGitModified = { fg = silver },
  NeoTreeGitAdded = { fg = white_b },
  NeoTreeGitDeleted = { fg = c_error },
  NeoTreeGitUntracked = { fg = gray_l, italic = true },
  NvimTreeNormal = { fg = c_text, bg = BG },
  NvimTreeFolderName = { fg = c_type },
  NvimTreeFolderIcon = { fg = c_type },
  NvimTreeRootFolder = { fg = accent, bold = true },
  NvimTreeIndentMarker = { fg = gray_d },
  WhichKeyFloat = { bg = BG_A },
  WhichKeyNormal = { bg = BG_A },
  WhichKey = { fg = accent },
  WhichKeyGroup = { fg = c_type },
  WhichKeyDesc = { fg = c_text },
  WhichKeySeparator = { fg = gray },
  GitSignsAdd = { fg = silver },
  GitSignsChange = { fg = gray_l },
  GitSignsDelete = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = gray, italic = true },
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = gray, strikethrough = true },
  CmpItemAbbrMatch = { fg = accent, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = accent },
  CmpItemKind = { fg = c_type },
  CmpItemMenu = { fg = gray },
  BlinkCmpMenu = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder = { fg = gray, bg = BG_A },
  BlinkCmpMenuSelection = { fg = white_b, bg = bg_sel, bold = true },
  BlinkCmpLabelMatch = { fg = accent, bold = true },
  BlinkCmpKind = { fg = c_type },
  BlinkCmpDoc = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder = { fg = gray, bg = BG_A },
  SnacksNormal = { fg = c_text, bg = BG_A },
  SnacksWinBar = { fg = accent, bg = BG_A, bold = true },
  SnacksBackdrop = { bg = bg },
  SnacksDashboardHeader = { fg = accent },
  SnacksDashboardIcon = { fg = silver },
  SnacksDashboardDesc = { fg = c_text },
  SnacksDashboardKey = { fg = white_b },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch = { fg = accent, bold = true },
  SnacksPickerDir = { fg = gray },
  SnacksIndent = { fg = bg4 },
  SnacksIndentScope = { fg = gray },
  IblIndent = { fg = bg4 },
  IblScope = { fg = gray },
  MiniIndentscopeSymbol = { fg = gray },
  FlashLabel = { fg = bg, bg = accent, bold = true },
  FlashMatch = { fg = white_b, bg = accent_d },
  TroubleNormal = { fg = c_text, bg = BG_A },
  TroubleText = { fg = c_text },
  TroubleCount = { fg = accent, bold = true },
  LazyNormal = { fg = c_text, bg = BG_A },
  LazyH1 = { fg = bg, bg = silver, bold = true },
  LazyButtonActive = { fg = bg, bg = accent, bold = true },
  LazyProgressDone = { fg = white_b },
  MasonNormal = { fg = c_text, bg = BG_A },
  MasonHeader = { fg = bg, bg = silver, bold = true },
  MasonHighlight = { fg = c_type },
  MasonMutedBlock = { fg = white_b, bg = bg_sel },
  NotifyINFOBorder = { fg = c_info },
  NotifyINFOIcon = { fg = c_info },
  NotifyINFOTitle = { fg = c_info },
  NotifyWARNBorder = { fg = c_warn },
  NotifyWARNIcon = { fg = c_warn },
  NotifyWARNTitle = { fg = c_warn },
  NotifyERRORBorder = { fg = c_error },
  NotifyERRORIcon = { fg = c_error },
  NotifyERRORTitle = { fg = c_error },
  IlluminatedWordText = { bg = accent_dd },
  IlluminatedWordRead = { bg = accent_dd },
  IlluminatedWordWrite = { bg = accent_dd },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── terminal palette ────────────────────────────────────────
-- ANSI slots that normally carry hue all map onto the gray ramp;
-- only the red/magenta slots get the accent.
vim.g.terminal_color_0 = bg2
vim.g.terminal_color_1 = accent
vim.g.terminal_color_2 = gray_m
vim.g.terminal_color_3 = gray_l
vim.g.terminal_color_4 = gray
vim.g.terminal_color_5 = accent_l
vim.g.terminal_color_6 = silver
vim.g.terminal_color_7 = white
vim.g.terminal_color_8 = gray_d
vim.g.terminal_color_9 = accent_l
vim.g.terminal_color_10 = gray_l
vim.g.terminal_color_11 = silver
vim.g.terminal_color_12 = gray_m
vim.g.terminal_color_13 = accent_l
vim.g.terminal_color_14 = white
vim.g.terminal_color_15 = white_b
