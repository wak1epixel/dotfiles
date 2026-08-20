vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "matrix-lite"
vim.o.termguicolors = true
vim.o.background = "dark"

-- ══════════════════════════════════════════════════════════
-- BACKGROUND — tweak these two to taste.
-- bg is the editor background, bg_alt is floats/cursorline/pmenu.
-- Darker:  bg = "#050D07"   bg_alt = "#0A140C"
-- Current: bg = "#0A1A0E"   bg_alt = "#112215"
-- Lighter: bg = "#102416"   bg_alt = "#183020"
-- ══════════════════════════════════════════════════════════
local bg = "#050D07"
local bg_alt = "#0A140C"

local white = "#E8EDE9" -- body text: variables, properties, params
local white_d = "#A8B4AA" -- dimmer white: punctuation, operators
local green = "#3FD666" -- strings, numbers, constants, imports
local lgreen = "#7CFF9E" -- functions, types, definitions
local dim = "#2E5C3A" -- comments, gutter, folds
local cyan = "#00FFF0" -- RARE: return/throw, escapes, macros, self/this
local red = "#FF5F5F" -- errors only — the one out-of-palette color

local hl = {
  -- editor chrome
  Normal = { fg = white, bg = bg },
  NormalFloat = { fg = white, bg = bg_alt },
  FloatBorder = { fg = green, bg = bg_alt },
  LineNr = { fg = dim },
  CursorLineNr = { fg = lgreen, bold = true },
  CursorLine = { bg = bg_alt },
  ColorColumn = { bg = bg_alt },
  Visual = { bg = "#1D3D26" },
  Search = { fg = bg, bg = lgreen },
  IncSearch = { fg = bg, bg = cyan },
  MatchParen = { fg = cyan, bold = true },
  StatusLine = { fg = bg, bg = green, bold = true },
  StatusLineNC = { fg = white_d, bg = bg_alt },
  WinSeparator = { fg = dim },
  Pmenu = { fg = white, bg = bg_alt },
  PmenuSel = { fg = bg, bg = lgreen },
  Folded = { fg = dim, bg = bg_alt },
  NonText = { fg = dim },
  EndOfBuffer = { fg = bg },
  SignColumn = { bg = "none" },
  Directory = { fg = lgreen },
  Title = { fg = lgreen, bold = true },

  -- diagnostics
  DiagnosticError = { fg = red },
  DiagnosticWarn = { fg = lgreen },
  DiagnosticInfo = { fg = white_d },
  DiagnosticHint = { fg = green },
  DiffAdd = { fg = lgreen, bg = "#0F2E17" },
  DiffDelete = { fg = red, bg = "#2E1212" },
  DiffChange = { fg = white, bg = "#1A2A1D" },
  DiffText = { fg = cyan, bg = "#0A2E2C" },

  -- legacy vim groups, for non-treesitter buffers
  Comment = { fg = dim, italic = true },
  Constant = { fg = green },
  String = { fg = green },
  Character = { fg = green },
  Number = { fg = green },
  Boolean = { fg = cyan },
  Identifier = { fg = white },
  Function = { fg = lgreen },
  Statement = { fg = white, bold = true },
  Keyword = { fg = white, bold = true },
  PreProc = { fg = green, italic = true },
  Type = { fg = lgreen },
  Special = { fg = cyan },
  Error = { fg = red, bold = true },
  Todo = { fg = bg, bg = lgreen, bold = true },

  -- treesitter: general
  ["@comment"] = { fg = dim, italic = true },
  ["@comment.documentation"] = { fg = dim, italic = true },
  ["@keyword"] = { fg = white, bold = true },
  ["@keyword.function"] = { fg = white, bold = true },
  ["@keyword.conditional"] = { fg = white, bold = true },
  ["@keyword.repeat"] = { fg = white, bold = true },
  ["@keyword.operator"] = { fg = white, bold = true },
  ["@keyword.modifier"] = { fg = white, bold = true },
  ["@keyword.return"] = { fg = cyan, bold = true },
  ["@keyword.exception"] = { fg = cyan, bold = true },
  ["@keyword.import"] = { fg = green, italic = true },
  ["@function"] = { fg = lgreen },
  ["@function.call"] = { fg = lgreen },
  ["@function.method"] = { fg = lgreen },
  ["@function.method.call"] = { fg = lgreen },
  ["@function.builtin"] = { fg = lgreen, italic = true },
  ["@constructor"] = { fg = lgreen, bold = true },
  ["@type"] = { fg = lgreen },
  ["@type.builtin"] = { fg = lgreen },
  ["@type.definition"] = { fg = lgreen, bold = true },
  ["@type.qualifier"] = { fg = white, bold = true },
  ["@variable"] = { fg = white },
  ["@variable.member"] = { fg = white },
  ["@variable.parameter"] = { fg = white, italic = true },
  ["@variable.builtin"] = { fg = cyan, italic = true },
  ["@property"] = { fg = white },
  ["@field"] = { fg = white },
  ["@constant"] = { fg = green, bold = true },
  ["@constant.builtin"] = { fg = green, bold = true },
  ["@constant.macro"] = { fg = cyan, bold = true },
  ["@string"] = { fg = green },
  ["@string.escape"] = { fg = cyan },
  ["@string.special"] = { fg = cyan },
  ["@character"] = { fg = green },
  ["@number"] = { fg = green },
  ["@number.float"] = { fg = green },
  ["@boolean"] = { fg = cyan },
  ["@operator"] = { fg = white_d },
  ["@punctuation"] = { fg = white_d },
  ["@punctuation.bracket"] = { fg = white_d },
  ["@punctuation.delimiter"] = { fg = white_d },
  ["@punctuation.special"] = { fg = cyan },
  ["@attribute"] = { fg = green, italic = true },
  ["@label"] = { fg = green },
  ["@module"] = { fg = green, italic = true },
  ["@namespace"] = { fg = green, italic = true },

  -- C/C++
  ["@keyword.directive"] = { fg = green, italic = true },
  ["@keyword.directive.define"] = { fg = green, italic = true },
  ["@string.special.path"] = { fg = green, italic = true },

  -- Python
  ["@keyword.type"] = { fg = white, bold = true },
  ["@function.decorator"] = { fg = green, italic = true },
  ["@string.documentation"] = { fg = dim, italic = true },

  -- markup
  ["@markup.heading"] = { fg = lgreen, bold = true },
  ["@markup.strong"] = { fg = white, bold = true },
  ["@markup.italic"] = { fg = white, italic = true },
  ["@markup.link"] = { fg = cyan, underline = true },
  ["@markup.raw"] = { fg = green },
  ["@markup.list"] = { fg = green },

  -- LSP semantic tokens (override treesitter when clangd/pyright attach)
  ["@lsp.type.class"] = { fg = lgreen },
  ["@lsp.type.function"] = { fg = lgreen },
  ["@lsp.type.method"] = { fg = lgreen },
  ["@lsp.type.macro"] = { fg = cyan, bold = true },
  ["@lsp.type.namespace"] = { fg = green, italic = true },
  ["@lsp.type.parameter"] = { fg = white, italic = true },
  ["@lsp.type.property"] = { fg = white },
  ["@lsp.type.variable"] = { fg = white },
  ["@lsp.type.enumMember"] = { fg = green, bold = true },
  ["@lsp.type.keyword"] = { fg = white, bold = true },
  ["@lsp.type.type"] = { fg = lgreen },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

vim.g.terminal_color_0 = bg
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = green
vim.g.terminal_color_3 = lgreen
vim.g.terminal_color_4 = cyan
vim.g.terminal_color_5 = green
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = white
vim.g.terminal_color_8 = dim
vim.g.terminal_color_9 = red
vim.g.terminal_color_10 = lgreen
vim.g.terminal_color_11 = lgreen
vim.g.terminal_color_12 = cyan
vim.g.terminal_color_13 = green
vim.g.terminal_color_14 = cyan
vim.g.terminal_color_15 = white
