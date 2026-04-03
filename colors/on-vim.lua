local pc = dofile(os.getenv("HOME") .. "/.cache/wal/colors.lua")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "on-vim"

local c = {
	bg = pc.background,
	fg = pc.foreground,
	red = pc.color1,
	green = pc.color2,
	blue = pc.color3,
	magenta = pc.color4,
	yellow = pc.color5,
	cyan = pc.color6,
	gray = pc.color7,
	comment = pc.color9,
	cursor = pc.color8,
}

local hl = function(g, opts)
	vim.api.nvim_set_hl(0, g, opts)
end

hl("Normal", { fg = c.fg, bg = "NONE" })
hl("NormalFloat", { fg = c.fg, bg = c.bg })
hl("Cursor", { fg = c.fg, bg = c.red })
hl("LineNr", { fg = c.fg, bg = c.bg })
hl("CursorLineNr", { fg = c.fg, bg = c.red })
hl("Comment", { fg = c.fg, bg = c.bg })
hl("Visual", { fg = c.fg, bg = c.green })
hl("StatusLine", { fg = c.fg, bg = c.bg })

-- syntax

hl("Keyword", { fg = c.magenta, bold = true })
hl("Function", { fg = c.blue })
hl("String", { fg = c.green })
hl("Number", { fg = c.yellow })
hl("Type", { fg = c.cyan })
hl("Constant", { fg = c.red })
hl("Operator", { fg = c.fg })
hl("Delimiter", { fg = c.fg })

-- LSP

hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.cyan })

-- ETC
hl("@variable", { fg = c.fg })
hl("@property", { fg = c.green })
hl("@type.builtin", { fg = c.cyan })
hl("@keyword.modifier", { fg = c.cyan })
hl("@keyword.import", { fg = c.magenta })
hl("@variable.builtin", { fg = c.red })
hl("@function", { fg = c.blue })
hl("@function.call", { fg = c.blue })
hl("@keyword", { fg = c.magenta, bold = true })
hl("@string", { fg = c.green })
hl("@comment", { fg = c.comment, italic = true })
hl("@type", { fg = c.cyan })
hl("@tag", { fg = c.red })
hl("@attribute", { fg = c.yellow })
hl("@punctuation", { fg = c.green })
hl("@punctuation.bracket", { fg = c.cursor })
hl("@constructor", { fg = c.green })

hl("ModeMsg", { fg = c.red })
hl("MoreMsg", { fg = c.red })
hl("Question", { fg = c.red })

hl("Tag", { fg = c.red })
hl("Special", { fg = c.red })
hl("SpecialChar", { fg = c.red })
hl("SpecialComment", { fg = c.red })
hl("Debug", { fg = c.red })

hl("lualine_a_normal", { fg = c.bg, bg = c.blue })
hl("lualine_b_normal", { fg = c.fg, bg = c.red })
hl("lualine_c_normal", { fg = c.fg, bg = c.red })

hl("lualine_a_insert", { fg = c.fg, bg = c.green })
hl("lualine_a_replace", { fg = c.fg, bg = c.red })
hl("lualine_a_command", { fg = c.fg, bg = c.yellow })

hl("lualine_a_inactive", { fg = c.gray, bg = "NONE" })
hl("lualine_b_inactive", { fg = c.gray, bg = "NONE" })
hl("lualine_c_inactive", { fg = c.gray, bg = "NONE" })
