vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "matrix"
vim.o.termguicolors = true
vim.o.background = "dark"

local bg = "#050D07"
local bg_alt = "#0A140C"
local green = "#5AFD12" -- solid green: body text
local lgreen = "#5AFF7F" -- light green: functions, definitions
local cyan = "#3BE8D0" -- glow: keywords, control flow
local yellow = "#D9C64A" -- strings, numbers, constants
local dim = "#0E4A22" -- comments, gutter, punctuation
local red = "#8FB13A" -- errors: yellow-green, stays in palette

local hl = {
  -- editor chrome
  Normal = { fg = green, bg = bg },
  NormalFloat = { fg = green, bg = bg_alt },
  FloatBorder = { fg = dim, bg = bg_alt },
  LineNr = { fg = dim },
  CursorLineNr = { fg = lgreen, bold = true },
  CursorLine = { bg = bg_alt },
  SignColumn = { bg = "none" },
  ColorColumn = { bg = bg_alt },
  Visual = { bg = "#0A2E14" },
  Search = { fg = bg, bg = lgreen },
  IncSearch = { fg = bg, bg = cyan },
  MatchParen = { fg = cyan, bold = true },
  StatusLine = { fg = bg, bg = lgreen, bold = true },
  StatusLineNC = { fg = green, bg = bg_alt },
  WinSeparator = { fg = dim },
  Pmenu = { fg = green, bg = bg_alt },
  PmenuSel = { fg = bg, bg = cyan },
  Folded = { fg = dim, bg = bg_alt },
  NonText = { fg = dim },
  EndOfBuffer = { fg = bg },
  Directory = { fg = cyan },
  Title = { fg = lgreen, bold = true },

  -- diagnostics
  DiagnosticError = { fg = red },
  DiagnosticWarn = { fg = yellow },
  DiagnosticInfo = { fg = cyan },
  DiagnosticHint = { fg = lgreen },
  DiffAdd = { fg = lgreen, bg = "#062E12" },
  DiffDelete = { fg = red, bg = "#1A2205" },
  DiffChange = { fg = yellow, bg = "#12200A" },
  DiffText = { fg = cyan, bg = "#0A2E28" },

  -- legacy vim groups, so non-treesitter buffers still look right
  Comment = { fg = dim, italic = true },
  Constant = { fg = yellow },
  String = { fg = yellow },
  Character = { fg = yellow },
  Number = { fg = yellow },
  Boolean = { fg = cyan },
  Identifier = { fg = green },
  Function = { fg = lgreen },
  Statement = { fg = cyan },
  Keyword = { fg = cyan },
  PreProc = { fg = cyan, italic = true },
  Type = { fg = lgreen },
  Special = { fg = cyan },
  Error = { fg = red, bold = true },
  Todo = { fg = bg, bg = yellow, bold = true },

  -- treesitter: general
  ["@comment"] = { fg = dim, italic = true },
  ["@comment.documentation"] = { fg = dim, italic = true },
  ["@keyword"] = { fg = cyan },
  ["@keyword.function"] = { fg = cyan },
  ["@keyword.return"] = { fg = cyan, bold = true },
  ["@keyword.conditional"] = { fg = cyan },
  ["@keyword.repeat"] = { fg = cyan },
  ["@keyword.operator"] = { fg = cyan },
  ["@keyword.exception"] = { fg = cyan, bold = true },
  ["@keyword.import"] = { fg = cyan, italic = true },
  ["@keyword.modifier"] = { fg = cyan, italic = true },
  ["@function"] = { fg = lgreen },
  ["@function.call"] = { fg = lgreen },
  ["@function.method"] = { fg = lgreen },
  ["@function.method.call"] = { fg = lgreen },
  ["@function.builtin"] = { fg = lgreen, italic = true },
  ["@constructor"] = { fg = lgreen, bold = true },
  ["@type"] = { fg = lgreen, bold = true },
  ["@type.builtin"] = { fg = lgreen },
  ["@type.qualifier"] = { fg = cyan, italic = true },
  ["@variable"] = { fg = green },
  ["@variable.member"] = { fg = green },
  ["@variable.parameter"] = { fg = green, italic = true },
  ["@variable.builtin"] = { fg = cyan, italic = true },
  ["@property"] = { fg = green },
  ["@field"] = { fg = green },
  ["@constant"] = { fg = yellow, bold = true },
  ["@constant.builtin"] = { fg = yellow, bold = true },
  ["@constant.macro"] = { fg = yellow, bold = true },
  ["@string"] = { fg = yellow },
  ["@string.escape"] = { fg = cyan },
  ["@string.special"] = { fg = cyan },
  ["@character"] = { fg = yellow },
  ["@number"] = { fg = yellow },
  ["@number.float"] = { fg = yellow },
  ["@boolean"] = { fg = cyan },
  ["@operator"] = { fg = cyan },
  ["@punctuation"] = { fg = dim },
  ["@punctuation.bracket"] = { fg = dim },
  ["@punctuation.delimiter"] = { fg = dim },
  ["@punctuation.special"] = { fg = cyan },
  ["@attribute"] = { fg = cyan, italic = true },
  ["@label"] = { fg = cyan },
  ["@module"] = { fg = lgreen, italic = true },
  ["@namespace"] = { fg = lgreen, italic = true },

  -- C/C++ specifics
  ["@keyword.directive"] = { fg = cyan, italic = true },
  ["@keyword.directive.define"] = { fg = cyan, italic = true },
  ["@string.special.path"] = { fg = yellow, italic = true },
  ["@type.definition"] = { fg = lgreen, bold = true },

  -- Python specifics
  ["@keyword.type"] = { fg = cyan },
  ["@function.decorator"] = { fg = cyan, italic = true },
  ["@string.documentation"] = { fg = yellow, italic = true },

  -- markup, for markdown notes
  ["@markup.heading"] = { fg = lgreen, bold = true },
  ["@markup.strong"] = { fg = lgreen, bold = true },
  ["@markup.italic"] = { fg = green, italic = true },
  ["@markup.link"] = { fg = cyan, underline = true },
  ["@markup.raw"] = { fg = yellow },
  ["@markup.list"] = { fg = cyan },

  -- LSP semantic tokens, which override treesitter when active
  ["@lsp.type.class"] = { fg = lgreen, bold = true },
  ["@lsp.type.function"] = { fg = lgreen },
  ["@lsp.type.method"] = { fg = lgreen },
  ["@lsp.type.macro"] = { fg = cyan, bold = true },
  ["@lsp.type.namespace"] = { fg = lgreen, italic = true },
  ["@lsp.type.parameter"] = { fg = green, italic = true },
  ["@lsp.type.property"] = { fg = green },
  ["@lsp.type.variable"] = { fg = green },
  ["@lsp.type.enumMember"] = { fg = yellow, bold = true },
  ["@lsp.type.keyword"] = { fg = cyan },
  ["@lsp.type.type"] = { fg = lgreen, bold = true },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- terminal colors, so :terminal matches
vim.g.terminal_color_0 = bg
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = green
vim.g.terminal_color_3 = yellow
vim.g.terminal_color_4 = cyan
vim.g.terminal_color_5 = lgreen
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = green
vim.g.terminal_color_8 = dim
vim.g.terminal_color_9 = red
vim.g.terminal_color_10 = lgreen
vim.g.terminal_color_11 = yellow
vim.g.terminal_color_12 = cyan
vim.g.terminal_color_13 = lgreen
vim.g.terminal_color_14 = cyan
vim.g.terminal_color_15 = lgreen
