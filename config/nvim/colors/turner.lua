vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "turner"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- TURNER — a warm, near-monochrome scheme: gold, burnt orange, olive.
--
-- Three colors carry the whole thing, in order of prominence:
--   #F1D67A  primary text      — variables, params, properties, plain code
--   #FF9565  the leading token — types, namespaces, includes, functions
--   #626138  bracket groups    — brackets, delimiters, punctuation
--   #C26E27  used sparingly    — self / this, escapes, macros, warnings
--
-- Everything else is a tint or shade of one of those three, plus brown
-- used sparingly for chrome (line numbers, borders, selection). No hue
-- outside the warm range appears anywhere except error red.
-- ══════════════════════════════════════════════════════════════

local bg = "#110B0D"

-- gold ladder — the text family
local gold = "#F1D67A" -- primary text
local gold_hi = "#F6D75C" -- emphasis (search, matches)
local gold_max = "#FFE597" -- peak emphasis (selection, strong markup)

-- orange ladder — the "first thing on the line" family
local orange_hi = "#FF9565" -- types, functions, namespaces, keywords
local orange = "#C26E27" -- sparing accent only: self / this, escapes, warnings

-- olive ladder — punctuation and the quiet layer
local olive_dim = "#464628" -- comments        (darkest step)
local olive = "#626138" -- brackets        (the specified bracket color)
local olive_mid = "#898850" -- operators       (a tint of the bracket olive)
local olive_hi = "#B3B163" -- strings/literals (brightest step)

-- brown — structural chrome only, used sparingly
local brown = "#874227"
local brown_mid = "#5C2E1B"
local brown_dark = "#341A0D"

-- red — errors and deletions only, nothing else
local red = "#9B281B"
local red_hi = "#FF4230"
local magenta = "#9B1D29"
local magenta_hi = "#FF5B6A"

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — edit here, not below. Every highlight points at one
-- of these, so one line re-themes everything that uses it.
-- ══════════════════════════════════════════════════════════════
local c_text = gold -- priority 1: the workhorse
local c_lead = orange_hi -- priority 2: whatever opens a line
local c_lead_hi = orange_hi -- return / throw / decorators open lines too
local c_bracket = olive -- priority 3: bracket groups
local c_comment = olive_dim -- a darker step of the bracket olive
local c_operator = olive_mid -- a lighter step, so `+ - == ->` stay visible
local c_literal = olive_hi -- strings, numbers, booleans, constants
local c_special = orange -- sparingly: self / this, escapes, f-string braces
local c_chrome = brown -- line numbers, borders, separators
local c_chrome_dim = brown_mid -- fold column, whitespace, inactive text

local c_error = red_hi
local c_warn = orange
local c_info = olive_hi
local c_hint = brown

-- ══════════════════════════════════════════════════════════════
-- SURFACES
-- ══════════════════════════════════════════════════════════════
local bg_alt = "#1A1214" -- floats, popup menu
local bg_line = "#191012" -- cursorline
local bg_sel = "#241619" -- popup selection
local bg_visual = brown_dark -- visual mode — the dark brown

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY — on by default; the terminal supplies the background.
--   vim.g.turner_transparent = false        -- paint #110B0D instead
--   vim.g.turner_transparent_floats = true  -- floats see through too
-- Set either before the scheme loads.
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.turner_transparent ~= false
local clear_floats = clear and vim.g.turner_transparent_floats == true

local BG = clear and "none" or bg
local BG_A = clear_floats and "none" or bg_alt
local BG_L = clear and "none" or bg_line

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalSB = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = c_chrome, bg = BG_A },
  FloatTitle = { fg = c_lead, bg = BG_A, bold = true },
  FloatFooter = { fg = c_comment, bg = BG_A },
  LineNr = { fg = c_chrome },
  LineNrAbove = { fg = c_chrome_dim },
  LineNrBelow = { fg = c_chrome_dim },
  CursorLineNr = { fg = c_lead, bold = true },
  CursorLine = { bg = BG_L },
  CursorColumn = { bg = BG_L },
  ColorColumn = { bg = bg_line },
  Visual = { bg = bg_visual },
  VisualNOS = { bg = bg_visual },
  Search = { fg = bg, bg = c_lead },
  IncSearch = { fg = bg, bg = gold_max },
  CurSearch = { fg = bg, bg = gold_max },
  Substitute = { fg = bg, bg = c_special },
  MatchParen = { fg = c_special, bold = true, underline = true },
  StatusLine = { fg = c_text, bg = BG_A },
  StatusLineNC = { fg = c_chrome, bg = BG_A },
  WinBar = { fg = c_lead, bg = BG, bold = true },
  WinBarNC = { fg = c_chrome, bg = BG },
  WinSeparator = { fg = c_chrome },
  VertSplit = { fg = c_chrome },
  TabLine = { fg = c_chrome, bg = BG_A },
  TabLineSel = { fg = c_lead, bg = BG, bold = true },
  TabLineFill = { bg = BG },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = gold_max, bg = bg_sel, bold = true },
  PmenuKind = { fg = c_lead, bg = BG_A },
  PmenuKindSel = { fg = c_lead, bg = bg_sel },
  PmenuExtra = { fg = c_comment, bg = BG_A },
  PmenuExtraSel = { fg = c_operator, bg = bg_sel },
  PmenuSbar = { bg = bg_alt },
  PmenuThumb = { bg = c_chrome },
  WildMenu = { fg = bg, bg = c_lead },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = c_chrome_dim, bg = "none" },
  SignColumn = { bg = "none" },
  SignColumnSB = { bg = "none" },
  NonText = { fg = c_chrome_dim },
  EndOfBuffer = { fg = clear and c_chrome_dim or bg },
  Directory = { fg = c_lead },
  Title = { fg = c_lead, bold = true },
  Question = { fg = c_literal },
  ModeMsg = { fg = c_lead, bold = true },
  MsgArea = { fg = c_text },
  MsgSeparator = { fg = c_chrome },
  MoreMsg = { fg = c_literal },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = c_chrome_dim },
  SpecialKey = { fg = c_chrome_dim },
  Whitespace = { fg = "#2A1810" },
  Cursor = { fg = bg, bg = c_text },
  lCursor = { fg = bg, bg = c_text },
  CursorIM = { fg = bg, bg = c_text },
  TermCursor = { fg = bg, bg = c_lead },
  TermCursorNC = { fg = bg, bg = c_chrome },
  QuickFixLine = { bg = bg_sel, bold = true },
  ComplMatchIns = { fg = c_chrome, italic = true },
  SnippetTabstop = { bg = bg_visual },
  FloatShadow = { bg = brown_dark },
  FloatShadowThrough = { bg = brown_dark },
  PmenuMatch = { fg = gold_hi, bold = true },
  PmenuMatchSel = { fg = gold_hi, bg = bg_sel, bold = true },
  PmenuShadow = { bg = brown_dark },
  PmenuShadowThrough = { bg = brown_dark },
  OkMsg = { fg = c_bracket },

  -- ── spelling (nvim's defaults are off-palette pinks/cyans) ─
  SpellBad = { undercurl = true, sp = c_error },
  SpellCap = { undercurl = true, sp = c_warn },
  SpellRare = { undercurl = true, sp = c_chrome },
  SpellLocal = { undercurl = true, sp = c_bracket },
  debugPC = { bg = bg_visual },
  debugBreakpoint = { fg = c_error },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError = { fg = c_error },
  DiagnosticWarn = { fg = c_warn },
  DiagnosticInfo = { fg = c_info },
  DiagnosticHint = { fg = c_hint },
  DiagnosticOk = { fg = c_bracket },
  DiagnosticVirtualTextOk = { fg = c_bracket, bg = "none" },
  DiagnosticUnderlineOk = { undercurl = true, sp = c_bracket },
  DiagnosticSignError = { fg = c_error },
  DiagnosticSignWarn = { fg = c_warn },
  DiagnosticSignInfo = { fg = c_info },
  DiagnosticSignHint = { fg = c_hint },
  DiagnosticFloatingError = { fg = c_error },
  DiagnosticFloatingWarn = { fg = c_warn },
  DiagnosticFloatingInfo = { fg = c_info },
  DiagnosticFloatingHint = { fg = c_hint },
  DiagnosticVirtualTextError = { fg = c_error, bg = "none" },
  DiagnosticVirtualTextWarn = { fg = c_warn, bg = "none" },
  DiagnosticVirtualTextInfo = { fg = c_info, bg = "none" },
  DiagnosticVirtualTextHint = { fg = c_hint, bg = "none" },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_hint },
  DiagnosticUnnecessary = { fg = c_comment, italic = true },
  DiagnosticDeprecated = { fg = c_comment, strikethrough = true },

  -- ── diff / git ───────────────────────────────────────────
  DiffAdd = { fg = c_literal, bg = "#1C2012" },
  DiffDelete = { fg = c_error, bg = "#2A0F0C" },
  DiffChange = { fg = c_lead, bg = "#2A1A0C" },
  DiffText = { fg = c_special, bg = "#3A2410" },
  Added = { fg = c_literal },
  Removed = { fg = c_error },
  Changed = { fg = c_lead },

  -- ── legacy vim groups (buffers without treesitter) ───────
  Comment = { fg = c_comment, italic = true },
  Constant = { fg = c_literal },
  String = { fg = c_literal },
  Character = { fg = c_literal },
  Number = { fg = c_literal },
  Boolean = { fg = c_literal, bold = true },
  Float = { fg = c_literal },
  Identifier = { fg = c_text },
  Function = { fg = c_lead },
  Statement = { fg = c_lead },
  Conditional = { fg = c_lead },
  Repeat = { fg = c_lead },
  Label = { fg = c_lead },
  Operator = { fg = c_operator },
  Keyword = { fg = c_lead },
  Exception = { fg = c_lead_hi, bold = true },
  PreProc = { fg = c_lead },
  Include = { fg = c_lead },
  Define = { fg = c_lead },
  Macro = { fg = c_special },
  PreCondit = { fg = c_lead },
  Type = { fg = c_lead },
  StorageClass = { fg = c_lead, italic = true },
  Structure = { fg = c_lead },
  Typedef = { fg = c_lead },
  Special = { fg = c_special },
  SpecialChar = { fg = c_special },
  Tag = { fg = c_lead },
  Delimiter = { fg = c_bracket },
  SpecialComment = { fg = c_operator, italic = true },
  Debug = { fg = c_special },
  Underlined = { fg = c_lead, underline = true },
  Bold = { bold = true },
  Italic = { italic = true },
  Ignore = { fg = c_chrome_dim },
  Error = { fg = c_error, bold = true },
  Todo = { fg = bg, bg = c_lead, bold = true },

  -- ══════════════════════════════════════════════════════════
  -- TREESITTER
  -- ══════════════════════════════════════════════════════════

  -- ── identifiers: the gold layer ──────────────────────────
  ["@variable"] = { fg = c_text },
  ["@variable.member"] = { fg = c_text },
  ["@variable.parameter"] = { fg = c_text, italic = true },
  ["@variable.parameter.builtin"] = { fg = c_special, italic = true },
  ["@variable.builtin"] = { fg = c_special, italic = true }, -- self, this, cls
  ["@property"] = { fg = c_text },
  ["@field"] = { fg = c_text },

  -- ── the lead layer: whatever opens the line ─────────────
  ["@function"] = { fg = c_lead },
  ["@function.call"] = { fg = c_lead },
  ["@function.method"] = { fg = c_lead },
  ["@function.method.call"] = { fg = c_lead },
  ["@function.builtin"] = { fg = c_lead, italic = true },
  ["@function.macro"] = { fg = c_special },
  ["@constructor"] = { fg = c_lead },

  ["@type"] = { fg = c_lead },
  ["@type.builtin"] = { fg = c_lead },
  ["@type.definition"] = { fg = c_lead, bold = true },
  ["@type.qualifier"] = { fg = c_lead, italic = true }, -- const, constexpr
  ["@module"] = { fg = c_lead },
  ["@module.builtin"] = { fg = c_lead, italic = true },
  ["@namespace"] = { fg = c_lead },

  ["@keyword"] = { fg = c_lead },
  ["@keyword.function"] = { fg = c_lead }, -- def, fn, function
  ["@keyword.type"] = { fg = c_lead }, -- class, struct, enum
  ["@keyword.modifier"] = { fg = c_lead, italic = true }, -- static, public, async
  ["@keyword.conditional"] = { fg = c_lead },
  ["@keyword.conditional.ternary"] = { fg = c_operator },
  ["@keyword.repeat"] = { fg = c_lead },
  ["@keyword.operator"] = { fg = c_lead }, -- and, or, not, sizeof
  ["@keyword.import"] = { fg = c_lead }, -- import, #include, use
  ["@keyword.directive"] = { fg = c_lead },
  ["@keyword.directive.define"] = { fg = c_lead },
  ["@keyword.coroutine"] = { fg = c_lead, italic = true }, -- async, await
  ["@keyword.debug"] = { fg = c_lead_hi },
  ["@keyword.return"] = { fg = c_lead_hi, bold = true }, -- rare, worth spotting
  ["@keyword.exception"] = { fg = c_lead_hi, bold = true }, -- throw, raise, try
  ["@preproc"] = { fg = c_lead },
  ["@define"] = { fg = c_lead },
  ["@include"] = { fg = c_lead },
  ["@label"] = { fg = c_lead },
  ["@attribute"] = { fg = c_lead_hi, italic = true }, -- decorators, [[attrs]]
  ["@attribute.builtin"] = { fg = c_lead_hi, italic = true },

  -- ── literals: the olive layer ────────────────────────────
  ["@string"] = { fg = c_literal },
  ["@string.documentation"] = { fg = c_operator, italic = true },
  ["@string.escape"] = { fg = c_special, bold = true },
  ["@string.special"] = { fg = c_special },
  ["@string.special.symbol"] = { fg = c_special },
  ["@string.special.url"] = { fg = c_lead, underline = true },
  ["@string.special.path"] = { fg = c_lead, italic = true }, -- <iostream>
  ["@string.regexp"] = { fg = c_special },
  ["@character"] = { fg = c_literal },
  ["@character.special"] = { fg = c_special },
  ["@number"] = { fg = c_literal },
  ["@number.float"] = { fg = c_literal },
  ["@boolean"] = { fg = c_literal, bold = true },
  ["@constant"] = { fg = c_literal, bold = true }, -- STDOUT_FILENO, DEFAULT
  ["@constant.builtin"] = { fg = c_literal, bold = true }, -- None, nullptr, NULL
  ["@constant.macro"] = { fg = c_literal, bold = true },

  -- ── bracket groups: the specified olive ──────────────────
  ["@punctuation"] = { fg = c_bracket },
  ["@punctuation.bracket"] = { fg = c_bracket },
  ["@punctuation.delimiter"] = { fg = c_bracket },
  ["@punctuation.special"] = { fg = c_special }, -- ${} and f-string braces
  ["@operator"] = { fg = c_operator },
  ["@tag"] = { fg = c_lead },
  ["@tag.builtin"] = { fg = c_lead },
  ["@tag.attribute"] = { fg = c_text, italic = true },
  ["@tag.delimiter"] = { fg = c_bracket },

  -- ── comments ─────────────────────────────────────────────
  ["@comment"] = { fg = c_comment, italic = true },
  ["@comment.documentation"] = { fg = c_comment, italic = true },
  ["@comment.error"] = { fg = bg, bg = c_error, bold = true },
  ["@comment.warning"] = { fg = bg, bg = c_warn, bold = true },
  ["@comment.todo"] = { fg = bg, bg = c_lead, bold = true },
  ["@comment.note"] = { fg = bg, bg = c_literal, bold = true },

  -- ── markup (markdown, docs, help) ────────────────────────
  ["@markup.heading"] = { fg = c_lead, bold = true },
  ["@markup.heading.1"] = { fg = c_lead, bold = true },
  ["@markup.heading.2"] = { fg = gold_max, bold = true },
  ["@markup.heading.3"] = { fg = c_text, bold = true },
  ["@markup.heading.4"] = { fg = c_literal },
  ["@markup.heading.5"] = { fg = c_operator },
  ["@markup.heading.6"] = { fg = c_comment },
  ["@markup.strong"] = { fg = gold_max, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.strikethrough"] = { fg = c_comment, strikethrough = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.link"] = { fg = c_lead },
  ["@markup.link.label"] = { fg = c_lead },
  ["@markup.link.url"] = { fg = c_operator, underline = true },
  ["@markup.raw"] = { fg = c_literal },
  ["@markup.raw.block"] = { fg = c_literal },
  ["@markup.list"] = { fg = c_lead },
  ["@markup.list.checked"] = { fg = c_literal },
  ["@markup.list.unchecked"] = { fg = c_comment },
  ["@markup.quote"] = { fg = c_comment, italic = true },
  ["@markup.math"] = { fg = c_special },
  ["@diff.plus"] = { fg = c_literal },
  ["@diff.minus"] = { fg = c_error },
  ["@diff.delta"] = { fg = c_lead },

  -- ══════════════════════════════════════════════════════════
  -- C / C++  (clangd + treesitter)
  -- `#include <vector>` / `using namespace std;` / `constexpr int`
  -- all open in the lead color; the body settles into gold.
  -- ══════════════════════════════════════════════════════════
  ["@keyword.import.cpp"] = { fg = c_lead },
  ["@type.builtin.cpp"] = { fg = c_lead }, -- int, char, bool, size_t
  ["@type.builtin.c"] = { fg = c_lead },
  ["@constant.builtin.cpp"] = { fg = c_literal, bold = true }, -- nullptr
  ["@variable.builtin.cpp"] = { fg = c_special, italic = true }, -- this
  ["@function.builtin.c"] = { fg = c_lead, italic = true },
  ["@lsp.type.class.cpp"] = { fg = c_lead },
  ["@lsp.type.concept"] = { fg = c_lead, italic = true },
  ["@lsp.type.namespace.cpp"] = { fg = c_lead },
  ["@lsp.type.operator"] = { fg = c_operator },
  ["@lsp.type.bracket"] = { fg = c_bracket },
  ["@lsp.type.modifier"] = { fg = c_lead, italic = true },
  ["@lsp.typemod.function.defaultLibrary"] = { fg = c_lead, italic = true }, -- std::
  ["@lsp.typemod.class.defaultLibrary"] = { fg = c_lead, italic = true },
  ["@lsp.typemod.namespace.defaultLibrary"] = { fg = c_lead, italic = true },
  ["@lsp.typemod.variable.readonly"] = { fg = c_literal },
  ["@lsp.typemod.variable.constant"] = { fg = c_literal, bold = true },
  ["@lsp.typemod.variable.static"] = { fg = c_text, bold = true },
  ["@lsp.typemod.method.static"] = { fg = c_lead, bold = true },
  ["@lsp.typemod.macro.globalScope"] = { fg = c_literal, bold = true },
  -- clangd_extensions.nvim inlay hints
  InlayHint = { fg = c_chrome, italic = true },
  LspInlayHint = { fg = c_chrome, italic = true },

  -- ══════════════════════════════════════════════════════════
  -- PYTHON
  -- `import`, `from`, `def`, `class`, decorators lead the line.
  -- `self` gets the bright accent so it never reads as a param.
  -- ══════════════════════════════════════════════════════════
  ["@keyword.import.python"] = { fg = c_lead },
  ["@keyword.type.python"] = { fg = c_lead }, -- class
  ["@keyword.function.python"] = { fg = c_lead }, -- def, lambda
  ["@keyword.operator.python"] = { fg = c_lead }, -- and, or, not, in, is
  ["@variable.builtin.python"] = { fg = c_special, italic = true }, -- self, cls
  ["@function.builtin.python"] = { fg = c_lead, italic = true }, -- print, len
  ["@type.builtin.python"] = { fg = c_lead }, -- int, str, list
  ["@constant.builtin.python"] = { fg = c_literal, bold = true }, -- True/False/None
  ["@attribute.python"] = { fg = c_lead_hi, italic = true }, -- @decorator
  ["@string.documentation.python"] = { fg = c_operator, italic = true }, -- docstrings
  ["@punctuation.special.python"] = { fg = c_special }, -- f-string { }
  ["@lsp.type.selfParameter"] = { fg = c_special, italic = true },
  ["@lsp.type.decorator"] = { fg = c_lead_hi, italic = true },
  ["@lsp.type.builtinConstant"] = { fg = c_literal, bold = true },
  ["@lsp.typemod.variable.definition.python"] = { fg = c_text },

  -- ══════════════════════════════════════════════════════════
  -- OTHER LANGUAGES
  -- ══════════════════════════════════════════════════════════
  -- lua
  ["@constructor.lua"] = { fg = c_bracket }, -- table { } reads as brackets
  ["@variable.builtin.lua"] = { fg = c_special, italic = true },
  -- rust
  ["@type.builtin.rust"] = { fg = c_lead },
  ["@attribute.rust"] = { fg = c_lead_hi, italic = true },
  ["@keyword.import.rust"] = { fg = c_lead },
  ["@lsp.type.derive"] = { fg = c_lead_hi, italic = true },
  ["@lsp.type.lifetime"] = { fg = c_operator, italic = true },
  ["@lsp.type.selfKeyword"] = { fg = c_special, italic = true },
  -- go
  ["@keyword.import.go"] = { fg = c_lead },
  ["@type.builtin.go"] = { fg = c_lead },
  -- javascript / typescript
  ["@constructor.javascript"] = { fg = c_lead },
  ["@constructor.typescript"] = { fg = c_lead },
  ["@variable.builtin.javascript"] = { fg = c_special, italic = true },
  ["@lsp.type.interface"] = { fg = c_lead },
  ["@lsp.type.typeParameter"] = { fg = c_lead, italic = true },
  ["@lsp.type.enumMember"] = { fg = c_literal, bold = true },
  -- html / css
  ["@tag.html"] = { fg = c_lead },
  ["@tag.attribute.html"] = { fg = c_text, italic = true },
  ["@property.css"] = { fg = c_text },
  ["@type.css"] = { fg = c_lead },
  ["@string.plain.css"] = { fg = c_literal },
  ["@number.css"] = { fg = c_literal },
  -- json / yaml / toml
  ["@property.json"] = { fg = c_lead },
  ["@property.yaml"] = { fg = c_lead },
  ["@property.toml"] = { fg = c_lead },
  ["@label.json"] = { fg = c_lead },
  -- bash
  ["@function.builtin.bash"] = { fg = c_lead, italic = true },
  ["@variable.parameter.bash"] = { fg = c_text },
  ["@punctuation.special.bash"] = { fg = c_special }, -- $ and ${}
  -- sql / make / vim
  ["@keyword.sql"] = { fg = c_lead },
  ["@function.builtin.vim"] = { fg = c_lead, italic = true },

  -- ══════════════════════════════════════════════════════════
  -- LSP SEMANTIC TOKENS (win over treesitter when a server attaches)
  -- ══════════════════════════════════════════════════════════
  ["@lsp.type.class"] = { fg = c_lead },
  ["@lsp.type.struct"] = { fg = c_lead },
  ["@lsp.type.enum"] = { fg = c_lead },
  ["@lsp.type.type"] = { fg = c_lead },
  ["@lsp.type.typeAlias"] = { fg = c_lead },
  ["@lsp.type.namespace"] = { fg = c_lead },
  ["@lsp.type.function"] = { fg = c_lead },
  ["@lsp.type.method"] = { fg = c_lead },
  ["@lsp.type.macro"] = { fg = c_literal, bold = true },
  ["@lsp.type.variable"] = { fg = c_text },
  ["@lsp.type.property"] = { fg = c_text },
  ["@lsp.type.parameter"] = { fg = c_text, italic = true },
  ["@lsp.type.field"] = { fg = c_text },
  ["@lsp.type.keyword"] = { fg = c_lead },
  ["@lsp.type.string"] = { fg = c_literal },
  ["@lsp.type.number"] = { fg = c_literal },
  ["@lsp.type.comment"] = { fg = c_comment, italic = true },
  ["@lsp.type.punctuation"] = { fg = c_bracket },
  ["@lsp.mod.readonly"] = { fg = c_literal },
  ["@lsp.mod.deprecated"] = { strikethrough = true },
  ["@lsp.mod.documentation"] = { fg = c_comment, italic = true },
  LspReferenceText = { bg = bg_sel },
  LspReferenceRead = { bg = bg_sel },
  LspReferenceWrite = { bg = bg_sel, underline = true },
  LspSignatureActiveParameter = { fg = c_special, bold = true },
  LspCodeLens = { fg = c_comment, italic = true },
  LspInfoBorder = { fg = c_chrome, bg = BG_A },

  -- ══════════════════════════════════════════════════════════
  -- BRACKET PAIRS — if rainbow-delimiters is ever enabled, keep it
  -- inside the palette: olive steps, then gold, then orange.
  -- ══════════════════════════════════════════════════════════
  RainbowDelimiterBlue = { fg = c_bracket },
  RainbowDelimiterGreen = { fg = c_operator },
  RainbowDelimiterCyan = { fg = olive_hi },
  RainbowDelimiterYellow = { fg = c_text },
  RainbowDelimiterOrange = { fg = c_lead },
  RainbowDelimiterRed = { fg = c_special },
  RainbowDelimiterViolet = { fg = c_chrome },
  MiniIndentscopeSymbol = { fg = c_bracket },
  IblIndent = { fg = "#2A1810" },
  IblScope = { fg = c_bracket },

  -- ══════════════════════════════════════════════════════════
  -- PLUGIN SURFACES (LazyVim stack)
  -- ══════════════════════════════════════════════════════════
  -- snacks.nvim: picker, explorer, dashboard, notifier
  SnacksNormal = { fg = c_text, bg = BG_A },
  SnacksNormalNC = { fg = c_text, bg = BG_A },
  SnacksWinBar = { fg = c_lead, bg = BG_A, bold = true },
  SnacksBackdrop = { bg = clear and "none" or bg },
  SnacksPicker = { fg = c_text, bg = BG_A },
  SnacksPickerBorder = { fg = c_chrome, bg = BG_A },
  SnacksPickerTitle = { fg = bg, bg = c_lead, bold = true },
  SnacksPickerMatch = { fg = gold_hi, bold = true },
  SnacksPickerSelected = { fg = gold_max, bold = true },
  SnacksPickerCursorLine = { bg = bg_sel },
  SnacksPickerDir = { fg = c_comment },
  SnacksPickerFile = { fg = c_text },
  SnacksPickerPathHidden = { fg = c_comment },
  SnacksPickerPrompt = { fg = c_lead, bold = true },
  SnacksPickerInputBorder = { fg = c_lead, bg = BG_A },
  SnacksPickerListCursorLine = { bg = bg_sel },
  SnacksPickerGitStatusModified = { fg = c_lead },
  SnacksPickerGitStatusAdded = { fg = c_literal },
  SnacksPickerGitStatusDeleted = { fg = c_error },
  SnacksDashboardHeader = { fg = c_lead, bold = true },
  SnacksDashboardTitle = { fg = c_lead },
  SnacksDashboardIcon = { fg = c_special },
  SnacksDashboardDesc = { fg = c_text },
  SnacksDashboardKey = { fg = c_literal },
  SnacksDashboardFooter = { fg = c_comment, italic = true },
  SnacksDashboardDir = { fg = c_comment },
  SnacksIndent = { fg = "#2A1810" },
  SnacksIndentScope = { fg = c_bracket },
  SnacksNotifierInfo = { fg = c_info, bg = BG_A },
  SnacksNotifierWarn = { fg = c_warn, bg = BG_A },
  SnacksNotifierError = { fg = c_error, bg = BG_A },
  SnacksNotifierDebug = { fg = c_comment, bg = BG_A },
  SnacksNotifierBorderInfo = { fg = c_info, bg = BG_A },
  SnacksNotifierBorderWarn = { fg = c_warn, bg = BG_A },
  SnacksNotifierBorderError = { fg = c_error, bg = BG_A },

  -- blink.cmp
  BlinkCmpMenu = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder = { fg = c_chrome, bg = BG_A },
  BlinkCmpMenuSelection = { fg = gold_max, bg = bg_sel, bold = true },
  BlinkCmpLabel = { fg = c_text },
  BlinkCmpLabelMatch = { fg = gold_hi, bold = true },
  BlinkCmpLabelDeprecated = { fg = c_comment, strikethrough = true },
  BlinkCmpLabelDetail = { fg = c_comment },
  BlinkCmpLabelDescription = { fg = c_comment },
  BlinkCmpKind = { fg = c_lead },
  BlinkCmpKindClass = { fg = c_lead },
  BlinkCmpKindStruct = { fg = c_lead },
  BlinkCmpKindInterface = { fg = c_lead },
  BlinkCmpKindFunction = { fg = c_lead },
  BlinkCmpKindMethod = { fg = c_lead },
  BlinkCmpKindConstructor = { fg = c_lead },
  BlinkCmpKindModule = { fg = c_lead },
  BlinkCmpKindVariable = { fg = c_text },
  BlinkCmpKindField = { fg = c_text },
  BlinkCmpKindProperty = { fg = c_text },
  BlinkCmpKindKeyword = { fg = c_lead },
  BlinkCmpKindSnippet = { fg = c_special },
  BlinkCmpKindText = { fg = c_literal },
  BlinkCmpKindConstant = { fg = c_literal },
  BlinkCmpKindEnum = { fg = c_lead },
  BlinkCmpKindEnumMember = { fg = c_literal },
  BlinkCmpSource = { fg = c_comment },
  BlinkCmpDoc = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder = { fg = c_chrome, bg = BG_A },
  BlinkCmpDocSeparator = { fg = c_chrome },
  BlinkCmpSignatureHelp = { fg = c_text, bg = BG_A },
  BlinkCmpSignatureHelpBorder = { fg = c_chrome, bg = BG_A },
  BlinkCmpSignatureHelpActiveParameter = { fg = c_special, bold = true },
  BlinkCmpGhostText = { fg = c_chrome, italic = true },

  -- nvim-cmp (in case it is ever swapped back in)
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = c_comment, strikethrough = true },
  CmpItemAbbrMatch = { fg = gold_hi, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = gold_hi, bold = true },
  CmpItemKind = { fg = c_lead },
  CmpItemMenu = { fg = c_comment },
  CmpGhostText = { fg = c_chrome, italic = true },

  -- gitsigns
  GitSignsAdd = { fg = c_literal },
  GitSignsChange = { fg = c_lead },
  GitSignsDelete = { fg = c_error },
  GitSignsAddNr = { fg = c_literal },
  GitSignsChangeNr = { fg = c_lead },
  GitSignsDeleteNr = { fg = c_error },
  GitSignsAddInline = { bg = "#2A3018" },
  GitSignsDeleteInline = { bg = "#3A1512" },
  GitSignsChangeInline = { bg = "#3A2410" },
  GitSignsCurrentLineBlame = { fg = c_comment, italic = true },

  -- which-key
  WhichKey = { fg = c_lead, bold = true },
  WhichKeyGroup = { fg = c_special },
  WhichKeyDesc = { fg = c_text },
  WhichKeySeparator = { fg = c_bracket },
  WhichKeyFloat = { bg = BG_A },
  WhichKeyBorder = { fg = c_chrome, bg = BG_A },
  WhichKeyTitle = { fg = bg, bg = c_lead, bold = true },
  WhichKeyValue = { fg = c_comment },

  -- noice
  NoiceCmdline = { fg = c_text, bg = BG_A },
  NoiceCmdlineIcon = { fg = c_lead },
  NoiceCmdlineIconSearch = { fg = c_special },
  NoiceCmdlinePopup = { fg = c_text, bg = BG_A },
  NoiceCmdlinePopupBorder = { fg = c_lead, bg = BG_A },
  NoiceCmdlinePopupTitle = { fg = c_lead, bold = true },
  NoiceCmdlinePrompt = { fg = c_lead },
  NoiceConfirm = { fg = c_text, bg = BG_A },
  NoiceConfirmBorder = { fg = c_lead, bg = BG_A },
  NoiceMini = { fg = c_text, bg = BG_A },
  NoicePopup = { fg = c_text, bg = BG_A },
  NoicePopupBorder = { fg = c_chrome, bg = BG_A },
  NoiceLspProgressTitle = { fg = c_lead },
  NoiceLspProgressClient = { fg = c_special },
  NoiceLspProgressSpinner = { fg = c_literal },
  NoiceVirtualtext = { fg = c_comment, italic = true },

  -- trouble
  TroubleNormal = { fg = c_text, bg = BG },
  TroubleNormalNC = { fg = c_text, bg = BG },
  TroubleText = { fg = c_text },
  TroubleCount = { fg = c_special, bold = true },
  TroubleFilename = { fg = c_lead, bold = true },
  TroubleSource = { fg = c_comment },
  TroubleCode = { fg = c_comment },
  TroubleIndent = { fg = c_chrome_dim },
  TroubleFoldIcon = { fg = c_lead },
  TroublePos = { fg = c_bracket },

  -- flash
  FlashLabel = { fg = bg, bg = c_special, bold = true },
  FlashMatch = { fg = bg, bg = c_lead },
  FlashCurrent = { fg = bg, bg = gold_max, bold = true },
  FlashBackdrop = { fg = c_chrome_dim },

  -- bufferline
  BufferLineFill = { bg = BG },
  BufferLineBackground = { fg = c_chrome, bg = BG },
  BufferLineBufferVisible = { fg = c_comment, bg = BG },
  BufferLineBufferSelected = { fg = c_lead, bg = BG, bold = true, italic = false },
  BufferLineNumbersSelected = { fg = c_lead, bg = BG, bold = true },
  BufferLineModified = { fg = c_literal, bg = BG },
  BufferLineModifiedVisible = { fg = c_literal, bg = BG },
  BufferLineModifiedSelected = { fg = c_special, bg = BG },
  BufferLineSeparator = { fg = c_chrome, bg = BG },
  BufferLineSeparatorVisible = { fg = c_chrome, bg = BG },
  BufferLineSeparatorSelected = { fg = c_chrome, bg = BG },
  BufferLineIndicatorSelected = { fg = c_lead, bg = BG },
  BufferLineCloseButtonSelected = { fg = c_special, bg = BG },
  BufferLineDiagnosticSelected = { fg = c_warn, bg = BG },
  BufferLineErrorSelected = { fg = c_error, bg = BG },
  BufferLineWarningSelected = { fg = c_warn, bg = BG },

  -- lazy.nvim / mason
  LazyNormal = { fg = c_text, bg = BG_A },
  LazyH1 = { fg = bg, bg = c_lead, bold = true },
  LazyH2 = { fg = c_lead, bold = true },
  LazyButton = { fg = c_text, bg = bg_sel },
  LazyButtonActive = { fg = bg, bg = c_lead, bold = true },
  LazySpecial = { fg = c_special },
  LazyProgressDone = { fg = c_literal, bold = true },
  LazyProgressTodo = { fg = c_chrome },
  LazyCommit = { fg = c_comment },
  LazyReasonPlugin = { fg = c_lead },
  MasonNormal = { fg = c_text, bg = BG_A },
  MasonHeader = { fg = bg, bg = c_lead, bold = true },
  MasonHighlight = { fg = c_lead },
  MasonHighlightBlock = { fg = bg, bg = c_lead },
  MasonHighlightBlockBold = { fg = bg, bg = c_lead, bold = true },
  MasonMuted = { fg = c_comment },
  MasonMutedBlock = { fg = c_text, bg = bg_sel },

  -- mini.* (LazyVim uses mini.ai / mini.icons / mini.pairs)
  MiniIconsAzure = { fg = c_operator },
  MiniIconsBlue = { fg = c_bracket },
  MiniIconsCyan = { fg = olive_hi },
  MiniIconsGreen = { fg = c_literal },
  MiniIconsGrey = { fg = c_comment },
  MiniIconsOrange = { fg = c_lead },
  MiniIconsPurple = { fg = c_chrome },
  MiniIconsRed = { fg = c_special },
  MiniIconsYellow = { fg = c_text },

  -- netrw / oil-ish fallbacks
  netrwDir = { fg = c_lead },
  netrwExe = { fg = c_literal },
  netrwSymLink = { fg = c_special },

  -- grug-far
  GrugFarResultsPath = { fg = c_lead, bold = true },
  GrugFarResultsLineNr = { fg = c_chrome },
  GrugFarResultsMatch = { fg = bg, bg = c_lead },
  GrugFarInputLabel = { fg = c_special },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ══════════════════════════════════════════════════════════════
-- :terminal palette — the same warm range, so shells inside nvim
-- match the editor. Red/magenta only exist here and in errors.
-- ══════════════════════════════════════════════════════════════
vim.g.terminal_color_0 = brown_dark
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = olive
vim.g.terminal_color_3 = orange
vim.g.terminal_color_4 = brown
vim.g.terminal_color_5 = magenta
vim.g.terminal_color_6 = olive_mid
vim.g.terminal_color_7 = gold
vim.g.terminal_color_8 = brown_mid
vim.g.terminal_color_9 = red_hi
vim.g.terminal_color_10 = olive_hi
vim.g.terminal_color_11 = gold_hi
vim.g.terminal_color_12 = orange_hi
vim.g.terminal_color_13 = magenta_hi
vim.g.terminal_color_14 = "#C9C68F"
vim.g.terminal_color_15 = gold_max
