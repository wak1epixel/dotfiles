vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "coffee"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- ANSI PALETTE — kitty "Mona Lisa"
-- Verify against ~/.config/kitty/current-theme.conf
-- ══════════════════════════════════════════════════════════════
local bg = "#110B0D"
local fg = "#F1D67A" -- R241 G214 B122 — primary text color

local black = "#341A0D"
local red = "#9B281B"
local green = "#626138" -- R98 G97 B56 — secondary text color
local yellow = "#C26E27"
local blue = "#515B5C"
local magenta = "#9B1D29"
local cyan = "#588056"
local white = "#F6D75C"

local br_black = "#874227"
local br_red = "#FF4230"
local br_green = "#B3B163"
local br_yellow = "#FF9565"
local br_blue = "#9EB2B3"
local br_magenta = "#FF5B6A"
local br_cyan = "#89CC8E"
local br_white = "#FFE597"

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — this is the part to edit.
-- Every highlight below points at one of these, so changing a
-- line here re-themes everything that uses it.
-- ══════════════════════════════════════════════════════════════
local c_text = fg -- variables, properties, plain code — priority 1, the workhorse
local c_comment = green -- comments and doc-comments — priority 2, olive
local c_string = br_green -- strings, chars, raw text — bright olive so it stays legible
local c_number = br_green -- numbers, booleans, constants — literals share the olive
local c_keyword = br_yellow -- if / for / return / const, control flow
local c_func = br_white -- function names and calls
local c_type = br_blue -- types, classes, structs, enums — the one cool tone
local c_import = br_blue -- import / include / use, modules, namespaces
local c_punct = "#8A7C4F" -- brackets, operators, delimiters — gold/olive blend, recedes
local c_special = yellow -- escapes, macros, decorators, self / this
local c_error = br_red
local c_warn = yellow
local c_hint = br_cyan

local bg_alt = "#1C1214" -- floats, cursorline, pmenu
local bg_visual = "#3A2418"
local bg_sel = "#2A1A14"

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.coffee_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.coffee_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = br_black, bg = BG_A },
  FloatTitle = { fg = c_keyword, bg = BG_A, bold = true },
  LineNr = { fg = br_black },
  CursorLineNr = { fg = c_keyword, bold = true },
  CursorLine = { bg = clear and "none" or bg_alt },
  ColorColumn = { bg = bg_alt },
  Visual = { bg = bg_visual },
  Search = { fg = bg, bg = c_keyword },
  IncSearch = { fg = bg, bg = br_white },
  CurSearch = { fg = bg, bg = br_white },
  MatchParen = { fg = c_keyword, bold = true },
  StatusLine = { fg = bg, bg = white, bold = true },
  StatusLineNC = { fg = br_black, bg = BG_A },
  WinSeparator = { fg = br_black },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = br_white, bg = bg_sel, bold = true },
  PmenuSbar = { bg = bg_alt },
  PmenuThumb = { bg = br_black },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = br_black, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = br_black },
  EndOfBuffer = { fg = clear and br_black or bg },
  Directory = { fg = c_type },
  Title = { fg = c_keyword, bold = true },
  Question = { fg = c_hint },
  ModeMsg = { fg = c_keyword, bold = true },
  MoreMsg = { fg = c_hint },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = br_black },
  SpecialKey = { fg = br_black },
  Whitespace = { fg = "#2A1C14" },
  Cursor = { fg = bg, bg = fg },
  TermCursor = { fg = bg, bg = c_keyword },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError = { fg = c_error },
  DiagnosticWarn = { fg = c_warn },
  DiagnosticInfo = { fg = c_hint },
  DiagnosticHint = { fg = c_import },
  DiagnosticOk = { fg = br_green },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_import },

  DiffAdd = { fg = br_green, bg = "#1E2410" },
  DiffDelete = { fg = c_error, bg = "#2A0F0C" },
  DiffChange = { fg = c_keyword, bg = "#2A1A0C" },
  DiffText = { fg = br_white, bg = "#3A2410" },

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
  Type = { fg = c_type },
  StorageClass = { fg = c_keyword },
  Structure = { fg = c_type },
  Typedef = { fg = c_type },
  Special = { fg = c_special },
  Delimiter = { fg = c_punct },
  Underlined = { fg = c_type, underline = true },
  Error = { fg = c_error, bold = true },
  Todo = { fg = bg, bg = c_keyword, bold = true },

  -- ── treesitter: text and identifiers ─────────────────────
  ["@variable"] = { fg = c_text },
  ["@variable.member"] = { fg = c_text },
  ["@variable.parameter"] = { fg = c_text, italic = true },
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
  ["@type.qualifier"] = { fg = c_keyword, italic = true },
  ["@module"] = { fg = c_import },
  ["@namespace"] = { fg = c_import },

  -- ── treesitter: keywords ─────────────────────────────────
  ["@keyword"] = { fg = c_keyword },
  ["@keyword.function"] = { fg = c_keyword },
  ["@keyword.return"] = { fg = c_keyword, bold = true },
  ["@keyword.conditional"] = { fg = c_keyword },
  ["@keyword.repeat"] = { fg = c_keyword },
  ["@keyword.operator"] = { fg = c_keyword },
  ["@keyword.exception"] = { fg = c_keyword, bold = true },
  ["@keyword.modifier"] = { fg = c_keyword, italic = true },
  ["@keyword.coroutine"] = { fg = c_keyword, italic = true },

  -- ── treesitter: literals ─────────────────────────────────
  ["@string"] = { fg = c_string },
  ["@string.escape"] = { fg = c_special },
  ["@string.special"] = { fg = c_special },
  ["@string.regexp"] = { fg = c_special },
  ["@character"] = { fg = c_string },
  ["@number"] = { fg = c_number },
  ["@number.float"] = { fg = c_number },
  ["@boolean"] = { fg = c_number },
  ["@constant"] = { fg = c_number, bold = true },
  ["@constant.builtin"] = { fg = c_number, bold = true },
  ["@constant.macro"] = { fg = c_special, bold = true },

  -- ── treesitter: punctuation ──────────────────────────────
  ["@operator"] = { fg = c_punct },
  ["@punctuation"] = { fg = c_punct },
  ["@punctuation.bracket"] = { fg = c_punct },
  ["@punctuation.delimiter"] = { fg = c_punct },
  ["@punctuation.special"] = { fg = c_special },
  ["@label"] = { fg = c_keyword },
  ["@attribute"] = { fg = c_special, italic = true },

  -- ── treesitter: comments ─────────────────────────────────
  ["@comment"] = { fg = c_comment, italic = true },
  ["@comment.documentation"] = { fg = c_comment, italic = true },
  ["@comment.error"] = { fg = c_error },
  ["@comment.warning"] = { fg = c_warn },
  ["@comment.todo"] = { fg = bg, bg = c_keyword, bold = true },
  ["@comment.note"] = { fg = bg, bg = c_hint, bold = true },

  -- ── C / C++ ──────────────────────────────────────────────
  ["@keyword.import"] = { fg = c_import },
  ["@keyword.directive"] = { fg = c_import },
  ["@keyword.directive.define"] = { fg = c_import },
  ["@preproc"] = { fg = c_import },
  ["@string.special.path"] = { fg = c_import, italic = true }, -- <iostream>

  -- ── Python ───────────────────────────────────────────────
  ["@keyword.type"] = { fg = c_keyword },
  ["@function.decorator"] = { fg = c_special, italic = true },
  ["@string.documentation"] = { fg = c_string, italic = true },

  -- ── markup ───────────────────────────────────────────────
  ["@markup.heading"] = { fg = c_keyword, bold = true },
  ["@markup.heading.1"] = { fg = c_keyword, bold = true },
  ["@markup.heading.2"] = { fg = c_func, bold = true },
  ["@markup.heading.3"] = { fg = c_type },
  ["@markup.strong"] = { fg = br_white, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.link"] = { fg = c_import, underline = true },
  ["@markup.link.url"] = { fg = c_type, underline = true },
  ["@markup.raw"] = { fg = c_string },
  ["@markup.list"] = { fg = c_keyword },
  ["@markup.quote"] = { fg = c_comment, italic = true },

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
  ["@lsp.type.string"] = { fg = c_string },
  ["@lsp.type.number"] = { fg = c_number },
  ["@lsp.type.comment"] = { fg = c_comment, italic = true },
  ["@lsp.mod.readonly"] = { fg = c_number },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = c_text, bg = BG_A },
  TelescopeBorder = { fg = br_black, bg = BG_A },
  TelescopeSelection = { fg = br_white, bg = bg_sel },
  TelescopeMatching = { fg = c_keyword, bold = true },
  TelescopePromptTitle = { fg = bg, bg = c_keyword, bold = true },
  NeoTreeNormal = { fg = c_text, bg = BG },
  NeoTreeNormalNC = { fg = c_text, bg = BG },
  NeoTreeDirectoryName = { fg = c_type },
  NeoTreeDirectoryIcon = { fg = c_type },
  NeoTreeRootName = { fg = c_keyword, bold = true },
  NeoTreeGitModified = { fg = c_keyword },
  NeoTreeGitAdded = { fg = br_green },
  NeoTreeGitDeleted = { fg = c_error },
  WhichKeyFloat = { bg = BG_A },
  WhichKey = { fg = c_keyword },
  WhichKeyGroup = { fg = c_type },
  WhichKeyDesc = { fg = c_text },
  GitSignsAdd = { fg = br_green },
  GitSignsChange = { fg = c_keyword },
  GitSignsDelete = { fg = c_error },
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrMatch = { fg = c_keyword, bold = true },
  CmpItemKind = { fg = c_type },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── terminal palette (:terminal matches kitty) ──────────────
vim.g.terminal_color_0 = black
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = green
vim.g.terminal_color_3 = yellow
vim.g.terminal_color_4 = blue
vim.g.terminal_color_5 = magenta
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = white
vim.g.terminal_color_8 = br_black
vim.g.terminal_color_9 = br_red
vim.g.terminal_color_10 = br_green
vim.g.terminal_color_11 = br_yellow
vim.g.terminal_color_12 = br_blue
vim.g.terminal_color_13 = br_magenta
vim.g.terminal_color_14 = br_cyan
vim.g.terminal_color_15 = br_white
