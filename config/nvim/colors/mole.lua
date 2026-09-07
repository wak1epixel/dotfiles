vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "mole"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- mole — amber phosphor on pure black
-- ALL code is one colour. Comments are grey. That's the whole
-- scheme. Errors are red only so a mistake can't hide — flip
-- `red = amber` below if you want it gone too.
-- ══════════════════════════════════════════════════════════════

local bg  = "#000000" -- pure black — editor background
local bg2 = "#0b0b0b" -- floats, pmenu, statusline
local bg3 = "#161009" -- cursorline / column — a warm ember-dark

-- ── THE ONE COLOUR ──────────────────────────────────────────
-- Swap this single line to retheme every character of code.
local amber = "#ffb000" -- P3 amber phosphor — the classic amber-terminal glow  ◀ default
-- local amber = "#ff7f00" -- pure orange (colour-wheel orange), no yellow in it
-- local amber = "#ffa500" -- web "orange" — a touch warmer / yellower
-- local amber = "#ff8c00" -- "dark orange" — deeper, more saturated
-- local amber = "#f0a000" -- muted gold-amber — the Soviet control panel (img 1)
-- local amber = "#e8601c" -- burnt orange — the dim MS-DOS CRT (img 4)
-- local amber = "#ffaa33" -- bright warm amber — lifts off black harder
-- local amber = "#ffc48a" -- pale / yellowish amber — softest on the eyes

-- ── grey — the only other hue ───────────────────────────────
local grey    = "#7d7d7d" -- comments
local grey_d  = "#4a4644" -- line numbers, inactive chrome, borders, folds
local grey_dd = "#211c17" -- whitespace, indent guides

local red = "#ff4d2e" -- errors / deletions only — set `red = amber` to remove

-- ── warm dark fills (backgrounds, never text) ───────────────
local sel    = "#3a2600" -- pmenu / picker selection, matched paren
local visual = "#2b1d00" -- visual selection
local ember  = "#241a0d" -- lsp reference / word-under-cursor highlight

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — every code token points at `amber`. Repoint any
-- line at a shade of your own if you ever want variation back.
-- ══════════════════════════════════════════════════════════════
local c_text    = amber -- variables, properties, plain code
local c_comment = grey  -- comments and doc-comments
local c_string  = amber -- strings, chars, raw text
local c_number  = amber -- numbers, booleans, constants
local c_keyword = amber -- if / for / return / const
local c_func    = amber -- function names and calls
local c_type    = amber -- types, classes, structs, enums
local c_import  = amber -- import / include / use, modules
local c_punct   = amber -- brackets, operators, delimiters
local c_special = amber -- escapes, macros, decorators, self / this
local c_error   = red
local c_warn    = amber
local c_hint    = amber
local c_info    = grey

local bg_alt    = bg2
local bg_visual = visual
local bg_sel    = sel

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.mole_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.mole_transparent == true
local BG   = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal        = { fg = c_text, bg = BG },
  NormalNC      = { fg = c_text, bg = BG },
  NormalFloat   = { fg = c_text, bg = BG_A },
  FloatBorder   = { fg = grey_d, bg = BG_A },
  FloatTitle    = { fg = c_text, bg = BG_A },
  LineNr        = { fg = grey_d },
  LineNrAbove   = { fg = grey_d },
  LineNrBelow   = { fg = grey_d },
  CursorLineNr  = { fg = c_text },
  CursorLine    = { bg = clear and "none" or bg3 },
  CursorColumn  = { bg = bg3 },
  ColorColumn   = { bg = bg3 },
  Visual        = { bg = bg_visual },
  VisualNOS     = { bg = bg_visual },
  Search        = { fg = bg, bg = amber },
  IncSearch     = { fg = bg, bg = amber },
  CurSearch     = { fg = bg, bg = amber },
  Substitute    = { fg = bg, bg = red },
  MatchParen    = { bg = sel, bold = true },
  StatusLine    = { fg = bg, bg = amber },
  StatusLineNC  = { fg = grey_d, bg = BG_A },
  WinBar        = { fg = c_text, bg = BG },
  WinBarNC      = { fg = grey_d, bg = BG },
  TabLine       = { fg = grey_d, bg = BG_A },
  TabLineFill   = { bg = BG },
  TabLineSel    = { fg = bg, bg = amber },
  WinSeparator  = { fg = grey_d, bg = BG },
  VertSplit     = { fg = grey_d, bg = BG },
  Pmenu         = { fg = c_text, bg = BG_A },
  PmenuSel      = { fg = bg, bg = amber },
  PmenuSbar     = { bg = bg2 },
  PmenuThumb    = { bg = grey_d },
  PmenuKind     = { fg = c_text, bg = BG_A },
  PmenuExtra    = { fg = grey_d, bg = BG_A },
  WildMenu      = { fg = bg, bg = amber },
  Folded        = { fg = c_comment, bg = BG_A },
  FoldColumn    = { fg = grey_dd, bg = "none" },
  SignColumn    = { bg = "none" },
  NonText       = { fg = grey_dd },
  Whitespace    = { fg = grey_dd },
  EndOfBuffer   = { fg = clear and grey_dd or bg },
  Directory     = { fg = c_text },
  Title         = { fg = c_text },
  Question      = { fg = c_text },
  ModeMsg       = { fg = c_text },
  MsgArea       = { fg = c_text },
  MoreMsg       = { fg = c_text },
  WarningMsg    = { fg = c_warn },
  ErrorMsg      = { fg = c_error },
  Conceal       = { fg = grey_d },
  SpecialKey    = { fg = grey_d },
  Cursor        = { fg = bg, bg = amber },
  lCursor       = { fg = bg, bg = amber },
  TermCursor    = { fg = bg, bg = amber },
  QuickFixLine  = { bg = sel },
  SpellBad      = { undercurl = true, sp = c_error },
  SpellCap      = { undercurl = true, sp = c_warn },
  SpellLocal    = { undercurl = true, sp = c_info },
  SpellRare     = { undercurl = true, sp = c_hint },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError            = { fg = c_error },
  DiagnosticWarn             = { fg = c_warn },
  DiagnosticInfo             = { fg = c_info },
  DiagnosticHint             = { fg = c_hint },
  DiagnosticOk               = { fg = c_text },
  DiagnosticUnderlineError   = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn    = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo    = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint    = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk      = { undercurl = true, sp = c_text },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn  = { fg = c_warn },
  DiagnosticVirtualTextInfo  = { fg = c_info },
  DiagnosticVirtualTextHint  = { fg = c_hint },
  DiagnosticUnnecessary      = { fg = grey_d, undercurl = true, sp = grey_d },
  DiagnosticDeprecated       = { fg = grey_d, strikethrough = true },

  DiffAdd    = { fg = c_text,  bg = "#141000" },
  DiffDelete = { fg = c_error, bg = "#1c0a06" },
  DiffChange = { fg = c_text,  bg = "#1a1200" },
  DiffText   = { fg = c_text,  bg = sel },
  Added      = { fg = c_text },
  Changed    = { fg = c_text },
  Removed    = { fg = c_error },

  -- ── legacy vim syntax groups — all one colour ────────────
  Comment        = { fg = c_comment, italic = true },
  Constant       = { fg = c_text },
  String         = { fg = c_text },
  Character      = { fg = c_text },
  Number         = { fg = c_text },
  Boolean        = { fg = c_text },
  Float          = { fg = c_text },
  Identifier     = { fg = c_text },
  Function       = { fg = c_text },
  Statement      = { fg = c_text },
  Conditional    = { fg = c_text },
  Repeat         = { fg = c_text },
  Label          = { fg = c_text },
  Operator       = { fg = c_text },
  Keyword        = { fg = c_text },
  Exception      = { fg = c_text },
  PreProc        = { fg = c_text },
  Include        = { fg = c_text },
  Define         = { fg = c_text },
  Macro          = { fg = c_text },
  PreCondit      = { fg = c_text },
  Type           = { fg = c_text },
  StorageClass   = { fg = c_text },
  Structure      = { fg = c_text },
  Typedef        = { fg = c_text },
  Special        = { fg = c_text },
  SpecialChar    = { fg = c_text },
  SpecialComment = { fg = c_comment, italic = true },
  Tag            = { fg = c_text },
  Delimiter      = { fg = c_text },
  Debug          = { fg = c_text },
  Underlined     = { fg = c_text, underline = true },
  Ignore         = { fg = grey_d },
  Error          = { fg = c_error },
  Todo           = { fg = bg, bg = amber },

  -- ── treesitter — all one colour ─────────────────────────
  ["@variable"]                   = { fg = c_text },
  ["@variable.member"]            = { fg = c_text },
  ["@variable.parameter"]         = { fg = c_text },
  ["@variable.parameter.builtin"] = { fg = c_text },
  ["@variable.builtin"]           = { fg = c_text }, -- self, this
  ["@property"]                   = { fg = c_text },
  ["@field"]                      = { fg = c_text },

  ["@function"]             = { fg = c_text },
  ["@function.call"]        = { fg = c_text },
  ["@function.method"]      = { fg = c_text },
  ["@function.method.call"] = { fg = c_text },
  ["@function.builtin"]     = { fg = c_text },
  ["@function.macro"]       = { fg = c_text },
  ["@constructor"]          = { fg = c_text },

  ["@type"]            = { fg = c_text },
  ["@type.builtin"]    = { fg = c_text },
  ["@type.definition"] = { fg = c_text },
  ["@type.qualifier"]  = { fg = c_text },
  ["@module"]          = { fg = c_text },
  ["@module.builtin"]  = { fg = c_text },
  ["@namespace"]       = { fg = c_text },

  ["@keyword"]                     = { fg = c_text },
  ["@keyword.function"]            = { fg = c_text },
  ["@keyword.return"]              = { fg = c_text },
  ["@keyword.conditional"]         = { fg = c_text },
  ["@keyword.conditional.ternary"] = { fg = c_text },
  ["@keyword.repeat"]              = { fg = c_text },
  ["@keyword.operator"]            = { fg = c_text },
  ["@keyword.exception"]           = { fg = c_text },
  ["@keyword.modifier"]            = { fg = c_text },
  ["@keyword.coroutine"]           = { fg = c_text },
  ["@keyword.type"]                = { fg = c_text },
  ["@keyword.debug"]               = { fg = c_text },

  ["@string"]            = { fg = c_text },
  ["@string.escape"]     = { fg = c_text },
  ["@string.special"]    = { fg = c_text },
  ["@string.regexp"]     = { fg = c_text },
  ["@character"]         = { fg = c_text },
  ["@character.special"] = { fg = c_text },
  ["@number"]            = { fg = c_text },
  ["@number.float"]      = { fg = c_text },
  ["@boolean"]           = { fg = c_text },
  ["@constant"]          = { fg = c_text },
  ["@constant.builtin"]  = { fg = c_text },
  ["@constant.macro"]    = { fg = c_text },

  ["@operator"]              = { fg = c_text },
  ["@punctuation"]           = { fg = c_text },
  ["@punctuation.bracket"]   = { fg = c_text },
  ["@punctuation.delimiter"] = { fg = c_text },
  ["@punctuation.special"]   = { fg = c_text },
  ["@label"]                 = { fg = c_text },
  ["@attribute"]             = { fg = c_text },
  ["@attribute.builtin"]     = { fg = c_text },

  ["@comment"]               = { fg = c_comment, italic = true },
  ["@comment.documentation"] = { fg = c_comment, italic = true },
  ["@comment.error"]         = { fg = c_error },
  ["@comment.warning"]       = { fg = c_warn },
  ["@comment.todo"]          = { fg = bg, bg = amber },
  ["@comment.note"]          = { fg = bg, bg = amber },

  -- ── C / C++ ──────────────────────────────────────────────
  ["@keyword.import"]           = { fg = c_text },
  ["@keyword.directive"]        = { fg = c_text },
  ["@keyword.directive.define"] = { fg = c_text },
  ["@preproc"]                  = { fg = c_text },
  ["@string.special.path"]      = { fg = c_text },
  ["@variable.member.cpp"]      = { fg = c_text },
  ["@lsp.type.class.cpp"]       = { fg = c_text },
  ["@lsp.typemod.variable.fileScope.cpp"]   = { fg = c_text },
  ["@lsp.typemod.variable.globalScope.cpp"] = { fg = c_text },

  -- ── Python ───────────────────────────────────────────────
  ["@function.decorator"]                   = { fg = c_text },
  ["@function.decorator.python"]            = { fg = c_text },
  ["@string.documentation"]                 = { fg = c_text },
  ["@type.builtin.python"]                  = { fg = c_text },
  ["@lsp.type.selfKeyword.python"]          = { fg = c_text },
  ["@lsp.typemod.variable.readonly.python"] = { fg = c_text },

  -- ── markup ───────────────────────────────────────────────
  ["@markup.heading"]        = { fg = c_text, bold = true },
  ["@markup.heading.1"]      = { fg = c_text, bold = true },
  ["@markup.heading.2"]      = { fg = c_text, bold = true },
  ["@markup.heading.3"]      = { fg = c_text, bold = true },
  ["@markup.strong"]         = { fg = c_text, bold = true },
  ["@markup.italic"]         = { fg = c_text, italic = true },
  ["@markup.strikethrough"]  = { fg = grey_d, strikethrough = true },
  ["@markup.link"]           = { fg = c_text, underline = true },
  ["@markup.link.url"]       = { fg = c_text, underline = true },
  ["@markup.link.label"]     = { fg = c_text },
  ["@markup.raw"]            = { fg = c_text },
  ["@markup.raw.block"]      = { fg = c_text },
  ["@markup.list"]           = { fg = c_text },
  ["@markup.list.checked"]   = { fg = c_text },
  ["@markup.list.unchecked"] = { fg = grey_d },
  ["@markup.quote"]          = { fg = c_comment, italic = true },
  ["@diff.plus"]             = { fg = c_text },
  ["@diff.minus"]            = { fg = c_error },
  ["@diff.delta"]            = { fg = c_text },
  ["@tag"]                   = { fg = c_text },
  ["@tag.attribute"]         = { fg = c_text },
  ["@tag.delimiter"]         = { fg = c_text },

  -- ── LSP semantic tokens ─────────────────────────────────
  ["@lsp.type.class"]         = { fg = c_text },
  ["@lsp.type.struct"]        = { fg = c_text },
  ["@lsp.type.enum"]          = { fg = c_text },
  ["@lsp.type.interface"]     = { fg = c_text },
  ["@lsp.type.type"]          = { fg = c_text },
  ["@lsp.type.typeParameter"] = { fg = c_text },
  ["@lsp.type.namespace"]     = { fg = c_text },
  ["@lsp.type.function"]      = { fg = c_text },
  ["@lsp.type.method"]        = { fg = c_text },
  ["@lsp.type.macro"]         = { fg = c_text },
  ["@lsp.type.variable"]      = { fg = c_text },
  ["@lsp.type.property"]      = { fg = c_text },
  ["@lsp.type.parameter"]     = { fg = c_text },
  ["@lsp.type.enumMember"]    = { fg = c_text },
  ["@lsp.type.keyword"]       = { fg = c_text },
  ["@lsp.type.operator"]      = { fg = c_text },
  ["@lsp.type.string"]        = { fg = c_text },
  ["@lsp.type.number"]        = { fg = c_text },
  ["@lsp.type.comment"]       = { fg = c_comment, italic = true },
  ["@lsp.type.decorator"]     = { fg = c_text },
  ["@lsp.mod.readonly"]       = { fg = c_text },
  ["@lsp.typemod.variable.readonly"]        = { fg = c_text },
  ["@lsp.typemod.function.defaultLibrary"]  = { fg = c_text },
  ["@lsp.typemod.variable.defaultLibrary"]  = { fg = c_text },
  ["@lsp.typemod.class.defaultLibrary"]     = { fg = c_text },
  ["@lsp.typemod.type.defaultLibrary"]      = { fg = c_text },

  LspReferenceText            = { bg = ember },
  LspReferenceRead            = { bg = ember },
  LspReferenceWrite           = { bg = ember, underline = true },
  LspSignatureActiveParameter = { fg = c_text, bold = true },
  LspInlayHint                = { fg = grey_d, bg = BG_A, italic = true },
  LspCodeLens                 = { fg = grey_d, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal         = { fg = c_text, bg = BG_A },
  TelescopeBorder         = { fg = grey_d, bg = BG_A },
  TelescopeSelection      = { fg = bg, bg = amber },
  TelescopeSelectionCaret = { fg = bg, bg = amber },
  TelescopeMatching       = { fg = c_text, bold = true },
  TelescopePromptTitle    = { fg = bg, bg = amber },
  TelescopeResultsTitle   = { fg = bg, bg = amber },
  TelescopePreviewTitle   = { fg = bg, bg = amber },
  NeoTreeNormal           = { fg = c_text, bg = BG },
  NeoTreeNormalNC         = { fg = c_text, bg = BG },
  NeoTreeDirectoryName    = { fg = c_text },
  NeoTreeDirectoryIcon    = { fg = c_text },
  NeoTreeRootName         = { fg = c_text, bold = true },
  NeoTreeIndentMarker     = { fg = grey_d },
  NeoTreeGitModified      = { fg = c_text },
  NeoTreeGitAdded         = { fg = c_text },
  NeoTreeGitDeleted       = { fg = c_error },
  NeoTreeGitUntracked     = { fg = grey },
  NvimTreeNormal          = { fg = c_text, bg = BG },
  NvimTreeFolderName      = { fg = c_text },
  NvimTreeFolderIcon      = { fg = c_text },
  NvimTreeRootFolder      = { fg = c_text, bold = true },
  NvimTreeIndentMarker    = { fg = grey_d },
  WhichKeyFloat           = { bg = BG_A },
  WhichKeyNormal          = { bg = BG_A },
  WhichKey                = { fg = c_text },
  WhichKeyGroup           = { fg = grey },
  WhichKeyDesc            = { fg = c_text },
  WhichKeySeparator       = { fg = grey_d },
  GitSignsAdd              = { fg = c_text },
  GitSignsChange           = { fg = c_text },
  GitSignsDelete           = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = grey_d, italic = true },
  CmpItemAbbr           = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = grey_d, strikethrough = true },
  CmpItemAbbrMatch      = { fg = c_text, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = c_text, bold = true },
  CmpItemKind           = { fg = grey },
  CmpItemMenu           = { fg = grey_d },
  BlinkCmpMenu          = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder    = { fg = grey_d, bg = BG_A },
  BlinkCmpMenuSelection = { fg = bg, bg = amber },
  BlinkCmpLabelMatch    = { fg = c_text, bold = true },
  BlinkCmpKind          = { fg = grey },
  BlinkCmpDoc           = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder     = { fg = grey_d, bg = BG_A },
  SnacksNormal          = { fg = c_text, bg = BG_A },
  SnacksWinBar          = { fg = c_text, bg = BG_A },
  SnacksBackdrop        = { bg = bg },
  SnacksDashboardHeader = { fg = c_text },
  SnacksDashboardIcon   = { fg = c_text },
  SnacksDashboardDesc   = { fg = c_text },
  SnacksDashboardKey    = { fg = c_text },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch     = { fg = c_text, bold = true },
  SnacksPickerDir       = { fg = grey_d },
  SnacksIndent          = { fg = grey_dd },
  SnacksIndentScope     = { fg = grey_d },
  IblIndent             = { fg = grey_dd },
  IblScope              = { fg = grey_d },
  MiniIndentscopeSymbol = { fg = grey_d },
  FlashLabel            = { fg = bg, bg = c_error, bold = true },
  FlashMatch            = { fg = bg, bg = amber },
  TroubleNormal         = { fg = c_text, bg = BG_A },
  TroubleText           = { fg = c_text },
  TroubleCount          = { fg = c_text, bold = true },
  LazyNormal            = { fg = c_text, bg = BG_A },
  LazyH1                = { fg = bg, bg = amber },
  LazyButtonActive      = { fg = bg, bg = amber },
  LazyProgressDone      = { fg = c_text },
  MasonNormal           = { fg = c_text, bg = BG_A },
  MasonHeader           = { fg = bg, bg = amber },
  MasonHighlight        = { fg = c_text },
  MasonMutedBlock       = { fg = c_text, bg = bg_sel },
  NotifyINFOBorder      = { fg = c_info },
  NotifyINFOIcon        = { fg = c_info },
  NotifyINFOTitle       = { fg = c_info },
  NotifyWARNBorder      = { fg = c_warn },
  NotifyWARNIcon        = { fg = c_warn },
  NotifyWARNTitle       = { fg = c_warn },
  NotifyERRORBorder     = { fg = c_error },
  NotifyERRORIcon       = { fg = c_error },
  NotifyERRORTitle      = { fg = c_error },
  IlluminatedWordText   = { bg = ember },
  IlluminatedWordRead   = { bg = ember },
  IlluminatedWordWrite  = { bg = ember },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── terminal palette — monochrome amber ─────────────────────
vim.g.terminal_color_0  = bg
vim.g.terminal_color_1  = red
vim.g.terminal_color_2  = amber
vim.g.terminal_color_3  = amber
vim.g.terminal_color_4  = amber
vim.g.terminal_color_5  = amber
vim.g.terminal_color_6  = amber
vim.g.terminal_color_7  = amber
vim.g.terminal_color_8  = grey_d
vim.g.terminal_color_9  = red
vim.g.terminal_color_10 = amber
vim.g.terminal_color_11 = amber
vim.g.terminal_color_12 = amber
vim.g.terminal_color_13 = amber
vim.g.terminal_color_14 = amber
vim.g.terminal_color_15 = amber
