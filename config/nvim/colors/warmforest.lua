vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "warmforest"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════════
-- PALETTE — from the "NeoVim" poster art (sand / rust / forest)
-- Exact swatches from the reference image.
-- ══════════════════════════════════════════════════════════════
local bg = "#1d1d1d" -- editor background
local bg2 = "#222222" -- floats, pmenu, statusline

local sand = "#d4c68b" -- R212 G198 B139 — primary text color
local gold = "#c5a761"
local orange = "#b27b4e"
local rust = "#a9724b"
local bark = "#665947" -- brown-gray: line numbers, borders, whitespace
local olive = "#7b8451"
local moss = "#678563"
local green = "#649963"
local green_d = "#456d44"
local forest = "#384e30" -- darkest title green — selections
local sage = "#a1baa1"
local mint = "#bfd2bf" -- lightest tone in the palette

-- derived shades (not in the reference image, but needed)
local ember = "#bf5f3f" -- errors / deletions — the palette has no red
local stone = "#8a7b5e" -- sand·bark blend — punctuation that recedes
local bg3 = "#262626" -- cursorline / column, one step above bg

-- ══════════════════════════════════════════════════════════════
-- ROLE MAP — this is the part to edit.
-- Every highlight below points at one of these, so changing a
-- line here re-themes everything that uses it.
-- ══════════════════════════════════════════════════════════════
local c_text = sand -- variables, properties, plain code — the workhorse
local c_comment = moss -- comments and doc-comments — muted forest green
local c_string = olive -- strings, chars, raw text
local c_number = mint -- numbers, booleans, constants — palest tone, pops out
local c_keyword = orange -- if / for / return / const, control flow
local c_func = gold -- function names and calls
local c_type = green -- types, classes, structs, enums
local c_import = sage -- import / include / use, modules, namespaces
local c_punct = stone -- brackets, operators, delimiters — recedes
local c_special = rust -- escapes, macros, decorators, self / this
local c_error = ember
local c_warn = gold
local c_hint = green
local c_info = sage

local bg_alt = bg2 -- floats, pmenu
local bg_visual = forest -- visual selection
local bg_sel = green_d -- pmenu / picker selection

-- ══════════════════════════════════════════════════════════════
-- TRANSPARENCY
-- :lua vim.g.warmforest_transparent = true   before the scheme loads
-- ══════════════════════════════════════════════════════════════
local clear = vim.g.warmforest_transparent == true
local BG = clear and "none" or bg
local BG_A = clear and "none" or bg_alt

local hl = {
  -- ── editor chrome ────────────────────────────────────────
  Normal = { fg = c_text, bg = BG },
  NormalNC = { fg = c_text, bg = BG },
  NormalFloat = { fg = c_text, bg = BG_A },
  FloatBorder = { fg = bark, bg = BG_A },
  FloatTitle = { fg = c_func, bg = BG_A, bold = true },
  LineNr = { fg = bark },
  LineNrAbove = { fg = bark },
  LineNrBelow = { fg = bark },
  CursorLineNr = { fg = c_func, bold = true },
  CursorLine = { bg = clear and "none" or bg3 },
  CursorColumn = { bg = bg3 },
  ColorColumn = { bg = bg3 },
  Visual = { bg = bg_visual },
  VisualNOS = { bg = bg_visual },
  Search = { fg = bg, bg = gold },
  IncSearch = { fg = bg, bg = orange },
  CurSearch = { fg = bg, bg = orange },
  Substitute = { fg = bg, bg = ember },
  MatchParen = { fg = mint, bg = forest, bold = true },
  StatusLine = { fg = bg, bg = moss, bold = true },
  StatusLineNC = { fg = bark, bg = BG_A },
  WinBar = { fg = c_text, bg = BG },
  WinBarNC = { fg = bark, bg = BG },
  TabLine = { fg = bark, bg = BG_A },
  TabLineFill = { bg = BG },
  TabLineSel = { fg = bg, bg = moss, bold = true },
  WinSeparator = { fg = bark, bg = BG },
  VertSplit = { fg = bark, bg = BG },
  Pmenu = { fg = c_text, bg = BG_A },
  PmenuSel = { fg = mint, bg = bg_sel, bold = true },
  PmenuSbar = { bg = bg2 },
  PmenuThumb = { bg = bark },
  PmenuKind = { fg = c_type, bg = BG_A },
  PmenuExtra = { fg = bark, bg = BG_A },
  WildMenu = { fg = bg, bg = gold },
  Folded = { fg = c_comment, bg = BG_A },
  FoldColumn = { fg = bark, bg = "none" },
  SignColumn = { bg = "none" },
  NonText = { fg = bark },
  Whitespace = { fg = "#3a352c" },
  EndOfBuffer = { fg = clear and bark or bg },
  Directory = { fg = c_type },
  Title = { fg = c_func, bold = true },
  Question = { fg = c_hint },
  ModeMsg = { fg = c_keyword, bold = true },
  MsgArea = { fg = c_text },
  MoreMsg = { fg = c_hint },
  WarningMsg = { fg = c_warn },
  ErrorMsg = { fg = c_error },
  Conceal = { fg = bark },
  SpecialKey = { fg = bark },
  Cursor = { fg = bg, bg = sand },
  lCursor = { fg = bg, bg = sand },
  TermCursor = { fg = bg, bg = gold },
  QuickFixLine = { bg = forest, bold = true },
  SpellBad = { undercurl = true, sp = c_error },
  SpellCap = { undercurl = true, sp = c_warn },
  SpellLocal = { undercurl = true, sp = c_info },
  SpellRare = { undercurl = true, sp = c_hint },

  -- ── diagnostics ──────────────────────────────────────────
  DiagnosticError = { fg = c_error },
  DiagnosticWarn = { fg = c_warn },
  DiagnosticInfo = { fg = c_info },
  DiagnosticHint = { fg = c_hint },
  DiagnosticOk = { fg = green },
  DiagnosticUnderlineError = { undercurl = true, sp = c_error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c_warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c_info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c_hint },
  DiagnosticUnderlineOk = { undercurl = true, sp = green },
  DiagnosticVirtualTextError = { fg = c_error },
  DiagnosticVirtualTextWarn = { fg = c_warn },
  DiagnosticVirtualTextInfo = { fg = c_info },
  DiagnosticVirtualTextHint = { fg = c_hint },
  DiagnosticUnnecessary = { fg = bark, undercurl = true, sp = bark },
  DiagnosticDeprecated = { fg = bark, strikethrough = true },

  DiffAdd = { fg = green, bg = "#21301e" },
  DiffDelete = { fg = c_error, bg = "#2f1c16" },
  DiffChange = { fg = c_func, bg = "#2b2519" },
  DiffText = { fg = mint, bg = forest },
  Added = { fg = green },
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
  Ignore = { fg = bark },
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
  ["@markup.strong"] = { fg = mint, bold = true },
  ["@markup.italic"] = { fg = c_text, italic = true },
  ["@markup.strikethrough"] = { fg = bark, strikethrough = true },
  ["@markup.link"] = { fg = c_import, underline = true },
  ["@markup.link.url"] = { fg = c_type, underline = true },
  ["@markup.link.label"] = { fg = c_import },
  ["@markup.raw"] = { fg = c_string },
  ["@markup.raw.block"] = { fg = c_string },
  ["@markup.list"] = { fg = c_keyword },
  ["@markup.list.checked"] = { fg = green },
  ["@markup.list.unchecked"] = { fg = bark },
  ["@markup.quote"] = { fg = c_comment, italic = true },
  ["@diff.plus"] = { fg = green },
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

  LspReferenceText = { bg = forest },
  LspReferenceRead = { bg = forest },
  LspReferenceWrite = { bg = forest, underline = true },
  LspSignatureActiveParameter = { fg = c_func, bold = true },
  LspInlayHint = { fg = bark, bg = BG_A, italic = true },
  LspCodeLens = { fg = bark, italic = true },

  -- ── plugin surfaces ──────────────────────────────────────
  TelescopeNormal = { fg = c_text, bg = BG_A },
  TelescopeBorder = { fg = bark, bg = BG_A },
  TelescopeSelection = { fg = mint, bg = bg_sel },
  TelescopeSelectionCaret = { fg = c_keyword, bg = bg_sel },
  TelescopeMatching = { fg = c_func, bold = true },
  TelescopePromptTitle = { fg = bg, bg = c_keyword, bold = true },
  TelescopeResultsTitle = { fg = bg, bg = moss, bold = true },
  TelescopePreviewTitle = { fg = bg, bg = green, bold = true },
  NeoTreeNormal = { fg = c_text, bg = BG },
  NeoTreeNormalNC = { fg = c_text, bg = BG },
  NeoTreeDirectoryName = { fg = c_type },
  NeoTreeDirectoryIcon = { fg = c_type },
  NeoTreeRootName = { fg = c_keyword, bold = true },
  NeoTreeIndentMarker = { fg = bark },
  NeoTreeGitModified = { fg = c_func },
  NeoTreeGitAdded = { fg = green },
  NeoTreeGitDeleted = { fg = c_error },
  NeoTreeGitUntracked = { fg = c_import },
  NvimTreeNormal = { fg = c_text, bg = BG },
  NvimTreeFolderName = { fg = c_type },
  NvimTreeFolderIcon = { fg = c_type },
  NvimTreeRootFolder = { fg = c_keyword, bold = true },
  NvimTreeIndentMarker = { fg = bark },
  WhichKeyFloat = { bg = BG_A },
  WhichKeyNormal = { bg = BG_A },
  WhichKey = { fg = c_keyword },
  WhichKeyGroup = { fg = c_type },
  WhichKeyDesc = { fg = c_text },
  WhichKeySeparator = { fg = bark },
  GitSignsAdd = { fg = green },
  GitSignsChange = { fg = c_func },
  GitSignsDelete = { fg = c_error },
  GitSignsCurrentLineBlame = { fg = bark, italic = true },
  CmpItemAbbr = { fg = c_text },
  CmpItemAbbrDeprecated = { fg = bark, strikethrough = true },
  CmpItemAbbrMatch = { fg = c_func, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = c_func },
  CmpItemKind = { fg = c_type },
  CmpItemMenu = { fg = bark },
  BlinkCmpMenu = { fg = c_text, bg = BG_A },
  BlinkCmpMenuBorder = { fg = bark, bg = BG_A },
  BlinkCmpMenuSelection = { fg = mint, bg = bg_sel, bold = true },
  BlinkCmpLabelMatch = { fg = c_func, bold = true },
  BlinkCmpKind = { fg = c_type },
  BlinkCmpDoc = { fg = c_text, bg = BG_A },
  BlinkCmpDocBorder = { fg = bark, bg = BG_A },
  SnacksNormal = { fg = c_text, bg = BG_A },
  SnacksWinBar = { fg = c_func, bg = BG_A, bold = true },
  SnacksBackdrop = { bg = bg },
  SnacksDashboardHeader = { fg = green },
  SnacksDashboardIcon = { fg = c_keyword },
  SnacksDashboardDesc = { fg = c_text },
  SnacksDashboardKey = { fg = c_func },
  SnacksDashboardFooter = { fg = c_comment },
  SnacksPickerMatch = { fg = c_func, bold = true },
  SnacksPickerDir = { fg = bark },
  SnacksIndent = { fg = "#2f2f2f" },
  SnacksIndentScope = { fg = bark },
  IblIndent = { fg = "#2f2f2f" },
  IblScope = { fg = bark },
  MiniIndentscopeSymbol = { fg = bark },
  FlashLabel = { fg = bg, bg = c_error, bold = true },
  FlashMatch = { fg = mint, bg = forest },
  TroubleNormal = { fg = c_text, bg = BG_A },
  TroubleText = { fg = c_text },
  TroubleCount = { fg = c_func, bold = true },
  LazyNormal = { fg = c_text, bg = BG_A },
  LazyH1 = { fg = bg, bg = moss, bold = true },
  LazyButtonActive = { fg = bg, bg = c_func, bold = true },
  LazyProgressDone = { fg = green },
  MasonNormal = { fg = c_text, bg = BG_A },
  MasonHeader = { fg = bg, bg = moss, bold = true },
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
  IlluminatedWordText = { bg = forest },
  IlluminatedWordRead = { bg = forest },
  IlluminatedWordWrite = { bg = forest },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── terminal palette ────────────────────────────────────────
vim.g.terminal_color_0 = bg2
vim.g.terminal_color_1 = ember
vim.g.terminal_color_2 = green_d
vim.g.terminal_color_3 = gold
vim.g.terminal_color_4 = moss
vim.g.terminal_color_5 = rust
vim.g.terminal_color_6 = olive
vim.g.terminal_color_7 = sand
vim.g.terminal_color_8 = bark
vim.g.terminal_color_9 = "#cf7554"
vim.g.terminal_color_10 = green
vim.g.terminal_color_11 = sand
vim.g.terminal_color_12 = sage
vim.g.terminal_color_13 = orange
vim.g.terminal_color_14 = mint
vim.g.terminal_color_15 = "#e8dcb4"
