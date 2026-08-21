vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "lain"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- PALETTE
-- ══════════════════════════════════════════════════════════════
-- cyan   P1  types, brackets, line numbers, operators, keywords
-- mint   P1  secondary — constants, booleans, escapes, decorators
-- lime   P2  variables, function names, stdlib, properties
-- white  P3  STRINGS ONLY
-- cream  P4  #include / import lines
-- dim        comments, gutter, inactive UI
-- ══════════════════════════════════════════════════════════════
local cyan = "#70FFF8"
local mint = "#00FFAF"
local lime = "#BBFF91"
local white = "#FFFEE9"
--local white = "#FFBEA8" -- rosepine orange
local cream = "#FFEAB8"
local dim = "#2B4A52" -- muted cyan-grey, comments
local red = "#FF5F6D" -- errors only

local bg = "#000000"
local bg_alt = "#0A0F12"

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.lain_transparent = true   before loading the scheme
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.lain_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = lime, bg = BG },
  NormalNC = { fg = lime, bg = BG },
  NormalFloat = { fg = lime, bg = BG_A },
  FloatBorder = { fg = cyan, bg = BG_A },
  FloatTitle = { fg = cyan, bg = BG_A, bold = true },
  LineNr = { fg = cyan }, -- P1
  CursorLineNr = { fg = mint, bold = true },
  CursorLine = { bg = clear and "none" or bg_alt },
  ColorColumn = { bg = bg_alt },
  Visual = { bg = "#0F3A42" },
  Search = { fg = bg, bg = cyan },
  IncSearch = { fg = bg, bg = mint },
  CurSearch = { fg = bg, bg = mint },
  MatchParen = { fg = mint, bold = true },
  StatusLine = { fg = bg, bg = cyan, bold = true },
  StatusLineNC = { fg = dim, bg = BG_A },
  WinSeparator = { fg = cyan },
  VertSplit = { fg = cyan },
  Pmenu = { fg = lime, bg = BG_A },
  PmenuSel = { fg = bg, bg = cyan },
  PmenuSbar = { bg = bg_alt },
  PmenuThumb = { bg = cyan },
  Folded = { fg = dim, bg = BG_A },
  FoldColumn = { fg = dim, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = dim },
  EndOfBuffer = { fg = clear and dim or bg },
  Directory = { fg = cyan },
  Title = { fg = mint, bold = true },
  Question = { fg = mint },
  ModeMsg = { fg = cyan, bold = true },
  MoreMsg = { fg = mint },
  WarningMsg = { fg = cream },
  ErrorMsg = { fg = red },
  Conceal = { fg = dim },
  SpecialKey = { fg = dim },
  Whitespace = { fg = "#1A2A30" },
  Cursor = { fg = bg, bg = cyan },
  TermCursor = { fg = bg, bg = mint },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError = { fg = red },
  DiagnosticWarn = { fg = cream },
  DiagnosticInfo = { fg = cyan },
  DiagnosticHint = { fg = mint },
  DiagnosticUnderlineError = { undercurl = true, sp = red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = cream },
  DiagnosticUnderlineInfo = { undercurl = true, sp = cyan },
  DiagnosticUnderlineHint = { undercurl = true, sp = mint },

  DiffAdd = { fg = mint, bg = "#052A22" },
  DiffDelete = { fg = red, bg = "#2A0A0E" },
  DiffChange = { fg = cyan, bg = "#052430" },
  DiffText = { fg = mint, bg = "#0A3A32" },

  -- ── legacy vim groups (non-treesitter buffers) ───────────
  Comment = { fg = dim, italic = true },
  Constant = { fg = mint },
  String = { fg = white }, -- P3
  Character = { fg = white },
  Number = { fg = mint },
  Boolean = { fg = mint },
  Float = { fg = mint },
  Identifier = { fg = lime }, -- P2
  Function = { fg = lime },
  Statement = { fg = cyan },
  Conditional = { fg = cyan },
  Repeat = { fg = cyan },
  Operator = { fg = cyan },
  Keyword = { fg = cyan },
  Exception = { fg = cyan, bold = true },
  PreProc = { fg = cream }, -- P4
  Include = { fg = cream },
  Define = { fg = cream },
  Macro = { fg = cream },
  Type = { fg = cyan }, -- P1
  StorageClass = { fg = cyan },
  Structure = { fg = cyan },
  Typedef = { fg = cyan },
  Special = { fg = mint },
  Delimiter = { fg = cyan }, -- P1 brackets
  Underlined = { fg = cyan, underline = true },
  Error = { fg = red, bold = true },
  Todo = { fg = bg, bg = cream, bold = true },

  -- ── treesitter: P1 cyan ──────────────────────────────────
  ["@type"] = { fg = cyan },
  ["@type.builtin"] = { fg = cyan },
  ["@type.definition"] = { fg = cyan, bold = true },
  ["@type.qualifier"] = { fg = cyan, italic = true },
  ["@structure"] = { fg = cyan },
  ["@storageclass"] = { fg = cyan },
  ["@keyword"] = { fg = cyan },
  ["@keyword.function"] = { fg = cyan },
  ["@keyword.return"] = { fg = cyan, bold = true },
  ["@keyword.conditional"] = { fg = cyan },
  ["@keyword.repeat"] = { fg = cyan },
  ["@keyword.operator"] = { fg = cyan },
  ["@keyword.exception"] = { fg = cyan, bold = true },
  ["@keyword.modifier"] = { fg = cyan, italic = true },
  ["@operator"] = { fg = cyan },
  ["@punctuation"] = { fg = cyan },
  ["@punctuation.bracket"] = { fg = cyan },
  ["@punctuation.delimiter"] = { fg = cyan },
  ["@label"] = { fg = cyan },
  ["@tag"] = { fg = cyan },
  ["@tag.delimiter"] = { fg = cyan },

  -- ── treesitter: P1 mint (secondary) ──────────────────────
  ["@constant"] = { fg = mint },
  ["@constant.builtin"] = { fg = mint },
  ["@constant.macro"] = { fg = mint, bold = true },
  ["@boolean"] = { fg = mint },
  ["@number"] = { fg = mint },
  ["@number.float"] = { fg = mint },
  ["@string.escape"] = { fg = mint },
  ["@string.special"] = { fg = mint },
  ["@punctuation.special"] = { fg = mint },
  ["@variable.builtin"] = { fg = mint, italic = true }, -- self, this
  ["@attribute"] = { fg = mint, italic = true },
  ["@constructor"] = { fg = mint },

  -- ── treesitter: P2 lime ──────────────────────────────────
  ["@variable"] = { fg = lime },
  ["@variable.member"] = { fg = lime },
  ["@variable.parameter"] = { fg = lime, italic = true },
  ["@property"] = { fg = lime },
  ["@field"] = { fg = lime },
  ["@function"] = { fg = lime },
  ["@function.call"] = { fg = lime },
  ["@function.method"] = { fg = lime },
  ["@function.method.call"] = { fg = lime },
  ["@function.builtin"] = { fg = lime, bold = true }, -- stdlib
  ["@function.macro"] = { fg = lime },
  ["@module"] = { fg = lime },
  ["@namespace"] = { fg = lime },

  -- ── treesitter: P3 white — strings only ──────────────────
  ["@string"] = { fg = white },
  ["@character"] = { fg = white },
  ["@string.documentation"] = { fg = white, italic = true },

  -- ── treesitter: P4 cream — includes/imports ──────────────
  ["@keyword.import"] = { fg = cream },
  ["@keyword.directive"] = { fg = cream },
  ["@keyword.directive.define"] = { fg = cream },
  ["@preproc"] = { fg = cream },
  ["@include"] = { fg = cream },
  ["@string.special.path"] = { fg = cream }, -- <iostream>, "foo.h"

  -- ── comments ─────────────────────────────────────────────
  ["@comment"] = { fg = dim, italic = true },
  ["@comment.documentation"] = { fg = dim, italic = true },
  ["@comment.error"] = { fg = red },
  ["@comment.warning"] = { fg = cream },
  ["@comment.todo"] = { fg = bg, bg = cream, bold = true },
  ["@comment.note"] = { fg = bg, bg = mint, bold = true },

  -- ── markup ───────────────────────────────────────────────
  ["@markup.heading"] = { fg = cyan, bold = true },
  ["@markup.strong"] = { fg = lime, bold = true },
  ["@markup.italic"] = { fg = lime, italic = true },
  ["@markup.link"] = { fg = mint, underline = true },
  ["@markup.link.url"] = { fg = cream, underline = true },
  ["@markup.raw"] = { fg = white },
  ["@markup.list"] = { fg = cyan },
  ["@markup.quote"] = { fg = dim, italic = true },

  -- ── LSP semantic tokens (override treesitter when attached) ──
  ["@lsp.type.class"] = { fg = cyan },
  ["@lsp.type.struct"] = { fg = cyan },
  ["@lsp.type.enum"] = { fg = cyan },
  ["@lsp.type.interface"] = { fg = cyan },
  ["@lsp.type.type"] = { fg = cyan },
  ["@lsp.type.typeParameter"] = { fg = cyan, italic = true },
  ["@lsp.type.keyword"] = { fg = cyan },
  ["@lsp.type.operator"] = { fg = cyan },
  ["@lsp.type.macro"] = { fg = cream },
  ["@lsp.type.namespace"] = { fg = lime },
  ["@lsp.type.function"] = { fg = lime },
  ["@lsp.type.method"] = { fg = lime },
  ["@lsp.type.variable"] = { fg = lime },
  ["@lsp.type.property"] = { fg = lime },
  ["@lsp.type.parameter"] = { fg = lime, italic = true },
  ["@lsp.type.enumMember"] = { fg = mint },
  ["@lsp.type.string"] = { fg = white },
  ["@lsp.type.number"] = { fg = mint },
  ["@lsp.type.comment"] = { fg = dim, italic = true },
  ["@lsp.mod.readonly"] = { fg = mint },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = lime, bg = BG_A },
  TelescopeBorder = { fg = cyan, bg = BG_A },
  TelescopeSelection = { fg = mint, bg = "#0F3A42" },
  TelescopeMatching = { fg = mint, bold = true },
  NeoTreeNormal = { fg = lime, bg = BG },
  NeoTreeNormalNC = { fg = lime, bg = BG },
  NeoTreeDirectoryName = { fg = cyan },
  NeoTreeDirectoryIcon = { fg = cyan },
  NeoTreeRootName = { fg = mint, bold = true },
  NeoTreeGitModified = { fg = cream },
  NeoTreeGitAdded = { fg = mint },
  NeoTreeGitDeleted = { fg = red },
  WhichKeyFloat = { bg = BG_A },
  WhichKey = { fg = mint },
  WhichKeyGroup = { fg = cyan },
  WhichKeyDesc = { fg = lime },
  GitSignsAdd = { fg = mint },
  GitSignsChange = { fg = cyan },
  GitSignsDelete = { fg = red },
  CmpItemAbbr = { fg = lime },
  CmpItemAbbrMatch = { fg = mint, bold = true },
  CmpItemKind = { fg = cyan },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- terminal palette
vim.g.terminal_color_0 = bg
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = lime
vim.g.terminal_color_3 = cream
vim.g.terminal_color_4 = cyan
vim.g.terminal_color_5 = mint
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = white
vim.g.terminal_color_8 = dim
vim.g.terminal_color_9 = red
vim.g.terminal_color_10 = lime
vim.g.terminal_color_11 = cream
vim.g.terminal_color_12 = cyan
vim.g.terminal_color_13 = mint
vim.g.terminal_color_14 = mint
vim.g.terminal_color_15 = white
