vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "monet"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- monet — Nymphéas, the afternoon pond at Giverny
-- Dusty-lavender water, blue-green lily pads, blossom pink and
-- cream, violet willow reflections. Low contrast, nothing shouts
-- — the pond at dusk rather than a light canvas.
-- ══════════════════════════════════════════════════════════════

local bg  = "#151824" -- deep slate blue-violet — the water in shadow
local bg2 = "#1b1f2d" -- floats, pmenu, statusline
local bg3 = "#1f2334" -- cursorline / column — a ripple above bg

-- ── the pond ────────────────────────────────────────────────
local lavender = "#bcb8de" -- dusty water-lavender — primary text
local sky      = "#d3dcec" -- palest reflected sky — numbers, constants
local padgreen = "#93b394" -- blue-green lily pad — strings
local teal     = "#6fa6a4" -- deeper green reflection — imports, namespaces
local pink     = "#e2a6c4" -- water-lily blossom — keywords
local rose     = "#d98faa" -- deeper blossom — self / this, escapes, macros
local cream    = "#ede0bd" -- cream blossom / sun on the water — functions
local violet   = "#ab9cd6" -- violet willow reflection — types
local gold     = "#cdb478" -- low sun on the pond — search, warnings

local willow    = "#6d7699" -- willow shadow — comments
local willow_d  = "#4b5474" -- reeds at the far bank — line numbers, chrome
local willow_dd = "#2a3048" -- silt — whitespace, indent guides

local coral = "#d98080" -- the one warm alarm — errors, deletions

-- ── still-water fills (backgrounds, not text) ───────────────
local sel    = "#313a5a" -- pmenu / picker selection
local visual = "#2a3350" -- visual selection
local ripple = "#232842" -- lsp references, word under cursor

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — edit here to re-theme everything downstream.
-- ══════════════════════════════════════════════════════════════
local c_text    = lavender -- variables, properties, plain code — the workhorse
local c_comment = willow   -- comments and doc-comments
local c_string  = padgreen -- strings, chars, raw text
local c_number  = sky      -- numbers, booleans, constants — palest, lifts out
local c_keyword = pink     -- if / for / return / const — blossom
local c_func    = cream    -- function names and calls — the lit blossom
local c_type    = violet   -- types, classes, structs, enums
local c_import   = teal    -- import / include / use, modules, namespaces
local c_punct   = willow_d -- brackets, operators, delimiters — recede into reeds
local c_special = rose     -- escapes, macros, decorators, self / this
local c_error   = coral
local c_warn    = gold
local c_hint    = teal
local c_info    = violet

local bg_alt    = bg2
local bg_visual = visual
local bg_sel    = sel

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.monet_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.monet_transparent == true
local BG   = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal        = { fg = c_text, bg = BG },
  NormalNC      = { fg = c_text, bg = BG },
  NormalFloat   = { fg = c_text, bg = BG_A },
  FloatBorder   = { fg = willow_d, bg = BG_A },
  FloatTitle    = { fg = c_func, bg = BG_A, bold = true },
  LineNr        = { fg = willow_d },
  LineNrAbove   = { fg = willow_d },
  LineNrBelow   = { fg = willow_d },
  CursorLineNr  = { fg = c_func, bold = true },
  CursorLine    = { bg = clear and "none" or bg3 },
  CursorColumn  = { bg = bg3 },
  ColorColumn   = { bg = bg3 },
  Visual        = { bg = bg_visual },
  VisualNOS     = { bg = bg_visual },
  Search        = { fg = bg, bg = gold },
  IncSearch     = { fg = bg, bg = pink },
  CurSearch     = { fg = bg, bg = pink },
  Substitute    = { fg = bg, bg = coral },
  MatchParen    = { fg = cream, bg = sel, bold = true },
  StatusLine    = { fg = bg, bg = violet, bold = true },
  StatusLineNC  = { fg = willow_d, bg = BG_A },
  WinBar        = { fg = c_text, bg = BG },
  WinBarNC      = { fg = willow_d, bg = BG },
  TabLine       = { fg = willow_d, bg = BG_A },
  TabLineFill   = { bg = BG },
  TabLineSel    = { fg = bg, bg = violet, bold = true },
  WinSeparator  = { fg = willow_d, bg = BG },
  VertSplit     = { fg = willow_d, bg = BG },
  Pmenu         = { fg = c_text, bg = BG_A },
  PmenuSel      = { fg = cream, bg = bg_sel, bold = true },
  PmenuSbar     = { bg = bg2 },
  PmenuThumb    = { bg = willow_d },
  PmenuKind     = { fg = c_type, bg = BG_A },
  PmenuExtra    = { fg = willow_d, bg = BG_A },
  WildMenu      = { fg = bg, bg = gold },
  Folded        = { fg = c_comment, bg = BG_A },
  FoldColumn    = { fg = willow_dd, bg = "none" },
  SignColumn    = { bg = "none" },
  NonText       = { fg = willow_dd },
  Whitespace    = { fg = willow_dd },
  EndOfBuffer   = { fg = clear and willow_dd or bg },
  Directory     = { fg = c_type },
  Title         = { fg = c_func, bold = true },
  Question      = { fg = c_hint },
  ModeMsg       = { fg = c_keyword, bold = true },
  MsgArea       = { fg = c_text },
  MoreMsg       = { fg = c_hint },
  WarningMsg    = { fg = c_warn },
  ErrorMsg      = { fg = c_error },
  Conceal       = { fg = willow_d },
  SpecialKey    = { fg = willow_d },
  Cursor        = { fg = bg, bg = lavender },
  lCursor       = { fg = bg, bg = lavender },
  TermCursor    = { fg = bg, bg = lavender },
  QuickFixLine  = { bg = visual, bold = true },
  SpellBad      = { undercurl = true, sp = c_error },
  SpellCap      = { undercurl = true, sp = c_warn },
  SpellLocal    = { undercurl = true, sp = c_info },
  SpellRare     = { undercurl = true, sp = c_hint },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError            = { fg = c_error },
  DiagnosticWarn             = { fg = c_warn },
  DiagnosticInfo             = { fg = c_info },
  DiagnosticHint             = { fg = c_hint },
  DiagnosticOk               = { fg = padgreen },
  DiagnosticUnderlineError   = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn    = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo    = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint    = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk      = { undercurl = true, sp = padgreen },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn  = { fg = c_warn },
  DiagnosticVirtualTextInfo  = { fg = c_info },
  DiagnosticVirtualTextHint  = { fg = c_hint },
  DiagnosticUnnecessary      = { fg = willow_d, undercurl = true, sp = willow_d },
  DiagnosticDeprecated       = { fg = willow_d, strikethrough = true },

  DiffAdd    = { fg = padgreen, bg = "#1a2624" },
  DiffDelete = { fg = c_error,  bg = "#2a1e24" },
  DiffChange = { fg = c_warn,   bg = "#26251c" },
  DiffText   = { fg = cream,    bg = visual },
  Added      = { fg = padgreen },
  Changed    = { fg = c_warn },
  Removed    = { fg = c_error },

  -- ── legacy vim groups (non-treesitter buffers) ───────────
  Comment        = { fg = c_comment, italic = true },
  Constant       = { fg = c_number },
  String         = { fg = c_string },
  Character      = { fg = c_string },
  Number         = { fg = c_number },
  Boolean        = { fg = c_number },
  Float          = { fg = c_number },
  Identifier     = { fg = c_text },
  Function       = { fg = c_func },
  Statement      = { fg = c_keyword },
  Conditional    = { fg = c_keyword },
  Repeat         = { fg = c_keyword },
  Label          = { fg = c_keyword },
  Operator       = { fg = c_punct },
  Keyword        = { fg = c_keyword },
  Exception      = { fg = c_keyword, bold = true },
  PreProc        = { fg = c_import },
  Include        = { fg = c_import },
  Define         = { fg = c_import },
  Macro          = { fg = c_special },
  PreCondit      = { fg = c_import },
  Type           = { fg = c_type },
  StorageClass   = { fg = c_keyword },
  Structure      = { fg = c_type },
  Typedef        = { fg = c_type },
  Special        = { fg = c_special },
  SpecialChar    = { fg = c_special },
  SpecialComment = { fg = c_comment, bold = true },
  Tag            = { fg = c_type },
  Delimiter      = { fg = c_punct },
  Debug          = { fg = c_special },
  Underlined     = { fg = c_type, underline = true },
  Ignore         = { fg = willow_d },
  Error          = { fg = c_error, bold = true },
  Todo           = { fg = bg, bg = c_func, bold = true },

  -- ── treesitter: text and identifiers ─────────────────────
  ["@variable"]                   = { fg = c_text },
  ["@variable.member"]            = { fg = c_text },
  ["@variable.parameter"]         = { fg = c_text, italic = true },
  ["@variable.parameter.builtin"] = { fg = c_special, italic = true },
  ["@variable.builtin"]           = { fg = c_special, italic = true }, -- self, this
  ["@property"]                   = { fg = c_text },
  ["@field"]                      = { fg = c_text },

  -- ── treesitter: functions ────────────────────────────────
  ["@function"]             = { fg = c_func },
  ["@function.call"]        = { fg = c_func },
  ["@function.method"]      = { fg = c_func },
  ["@function.method.call"] = { fg = c_func },
  ["@function.builtin"]     = { fg = c_func, italic = true },
  ["@function.macro"]       = { fg = c_special },
  ["@constructor"]          = { fg = c_type },

  -- ── treesitter: types ────────────────────────────────────
  ["@type"]            = { fg = c_type },
  ["@type.builtin"]    = { fg = c_type },
  ["@type.definition"] = { fg = c_type, bold = true },
  ["@type.qualifier"]  = { fg = c_keyword, italic = true }, -- const, static
  ["@module"]          = { fg = c_import },
  ["@module.builtin"]  = { fg = c_import, italic = true },
  ["@namespace"]       = { fg = c_import },

  -- ── treesitter: keywords ─────────────────────────────────
  ["@keyword"]                     = { fg = c_keyword },
  ["@keyword.function"]            = { fg = c_keyword },
  ["@keyword.return"]              = { fg = c_keyword, bold = true },
  ["@keyword.conditional"]         = { fg = c_keyword },
  ["@keyword.conditional.ternary"] = { fg = c_punct },
  ["@keyword.repeat"]              = { fg = c_keyword },
  ["@keyword.operator"]            = { fg = c_keyword }, -- sizeof, new, not, in
  ["@keyword.exception"]           = { fg = c_keyword, bold = true },
  ["@keyword.modifier"]            = { fg = c_keyword, italic = true },
  ["@keyword.coroutine"]           = { fg = c_keyword, italic = true }, -- async, await
  ["@keyword.type"]                = { fg = c_keyword }, -- class, struct, def
  ["@keyword.debug"]               = { fg = c_special },

  -- ── treesitter: literals ─────────────────────────────────
  ["@string"]            = { fg = c_string },
  ["@string.escape"]     = { fg = c_special },
  ["@string.special"]    = { fg = c_special },
  ["@string.regexp"]     = { fg = c_special },
  ["@character"]         = { fg = c_string },
  ["@character.special"] = { fg = c_special },
  ["@number"]            = { fg = c_number },
  ["@number.float"]      = { fg = c_number },
  ["@boolean"]           = { fg = c_number },
  ["@constant"]          = { fg = c_number, bold = true },
  ["@constant.builtin"]  = { fg = c_number, bold = true }, -- True, False, None, nullptr
  ["@constant.macro"]    = { fg = c_special, bold = true },

  -- ── treesitter: punctuation ──────────────────────────────
  ["@operator"]              = { fg = c_punct },
  ["@punctuation"]           = { fg = c_punct },
  ["@punctuation.bracket"]   = { fg = c_punct },
  ["@punctuation.delimiter"] = { fg = c_punct },
  ["@punctuation.special"]   = { fg = c_special }, -- f-string {} braces
  ["@label"]                 = { fg = c_keyword },
  ["@attribute"]             = { fg = c_special, italic = true }, -- decorators, [[attrs]]
  ["@attribute.builtin"]     = { fg = c_special, italic = true },

  -- ── treesitter: comments ─────────────────────────────────
  ["@comment"]               = { fg = c_comment, italic = true },
  ["@comment.documentation"] = { fg = c_comment, italic = true },
  ["@comment.error"]         = { fg = c_error },
  ["@comment.warning"]       = { fg = c_warn },
  ["@comment.todo"]          = { fg = bg, bg = c_func, bold = true },
  ["@comment.note"]          = { fg = bg, bg = c_hint, bold = true },

  -- ── C / C++ ──────────────────────────────────────────────
  ["@keyword.import"]           = { fg = c_import }, -- #include, import
  ["@keyword.directive"]        = { fg = c_import }, -- #pragma
  ["@keyword.directive.define"] = { fg = c_import }, -- #define
  ["@preproc"]                  = { fg = c_import },
  ["@string.special.path"]      = { fg = c_import, italic = true }, -- <iostream>
  ["@variable.member.cpp"]      = { fg = c_text },
  ["@lsp.type.class.cpp"]       = { fg = c_type },
  ["@lsp.typemod.variable.fileScope.cpp"]   = { fg = c_number },
  ["@lsp.typemod.variable.globalScope.cpp"] = { fg = c_number },

  -- ── Python ───────────────────────────────────────────────
  ["@function.decorator"]                   = { fg = c_special, italic = true },
  ["@function.decorator.python"]            = { fg = c_special, italic = true },
  ["@string.documentation"]                 = { fg = c_string, italic = true }, -- docstrings
  ["@type.builtin.python"]                  = { fg = c_type, italic = true }, -- int, str, list
  ["@lsp.type.selfKeyword.python"]          = { fg = c_special, italic = true },
  ["@lsp.typemod.variable.readonly.python"] = { fg = c_number },

  -- ── markup ───────────────────────────────────────────────
  ["@markup.heading"]        = { fg = c_keyword, bold = true },
  ["@markup.heading.1"]      = { fg = c_keyword, bold = true },
  ["@markup.heading.2"]      = { fg = c_func, bold = true },
  ["@markup.heading.3"]      = { fg = c_type },
  ["@markup.strong"]         = { fg = cream, bold = true },
  ["@markup.italic"]         = { fg = c_text, italic = true },
  ["@markup.strikethrough"]  = { fg = willow_d, strikethrough = true },
  ["@markup.link"]           = { fg = c_import, underline = true },
  ["@markup.link.url"]       = { fg = c_type, underline = true },
  ["@markup.link.label"]     = { fg = c_import },
  ["@markup.raw"]            = { fg = c_string },
  ["@markup.raw.block"]      = { fg = c_string },
  ["@markup.list"]           = { fg = c_keyword },
  ["@markup.list.checked"]   = { fg = padgreen },
  ["@markup.list.unchecked"] = { fg = willow_d },
  ["@markup.quote"]          = { fg = c_comment, italic = true },
  ["@diff.plus"]             = { fg = padgreen },
  ["@diff.minus"]            = { fg = c_error },
  ["@diff.delta"]            = { fg = c_warn },
  ["@tag"]                   = { fg = c_type },
  ["@tag.attribute"]         = { fg = c_special },
  ["@tag.delimiter"]         = { fg = c_punct },

  -- ── LSP semantic tokens (win over treesitter when attached) ──
  ["@lsp.type.class"]         = { fg = c_type },
  ["@lsp.type.struct"]        = { fg = c_type },
  ["@lsp.type.enum"]          = { fg = c_type },
  ["@lsp.type.interface"]     = { fg = c_type },
  ["@lsp.type.type"]          = { fg = c_type },
  ["@lsp.type.typeParameter"] = { fg = c_type, italic = true },
  ["@lsp.type.namespace"]     = { fg = c_import },
  ["@lsp.type.function"]      = { fg = c_func },
  ["@lsp.type.method"]        = { fg = c_func },
  ["@lsp.type.macro"]         = { fg = c_special },
  ["@lsp.type.variable"]      = { fg = c_text },
  ["@lsp.type.property"]      = { fg = c_text },
  ["@lsp.type.parameter"]     = { fg = c_text, italic = true },
  ["@lsp.type.enumMember"]    = { fg = c_number },
  ["@lsp.type.keyword"]       = { fg = c_keyword },
  ["@lsp.type.operator"]      = { fg = c_punct },
  ["@lsp.type.string"]        = { fg = c_string },
  ["@lsp.type.number"]        = { fg = c_number },
  ["@lsp.type.comment"]       = { fg = c_comment, italic = true },
  ["@lsp.type.decorator"]     = { fg = c_special, italic = true },
  ["@lsp.mod.readonly"]       = { fg = c_number },
  ["@lsp.typemod.variable.readonly"]        = { fg = c_number },
  ["@lsp.typemod.function.defaultLibrary"]  = { fg = c_func, italic = true },
  ["@lsp.typemod.variable.defaultLibrary"]  = { fg = c_special, italic = true },
  ["@lsp.typemod.class.defaultLibrary"]     = { fg = c_type, italic = true },
  ["@lsp.typemod.type.defaultLibrary"]      = { fg = c_type, italic = true },

  LspReferenceText            = { bg = ripple },
  LspReferenceRead            = { bg = ripple },
  LspReferenceWrite           = { bg = ripple, underline = true },
  LspSignatureActiveParameter = { fg = c_func, bold = true },
  LspInlayHint                = { fg = willow_d, bg = BG_A, italic = true },
  LspCodeLens                 = { fg = willow_d, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal         = { fg = c_text, bg = BG_A },
  TelescopeBorder         = { fg = willow_d, bg = BG_A },
  TelescopeSelection      = { fg = cream, bg = bg_sel },
  TelescopeSelectionCaret = { fg = c_keyword, bg = bg_sel },
  TelescopeMatching       = { fg = c_func, bold = true },
  TelescopePromptTitle    = { fg = bg, bg = c_keyword, bold = true },
  TelescopeResultsTitle   = { fg = bg, bg = violet, bold = true },
  TelescopePreviewTitle   = { fg = bg, bg = teal, bold = true },
  NeoTreeNormal           = { fg = c_text, bg = BG },
  NeoTreeNormalNC         = { fg = c_text, bg = BG },
  NeoTreeDirectoryName    = { fg = c_type },
  NeoTreeDirectoryIcon    = { fg = c_type },
  NeoTreeRootName         = { fg = c_keyword, bold = true },
  NeoTreeIndentMarker     = { fg = willow_d },
  NeoTreeGitModified      = { fg = c_warn },
  NeoTreeGitAdded         = { fg = padgreen },
  NeoTreeGitDeleted       = { fg = c_error },
  NeoTreeGitUntracked     = { fg = c_import },
  NvimTreeNormal          = { fg = c_text, bg = BG },
  NvimTreeFolderName      = { fg = c_type },
  NvimTreeFolderIcon      = { fg = c_type },
  NvimTreeRootFolder      = { fg = c_keyword, bold = true },
  NvimTreeIndentMarker    = { fg = willow_d },
  WhichKeyFloat           = { bg = BG_A },
  WhichKeyNormal          = { bg = BG_A },
  WhichKey                = { fg = c_keyword },
  WhichKeyGroup           = { fg = c_type },
  WhichKeyDesc            = { fg = c_text },
  WhichKeySeparator       = { fg = willow_d },
  GitSignsAdd              = { fg = padgreen },
  GitSignsChange           = { fg = c_warn },
  GitSignsDelete           = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = willow_d, italic = true },
  CmpItemAbbr           = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = willow_d, strikethrough = true },
  CmpItemAbbrMatch      = { fg = c_func, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = c_func },
  CmpItemKind           = { fg = c_type },
  CmpItemMenu           = { fg = willow_d },
  BlinkCmpMenu          = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder    = { fg = willow_d, bg = BG_A },
  BlinkCmpMenuSelection = { fg = cream, bg = bg_sel, bold = true },
  BlinkCmpLabelMatch    = { fg = c_func, bold = true },
  BlinkCmpKind          = { fg = c_type },
  BlinkCmpDoc           = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder     = { fg = willow_d, bg = BG_A },
  SnacksNormal          = { fg = c_text, bg = BG_A },
  SnacksWinBar          = { fg = c_func, bg = BG_A, bold = true },
  SnacksBackdrop        = { bg = bg },
  SnacksDashboardHeader = { fg = violet },
  SnacksDashboardIcon   = { fg = c_keyword },
  SnacksDashboardDesc   = { fg = c_text },
  SnacksDashboardKey    = { fg = c_func },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch     = { fg = c_func, bold = true },
  SnacksPickerDir       = { fg = willow_d },
  SnacksIndent          = { fg = willow_dd },
  SnacksIndentScope     = { fg = willow_d },
  IblIndent             = { fg = willow_dd },
  IblScope              = { fg = willow_d },
  MiniIndentscopeSymbol = { fg = willow_d },
  FlashLabel            = { fg = bg, bg = c_error, bold = true },
  FlashMatch            = { fg = cream, bg = visual },
  TroubleNormal         = { fg = c_text, bg = BG_A },
  TroubleText           = { fg = c_text },
  TroubleCount          = { fg = c_func, bold = true },
  LazyNormal            = { fg = c_text, bg = BG_A },
  LazyH1                = { fg = bg, bg = violet, bold = true },
  LazyButtonActive      = { fg = bg, bg = c_func, bold = true },
  LazyProgressDone      = { fg = padgreen },
  MasonNormal           = { fg = c_text, bg = BG_A },
  MasonHeader           = { fg = bg, bg = violet, bold = true },
  MasonHighlight        = { fg = c_type },
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
  IlluminatedWordText   = { bg = ripple },
  IlluminatedWordRead   = { bg = ripple },
  IlluminatedWordWrite  = { bg = ripple },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── terminal palette ────────────────────────────────────────
vim.g.terminal_color_0  = bg2
vim.g.terminal_color_1  = coral
vim.g.terminal_color_2  = padgreen
vim.g.terminal_color_3  = gold
vim.g.terminal_color_4  = violet
vim.g.terminal_color_5  = pink
vim.g.terminal_color_6  = teal
vim.g.terminal_color_7  = lavender
vim.g.terminal_color_8  = willow_d
vim.g.terminal_color_9  = rose
vim.g.terminal_color_10 = padgreen
vim.g.terminal_color_11 = cream
vim.g.terminal_color_12 = "#b7a8e0"
vim.g.terminal_color_13 = rose
vim.g.terminal_color_14 = "#8fc4c0"
vim.g.terminal_color_15 = sky
